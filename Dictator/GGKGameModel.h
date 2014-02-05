//
//  GGKGameModel.h
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GGKPlayer.h"

@interface GGKGameModel : NSObject

// Players at the start of the game.
@property (strong, nonatomic) NSArray *allPlayersArray;

// Non-eliminated players.
@property (strong, nonatomic) NSMutableArray *remainingPlayersMutableArray;

// The player who's currently dictator.
@property (strong, nonatomic) GGKPlayer *currentDictatorPlayer;

// The player whose turn it is.
@property (strong, nonatomic) GGKPlayer *currentPlayer;
// Player currently being targeted (for exile, etc.)
@property (strong, nonatomic) GGKPlayer *currentlySelectedPlayer;
// Roles assigned to a specific game.
// Story: User assigns some roles, then adds/removes players, then comes back. User expects previously assigned roles to still be there.
@property (strong, nonatomic) NSArray *explicitlyAssignedRolesArray;

// The roles available to all games. May be increased via in-app purchase.
@property (strong, nonatomic) NSMutableArray *availableRolesMutableArray;

// Override.
- (id)init;

@end
