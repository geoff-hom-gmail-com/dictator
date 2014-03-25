//
//  GGKRole.m
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKRole.h"

#import "GGKGameModel.h"

NSString *GGKAssassinKeyString = @"Assassin";

NSString *GGKDoctorKeyString = @"Doctor";
// Key for storing a role's key.
NSString *GGKRoleKeyKeyString = @"Role key.";
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
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.key forKey:GGKRoleKeyKeyString];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *aKeyString = [aDecoder decodeObjectForKey:GGKRoleKeyKeyString];
    self = [[GGKRole alloc] initWithType:aKeyString];
//    self = [super init];
//    if (self) {
//        self.key = [aDecoder decodeObjectForKey:GGKRoleKeyKeyString];
//        self = [self initWithType:self.key];
//        self.role = [aDecoder decodeObjectForKey:GGKPlayerRoleKeyString];
//    }
    return self;
}
- (id)initWithType:(NSString *)theRoleKey {
    self = [super init];
    if (self) {
        self.key = theRoleKey;
        self.isTraitor = NO;
        self.youAreDictator1 = @"You may pick one player to exile.";
        self.startingCount = 0;
        if ([self.key isEqualToString:GGKTownspersonKeyString]) {
            self.name = @"Townsperson";
            self.longNameWithArticle = [NSString stringWithFormat:@"an Innocent %@", self.name];
            self.blurb1 = @"(Towns.) Townsperson blurb here";
            self.youAreBlurb1 = @"You are an Innocent Townsperson."
              "\n\nDuring the night, you have no action."
              "\n\nYou win with the Town.";
        } else if ([self.key isEqualToString:GGKTraitorKeyString]) {
            self.name = @"Traitor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.blurb1 = @"(Trait.) Traitor blurb1 here";
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Traitor."
            "\n\nDuring the night, you and the other Traitors choose one player to %@."
            "\n\nYou win with the Traitors.", GGKEliminateString];
        } else if ([self.key isEqualToString:GGKAssassinKeyString]) {
            self.name = @"Assassin";
            self.longNameWithArticle = [NSString stringWithFormat:@"an %@", self.name];
            self.isTraitor = YES;
            self.blurb1 = @"(Trait.) Assassin blurb1 here";
        } else if ([self.key isEqualToString:GGKDoctorKeyString]) {
            self.name = @"Doctor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.blurb1 = @"(Towns.) Doctor blurb1 here";
        } else {
            NSLog(@"Warning: unknown role:%@", self.key);
        }
    }
    return self;
}
@end
