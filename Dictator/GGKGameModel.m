//
//  GGKGameModel.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKGameModel.h"

#import "GGKRole.h"

@implementation GGKGameModel
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
    NSInteger theNumberOfPlayersEliminated = [thePlayersWithMostVotesMutableArray count];
    if (theNumberOfPlayersEliminated == 1) {
        self.playersEliminatedLastNightArray = [thePlayersWithMostVotesMutableArray copy];
    } else if (theNumberOfPlayersEliminated == 0) {
        self.playersEliminatedLastNightArray = nil;
    } else if (theNumberOfPlayersEliminated > 1) {
        NSInteger aRandomIndex = arc4random_uniform(theNumberOfPlayersEliminated);
        GGKPlayer *theEliminatedPlayer = [thePlayersWithMostVotesMutableArray objectAtIndex:aRandomIndex];
        self.playersEliminatedLastNightArray = [NSArray arrayWithObject:theEliminatedPlayer];
    }
    // see if someone was saved by the doctor, etc.
    // adjust arrays as necesary
}
- (id)init {
    self = [super init];
    if (self) {
        
        self.allPlayersArray = [NSArray array];
        
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
@end
