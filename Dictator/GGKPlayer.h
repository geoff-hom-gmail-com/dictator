//
//  GGKPlayer.h
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GGKRole.h"

@interface GGKPlayer : NSObject

// Player's name.
@property (strong, nonatomic) NSString *name;

// Player's role in the current game.
@property (strong, nonatomic) GGKRole *role;

// Override.
- (id)init;

@end
