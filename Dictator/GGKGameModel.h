//
//  GGKGameModel.h
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GGKPlayer.h"

// Keys for saving data.
extern NSString *GGKElectionHasTimeLimitBOOLKeyString;

// Verb for a player being removed at night.
extern NSString *GGKEliminateString;
// Verb, capitalized, for a player being removed at night.
extern NSString *GGKEliminateTitleString;
// Verb, past tense, for a player being removed at night.
extern NSString *GGKEliminatedString;
// Noun for a player being removed at night.
extern NSString *GGKEliminationString;
// Verb for a player being removed during the day.
extern NSString *GGKExileString;
// Verb, capitalized, for a player being removed during the day.
extern NSString *GGKExileTitleString;
// Verb, past tense, for a player being removed during the day.
extern NSString *GGKExiledString;

@interface GGKGameModel : NSObject

// Players at the start of a game.
@property (strong, nonatomic) NSMutableArray *allPlayersMutableArray;
// The roles available to all games. May be increased via in-app purchase.
@property (strong, nonatomic) NSMutableArray *availableRolesMutableArray;
// The player who's currently dictator.
@property (strong, nonatomic) GGKPlayer *currentDictatorPlayer;
// The player whose turn it is.
@property (strong, nonatomic) GGKPlayer *currentPlayer;
// Player currently being targeted (for exile, etc.)
@property (strong, nonatomic) GGKPlayer *currentlySelectedPlayer;
// Whether to exile the current Dictator by Judge decree.
@property (assign, nonatomic) BOOL doJudgeExileDictatorBOOL;
// Whether to have a timer when electing the Dictator.
// Custom accessors.
@property (assign, nonatomic) BOOL electionHasTimeLimitBOOL;
// Roles assigned to a specific game.
// Story: User assigns some roles, then adds/removes players, then comes back. User expects previously assigned roles to still be there.
@property (strong, nonatomic) NSArray *explicitlyAssignedRolesArray;
// Whether a Hermit was elected Dictator today.
@property (assign, nonatomic) BOOL hermitWasDictator;
// A round is just passing the device around to all players. After the last player checks the device, we can go to the next step.
@property (strong, nonatomic) GGKPlayer *lastPlayerThisRound;
// The players eliminated last night by Traitors.
// Currently, either nil or 1 player.
@property (strong, nonatomic) NSMutableArray *playersEliminatedLastNightMutableArray;
// Players to save from elimination tonight.
@property (strong, nonatomic) NSMutableArray *playersToSaveMutableArray;
// Players to eliminate tonight via the Vigilantes.
@property (strong, nonatomic) NSMutableArray *playersToVigilanteEliminateMutableArray;
// Players affected by multiple Gossips.
@property (strong, nonatomic) NSMutableArray *playersWithOverwhelmingGossipMutableArray;
// Players affected by one Gossip.
@property (strong, nonatomic) NSMutableArray *playersWithRegularGossipMutableArray;
// Non-eliminated players.
@property (strong, nonatomic) NSMutableArray *remainingPlayersMutableArray;
// Whether there was a tie at night from the Traitors.
@property (nonatomic, assign) BOOL thereWasATieBOOL;
// Whether the Townspeople won.
@property (nonatomic, assign) BOOL townDidWinBOOL;
// Add a player with the given name to the permanent roster.
- (void)addPlayerWithName:(NSString *)theName;
// Resolve what happened last night.
- (void)calculateNightSummary;
// Delete all players from roster; i.e., start a new permanent roster.
- (void)deleteAllPlayers;
// Remove the player from the permanent roster.
- (void)deletePlayer:(GGKPlayer *)thePlayerToDelete;
// Return players who can be Dictator today. Some roles affect this. (E.g., Gossip.)
- (NSArray *)electablePlayersArray;
// Override.
- (id)init;
// Return whether the game is over.
// Currently, if no more Traitors, the Townspeople win. If the number of Traitors ≥ the number of Townspeople, then the Traitors win.
- (BOOL)isGameOver;
// Move the player to the given position in the roster.
- (void)movePlayer:(GGKPlayer *)thePlayerToMove toIndex:(NSUInteger)theIndex;
// Set up for night phase.
- (void)prepForNight;
// Player is removed from game. If Dictator, then current player is previous player.
- (void)removePlayer:(GGKPlayer *)thePlayer;
@end
