//
//  GGKRole.m
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKRole.h"

#import "GGKGameModel.h"

// Keys for saving data.
NSString *GGKAssassinKeyString = @"Assassin";
NSString *GGKDoctorKeyString = @"Doctor";
NSString *GGKPrivateEyeKeyString = @"Private Eye";
// Key for storing a role's key.
NSString *GGKRoleKeyKeyString = @"Role key.";
NSString *GGKTownspersonKeyString = @"Townsperson";
NSString *GGKTraitorKeyString = @"Traitor";

@implementation GGKRole

+ (GGKRole *)role:(NSString *)theDesiredRoleKey fromArray:(NSArray *)theArray {
    GGKRole *theDesiredRole = nil;
    for (GGKRole *aRole in theArray) {
        if ([aRole.key isEqualToString:theDesiredRoleKey]) {
            theDesiredRole = aRole;
            break;
        }
    }
    return theDesiredRole;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.key forKey:GGKRoleKeyKeyString];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *aKeyString = [aDecoder decodeObjectForKey:GGKRoleKeyKeyString];
    self = [[GGKRole alloc] initWithType:aKeyString];
    return self;
}
- (id)initWithType:(NSString *)theRoleKey {
    self = [super init];
    if (self) {
        self.key = theRoleKey;
        self.isTraitor = NO;
        self.youAreDictator1 = [NSString stringWithFormat:@"You may pick one player to %@.", GGKExileString];
        self.startingCount = 0;
        if ([self.key isEqualToString:GGKTownspersonKeyString]) {
            self.name = @"Townsperson";
            self.longNameWithArticle = [NSString stringWithFormat:@"an Innocent %@", self.name];
            self.shortBlurb = @"(Towns.) Townsperson blurb here";
            self.longBlurb = self.shortBlurb;
            self.youAreBlurb1 = @"You are an Innocent Townsperson."
              "\n\nDuring the night, you have no action."
              "\n\nYou win with the Town.";
        } else if ([self.key isEqualToString:GGKTraitorKeyString]) {
            self.name = @"Traitor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Traitor blurb1 here";
            self.longBlurb = self.shortBlurb;
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Traitor."
            "\n\nDuring the night, you and the other Traitors choose one player to %@."
            "\n\nYou win with the Traitors.", GGKEliminateString];
        } else if ([self.key isEqualToString:GGKPrivateEyeKeyString]) {
            self.name = @"Private Eye";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Private Eye blurb here";
            self.longBlurb = @"During the night, the Private Eye selects one player other than herself. The game then tells the Private Eye if her target wins with the traitors or with the town.";
        } else if ([self.key isEqualToString:GGKAssassinKeyString]) {
            self.name = @"Assassin";
            self.longNameWithArticle = [NSString stringWithFormat:@"an %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Assassin blurb1 here";
            self.longBlurb = self.shortBlurb;
        } else if ([self.key isEqualToString:GGKDoctorKeyString]) {
            self.name = @"Doctor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Doctor blurb1 here";
            self.longBlurb = self.shortBlurb;
        } else {
            NSLog(@"Warning: unknown role:%@", self.key);
        }
    }
    return self;
}
@end
