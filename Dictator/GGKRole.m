//
//  GGKRole.m
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKRole.h"

NSString *GGKAssassinKeyString = @"Assassin";

NSString *GGKDoctorKeyString = @"Doctor";

NSString *GGKTownspersonKeyString = @"Townsperson";

NSString *GGKTraitorKeyString = @"Traitor";

@implementation GGKRole

+ (GGKRole *)role:(NSString *)theDesiredRoleKey fromArray:(NSArray *)theArray
{
    GGKRole *theDesiredRole = nil;
    for (GGKRole *aRole in theArray) {
        
        if ([aRole.key isEqualToString:theDesiredRoleKey]) {
            
            theDesiredRole = aRole;
            break;
        }
    }
    return theDesiredRole;
}

- (id)initWithType:(NSString *)theRoleKey
{
    self = [super init];
    if (self) {
        
        if ([theRoleKey isEqualToString:GGKTownspersonKeyString]) {
            
            self.key = theRoleKey;
            self.name = @"Townsperson";
            self.isTraitor = NO;
            self.blurb1 = @"(Towns.) Townsperson blurb here";
            self.youAreBlurb1 = @"You are an Innocent Townsperson."
              "\n\nDuring the night, you have no action."
              "\n\nYou win with the Town.";
            self.youAreDictator1 = @"Your powers allow you to X.";
            self.startingCount = 0;
        } else if ([theRoleKey isEqualToString:GGKTraitorKeyString]) {
            
            self.key = theRoleKey;
            self.name = @"Traitor";
            self.isTraitor = YES;
            self.blurb1 = @"(Trait.) Traitor blurb1 here";
            self.youAreBlurb1 = @"You are a Traitor."
            "\n\nDuring the night, you and the other Traitors choose one player to kill."
            "\n\nYou win with the Traitors.";
            self.youAreDictator1 = @"Your powers allow you to X.";
            self.startingCount = 0;
        } else if ([theRoleKey isEqualToString:GGKAssassinKeyString]) {
            
            self.key = theRoleKey;
            self.name = @"Assassin";
            self.isTraitor = YES;
            self.blurb1 = @"(Trait.) Assassin blurb1 here";
            self.startingCount = 0;
        } else if ([theRoleKey isEqualToString:GGKDoctorKeyString]) {
            
            self.key = theRoleKey;
            self.name = @"Doctor";
            self.isTraitor = NO;
            self.blurb1 = @"(Towns.) Doctor blurb1 here";
            self.startingCount = 0;
        } else {
            
            NSLog(@"Warning: unknown role:%@", theRoleKey);
        }
    }
    return self;
}

@end
