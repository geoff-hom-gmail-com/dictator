//
//  GGKRole.h
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

// Keys for saving data.
extern NSString *GGKAssassinKeyString;
extern NSString *GGKDarkJudgeKeyString;
extern NSString *GGKDoctorKeyString;
extern NSString *GGKHermitKeyString;
extern NSString *GGKKingpinKeyString;
extern NSString *GGKPrivateEyeKeyString;
extern NSString *GGKTownspersonKeyString;
extern NSString *GGKTraitorKeyString;
extern NSString *GGKVigilanteKeyString;

@interface GGKRole : NSObject <NSCoding>
// Whether this role is a traitorous one.
@property (assign, nonatomic) BOOL isTraitor;
// Unique ID for this role.
@property (strong, nonatomic) NSString *key;
// Description for the role. Shown on own screen when choosing roles for the game.
@property (strong, nonatomic) NSString *longBlurb;
// Long name/title preceded by an article. E.g., "an Innocent Townsperson."
@property (strong, nonatomic) NSString *longNameWithArticle;
// Role's name/title. E.g., "Townsperson," "Traitor," "Assassin."
@property (strong, nonatomic) NSString *name;
// One-line description for the role. Shown in table when choosing roles for the game.
@property (strong, nonatomic) NSString *shortBlurb;
// How many of that role are in the game at the start.
@property (assign, nonatomic) NSInteger startingCount;

// Description for the role if you are that role. Shown during pregame.
@property (strong, nonatomic) NSString *youAreBlurb1;

// Description if you are this role and also dictator. Shown after election.
@property (strong, nonatomic) NSString *youAreDictator1;

// Return the given role from the given array.
+ (GGKRole *)role:(NSString *)theDesiredRoleKey fromArray:(NSArray *)theArray;
// NSCoding protocol.
- (void)encodeWithCoder:(NSCoder *)aCoder;
// NSCoding protocol.
- (id)initWithCoder:(NSCoder *)aDecoder;
// Designated initializer
- (id)initWithType:(NSString *)theRoleKey;
@end
