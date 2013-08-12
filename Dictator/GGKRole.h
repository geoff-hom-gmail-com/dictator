//
//  GGKRole.h
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *GGKAssassinKeyString;

extern NSString *GGKDoctorKeyString;

// Key for the townsperson role.
extern NSString *GGKTownspersonKeyString;

extern NSString *GGKTraitorKeyString;

@interface GGKRole : NSObject

// Description for the role. Shown when choosing roles for the game.
@property (strong, nonatomic) NSString *blurb1;

// Whether this role is a traitorous one.
@property (assign, nonatomic) BOOL isTraitor;

// Unique ID for this role.
@property (strong, nonatomic) NSString *key;

// Role's name/title. E.g., "Townsperson," "Traitor," "Assassin."
@property (strong, nonatomic) NSString *name;

// How many of that role are in the game at the start.
@property (assign, nonatomic) NSInteger startingCount;

// Description for the role if you are that role. Shown during pregame.
@property (strong, nonatomic) NSString *youAreBlurb1;

// Return the given role from the given array.
+ (GGKRole *)role:(NSString *)theDesiredRoleKey fromArray:(NSArray *)theArray;

// Designated initializer
- (id)initWithType:(NSString *)theRoleKey;

@end
