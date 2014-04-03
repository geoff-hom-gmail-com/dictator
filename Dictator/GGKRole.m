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
NSString *GGKVigilanteKeyString = @"Vigilante";

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
                "\n\nYou win with the Town."
                "\n\nDuring the night, you have no action.";
        } else if ([self.key isEqualToString:GGKTraitorKeyString]) {
            self.name = @"Traitor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Traitor blurb1 here";
            self.longBlurb = self.shortBlurb;
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Traitor."
                                 "\n\nYou win with the Traitors."
                                 "\n\nDuring the night, you and the other Traitors choose one player to %@.", GGKEliminateString];
        } else if ([self.key isEqualToString:GGKPrivateEyeKeyString]) {
            self.name = @"Private Eye";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Private Eye blurb here";
            self.longBlurb = @"During the night, the Private Eye selects another player. The Private Eye learns whether that player wins with the Traitors or with the Town.";
            self.youAreBlurb1 = @"You are a Private Eye."
                "\n\nYou win with the Town."
                "\n\nDuring the night, you choose a player and learn whether she wins with the Traitors or with the Town.";
        } else if ([self.key isEqualToString:GGKDoctorKeyString]) {
            self.name = @"Doctor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Doctor blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"During the night, the Doctor selects another player. If someone attempts to %@ that player that night, she survives.", GGKEliminateString];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Doctor."
                                 "\n\nYou win with the Town."
                                 "\n\nDuring the night, you choose another player. If someone attempts to %@ her that night, she survives.", GGKEliminateString];
        } else if ([self.key isEqualToString:GGKVigilanteKeyString]) {
            self.name = @"Vigilante";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Vigilante blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"During the night, the Vigilante may select another player. That player is %@.", GGKEliminatedString];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Vigilante."
                                 "\n\nYou win with the Town."
                                 "\n\nDuring the night, you may choose another player. That player is %@.", GGKEliminatedString];
        } else if ([self.key isEqualToString:GGKAssassinKeyString]) {
            self.name = @"Assassin";
            self.longNameWithArticle = [NSString stringWithFormat:@"an %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Assassin blurb1 here";
            self.longBlurb = self.shortBlurb;
        } else {
            NSLog(@"Warning: unknown role:%@", self.key);
        }
    }
    return self;
}
@end
