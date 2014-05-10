//
//  GGKGameModel.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKGameModel.h"

#import "GGKRole.h"

// Keys for saving data.
// Key for storing data for all players.
NSString *GGKPlayersKeyString = @"Players data";

NSString *GGKEliminateString = @"eliminate";
NSString *GGKEliminateTitleString = @"Eliminate";
NSString *GGKEliminatedString = @"eliminated";
NSString *GGKEliminationString = @"elimination";
NSString *GGKExileString = @"exile";
NSString *GGKExileTitleString = @"Exile";
NSString *GGKExiledString = @"exiled";

@interface GGKGameModel ()
@end

@implementation GGKGameModel
- (void)addPlayerWithName:(NSString *)theName {
    GGKPlayer *aPlayer = [[GGKPlayer alloc] init];
    aPlayer.name = theName;
    [self.allPlayersMutableArray addObject:aPlayer];
    [self savePlayers];
}
- (void)calculateNightSummary {
    __block NSInteger theMostVotesInteger = 1;
    // Count how many votes (minimum 1) each player has. Most votes = eliminated. If a tie, choose randomly from those tied.
    NSMutableArray *thePlayersWithMostVotesMutableArray = [NSMutableArray arrayWithCapacity:5];
    [self.remainingPlayersMutableArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        if (aPlayer.numberOfVotesThisRoundInteger > theMostVotesInteger) {
            [thePlayersWithMostVotesMutableArray removeAllObjects];
            [thePlayersWithMostVotesMutableArray addObject:aPlayer];
            theMostVotesInteger = aPlayer.numberOfVotesThisRoundInteger;
        } else if (aPlayer.numberOfVotesThisRoundInteger == theMostVotesInteger) {
            [thePlayersWithMostVotesMutableArray addObject:aPlayer];
        }
    }];
    NSInteger theNumberOfPlayersWithMostVotes = [thePlayersWithMostVotesMutableArray count];
//    NSLog(@"players with most votes:%d votes:%d", theNumberOfPlayersWithMostVotes, theMostVotesInteger);
    NSMutableArray *thePlayersToEliminateMutableArray;
    self.thereWasATieBOOL = NO;
    if (theNumberOfPlayersWithMostVotes == 1) {
        thePlayersToEliminateMutableArray = [thePlayersWithMostVotesMutableArray mutableCopy];
    } else if (theNumberOfPlayersWithMostVotes == 0) {
        thePlayersToEliminateMutableArray = nil;
    } else if (theNumberOfPlayersWithMostVotes > 1) {
        NSInteger aRandomIndex = arc4random_uniform((uint32_t)theNumberOfPlayersWithMostVotes);
        GGKPlayer *theEliminatedPlayer = [thePlayersWithMostVotesMutableArray objectAtIndex:aRandomIndex];
        thePlayersToEliminateMutableArray = [NSMutableArray arrayWithObject:theEliminatedPlayer];
        self.thereWasATieBOOL = YES;
    }
    // How do I condense this? map?
    // Judge: exile Dictator.
    if (self.doJudgeExileDictatorBOOL) {
        if ([self.remainingPlayersMutableArray containsObject:self.currentDictatorPlayer]) {
            [self removePlayer:self.currentDictatorPlayer];
        }
    }
    // Gossip: overwhelming gossip exiles players.
    for (GGKPlayer *aPlayer in self.playersWithOverwhelmingGossipMutableArray) {
        if ([self.remainingPlayersMutableArray containsObject:aPlayer]) {
            [self removePlayer:aPlayer];
        } else {
            [self.playersWithOverwhelmingGossipMutableArray removeObject:aPlayer];
        }
    }
    // Doctor: save eliminated players.
    [thePlayersToEliminateMutableArray removeObjectsInArray:self.playersToSaveMutableArray];
    [self.playersToVigilanteEliminateMutableArray removeObjectsInArray:self.playersToSaveMutableArray];
    // Traitor: eliminate players.
    for (GGKPlayer *aPlayer in thePlayersToEliminateMutableArray) {
        if ([self.remainingPlayersMutableArray containsObject:aPlayer]) {
            [self removePlayer:aPlayer];
            [self.playersEliminatedLastNightMutableArray addObject:aPlayer];
        }
    }
    // Vigilante: eliminate players.
    for (GGKPlayer *aPlayer in self.playersToVigilanteEliminateMutableArray) {
        if ([self.remainingPlayersMutableArray containsObject:aPlayer]) {
            [self removePlayer:aPlayer];
        } else {
            [self.playersToVigilanteEliminateMutableArray removeObject:aPlayer];
        }
    }
    // Gossip: regular gossip prevents players from being Dictator.
    for (GGKPlayer *aPlayer in self.playersWithRegularGossipMutableArray) {
        // Remove exiled/eliminated players.
        if (![self.remainingPlayersMutableArray containsObject:aPlayer]) {
            [self.playersWithRegularGossipMutableArray removeObject:aPlayer];
        }
    }
}
- (void)deleteAllPlayers {
    [self.allPlayersMutableArray removeAllObjects];
    [self savePlayers];
}
- (void)deletePlayer:(GGKPlayer *)thePlayerToDelete {
    [self.allPlayersMutableArray removeObject:thePlayerToDelete];
    [self savePlayers];
}
- (NSArray *)electablePlayersArray {
    NSMutableArray *theElectablePlayersMutableArray = [NSMutableArray arrayWithCapacity:20];
    // If player is not being gossiped about, she can be elected.
    for (GGKPlayer *aPlayer in self.remainingPlayersMutableArray) {
        if (![self.playersWithRegularGossipMutableArray containsObject:aPlayer]) {
            [theElectablePlayersMutableArray addObject:aPlayer];
        }
    }
    return [theElectablePlayersMutableArray copy];
}
- (id)init {
    self = [super init];
    if (self) {
        // Players. If none, make an empty array.
        NSData *theData = [[NSUserDefaults standardUserDefaults] objectForKey:GGKPlayersKeyString];
        NSMutableArray *thePlayersMutableArray;
        if (theData == nil) {
            thePlayersMutableArray = [NSMutableArray arrayWithCapacity:10];
        } else {
            thePlayersMutableArray = [NSKeyedUnarchiver unarchiveObjectWithData:theData];
        }
        self.allPlayersMutableArray = thePlayersMutableArray;
        // Create available-roles array.
        // Order: Townsperson, Traitor, then alphabetically.
        GGKRole *aRole = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
        self.availableRolesMutableArray = [NSMutableArray arrayWithObject:aRole];
        // All roles.
//        for (NSString *aKeyString in @[GGKTraitorKeyString, GGKDarkJudgeKeyString, GGKDoctorKeyString, GGKGossipKeyString, GGKHermitKeyString, GGKKingpinKeyString, GGKPrivateEyeKeyString, GGKVigilanteKeyString]) {
//            aRole = [[GGKRole alloc] initWithType:aKeyString];
//            [self.availableRolesMutableArray addObject:aRole];
//        }
        for (NSString *aKeyString in @[GGKTraitorKeyString, GGKDoctorKeyString, GGKGossipKeyString, GGKKingpinKeyString, GGKPrivateEyeKeyString, GGKVigilanteKeyString]) {
            aRole = [[GGKRole alloc] initWithType:aKeyString];
            [self.availableRolesMutableArray addObject:aRole];
        }
        // The first day, everyone can be elected.
        self.playersWithRegularGossipMutableArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}
- (BOOL)isGameOver {
    BOOL gameIsOver = NO;
    // Count Traitors and Townspeople.
    __block NSInteger theNumberOfRemainingTraitorsInteger = 0;
    __block NSInteger theNumberOfRemainingTowniesInteger = 0;
    [self.remainingPlayersMutableArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        if (aPlayer.role.isTraitor) {
            theNumberOfRemainingTraitorsInteger++;
        } else {
            theNumberOfRemainingTowniesInteger++;
        }
    }];
    self.townDidWinBOOL = (theNumberOfRemainingTraitorsInteger == 0);
    if (self.townDidWinBOOL ||
        (theNumberOfRemainingTraitorsInteger >= theNumberOfRemainingTowniesInteger)) {
        gameIsOver = YES;
    }
    return gameIsOver;
}
- (void)movePlayer:(GGKPlayer *)thePlayerToMove toIndex:(NSUInteger)theIndex {
    [self.allPlayersMutableArray removeObject:thePlayerToMove];
    [self.allPlayersMutableArray insertObject:thePlayerToMove atIndex:theIndex];
    [self savePlayers];
}
- (void)prepForNight {
    // Reset night counters.
    [self.remainingPlayersMutableArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        aPlayer.numberOfVotesThisRoundInteger = 0;
    }];
    self.doJudgeExileDictatorBOOL = NO;
    self.playersEliminatedLastNightMutableArray = [NSMutableArray arrayWithCapacity:5];
    self.playersToSaveMutableArray = [NSMutableArray arrayWithCapacity:5];
    self.playersToVigilanteEliminateMutableArray = [NSMutableArray arrayWithCapacity:5];
    self.playersWithRegularGossipMutableArray = [NSMutableArray arrayWithCapacity:5];
    self.playersWithOverwhelmingGossipMutableArray = [NSMutableArray arrayWithCapacity:5];
    // Start to left of the current player/dictator. Will end with current player/dictator.
    self.lastPlayerThisRound = self.currentPlayer;
    NSInteger anIndex = [self.remainingPlayersMutableArray indexOfObject:self.currentPlayer];
    NSInteger theNextIndex = (anIndex + 1) % [self.remainingPlayersMutableArray count];
    self.currentPlayer = self.remainingPlayersMutableArray[theNextIndex];
}
- (void)removePlayer:(GGKPlayer *)thePlayer {
    // If the dictator exiled herself, make the previous person the current player.
    if (thePlayer == self.currentDictatorPlayer) {
        NSInteger anIndex = [self.remainingPlayersMutableArray indexOfObject:thePlayer];
        NSInteger thePreviousIndex = (anIndex - 1) % [self.remainingPlayersMutableArray count];
        self.currentDictatorPlayer = nil;
        self.currentPlayer = self.remainingPlayersMutableArray[thePreviousIndex];
    }
    [self.remainingPlayersMutableArray removeObject:thePlayer];
}
- (void)savePlayers {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.allPlayersMutableArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:GGKPlayersKeyString];
}
@end
