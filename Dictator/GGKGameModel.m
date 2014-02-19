//
//  GGKGameModel.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKGameModel.h"

#import "GGKRole.h"
// Key for storing data for all players.
NSString *GGKPlayersKeyString = @"Players data";
@interface GGKGameModel ()
// The Traitors eliminate players at night.
- (void)eliminatePlayers:(NSArray *)thePlayersToEliminateArray;
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
    __block NSMutableArray *thePlayersWithMostVotesMutableArray = [NSMutableArray arrayWithCapacity:5];
    [self.remainingPlayersMutableArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        if (aPlayer.numberOfVotesThisRoundInteger > theMostVotesInteger) {
            [thePlayersWithMostVotesMutableArray removeAllObjects];
            [thePlayersWithMostVotesMutableArray addObject:aPlayer];
        } else if (aPlayer.numberOfVotesThisRoundInteger == theMostVotesInteger) {
            [thePlayersWithMostVotesMutableArray addObject:aPlayer];
        }
    }];
    NSInteger theNumberOfPlayersWithMostVotes = [thePlayersWithMostVotesMutableArray count];
    NSArray *thePlayersToEliminateArray;
    if (theNumberOfPlayersWithMostVotes == 1) {
        thePlayersToEliminateArray = [thePlayersWithMostVotesMutableArray copy];
    } else if (theNumberOfPlayersWithMostVotes == 0) {
        thePlayersToEliminateArray = nil;
    } else if (theNumberOfPlayersWithMostVotes > 1) {
        NSInteger aRandomIndex = arc4random_uniform(theNumberOfPlayersWithMostVotes);
        GGKPlayer *theEliminatedPlayer = [thePlayersWithMostVotesMutableArray objectAtIndex:aRandomIndex];
        thePlayersToEliminateArray = [NSArray arrayWithObject:theEliminatedPlayer];
        self.thereWasATieBOOL = YES;
    }
    // see if someone was saved by the doctor, etc.
    [self eliminatePlayers:thePlayersToEliminateArray];
}
- (void)deleteAllPlayers {
    self.allPlayersMutableArray = [NSMutableArray arrayWithCapacity:10];
    [self savePlayers];
}
- (void)deletePlayer:(GGKPlayer *)thePlayerToDelete {
    [self.allPlayersMutableArray removeObject:thePlayerToDelete];
    [self savePlayers];
}
- (void)eliminatePlayers:(NSArray *)thePlayersToEliminateArray {
    [thePlayersToEliminateArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        
        [self.remainingPlayersMutableArray removeObject:aPlayer];
    }];
    self.playersEliminatedLastNightArray = thePlayersToEliminateArray;
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
        // Order presented should be Townsperson, Traitor, then alphabetically.
        
        // Townsperson.
        GGKRole *aRole = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
        self.availableRolesMutableArray = [NSMutableArray arrayWithObject:aRole];
        
        // Traitor.
        aRole = [[GGKRole alloc] initWithType:GGKTraitorKeyString];
        [self.availableRolesMutableArray addObject:aRole];
        
        // Just do these for my testing of the scrolling. Comment out for testers.
        
//        // Assassin.
//        aRole = [[GGKRole alloc] initWithType:GGKAssassinKeyString];
//        [self.availableRolesMutableArray addObject:aRole];
//        
//        // Doctor.
//        aRole = [[GGKRole alloc] initWithType:GGKDoctorKeyString];
//        [self.availableRolesMutableArray addObject:aRole];
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
    if ((theNumberOfRemainingTraitorsInteger == 0) ||
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
    // Start to left of the current player/dictator. Will end with current player/dictator.
    self.lastPlayerThisRound = self.currentPlayer;
    NSInteger anIndex = [self.remainingPlayersMutableArray indexOfObject:self.currentPlayer];
    NSInteger theNextIndex = (anIndex + 1) % [self.remainingPlayersMutableArray count];
    self.currentPlayer = self.remainingPlayersMutableArray[theNextIndex];
}
- (void)savePlayers {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.allPlayersMutableArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:GGKPlayersKeyString];
}
@end
