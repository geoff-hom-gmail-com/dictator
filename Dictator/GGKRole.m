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
NSString *GGKDarkJudgeKeyString = @"Dark Judge";
NSString *GGKDoctorKeyString = @"Doctor";
NSString *GGKGossipKeyString = @"Gossip";
NSString *GGKHermitKeyString = @"Hermit";
NSString *GGKKingpinKeyString = @"Kingpin";
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
            self.longBlurb = @"The Townsperson doesn’t have any powers, but don’t count her out! The Townsperson can put all her effort into sniffing out the Traitors and picking a good Dictator.";
            self.youAreBlurb1 = @"You are an Innocent Townsperson."
                "\n\nYou win with the Town."
                "\n\nDuring the night, you have no action.";
        } else if ([self.key isEqualToString:GGKTraitorKeyString]) {
            self.name = @"Traitor";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) abcdefghijklmnopqrstuvwxyz";
            self.longBlurb = [NSString stringWithFormat:@"The Traitor doesn’t have any powers on her own, but each night, the Traitors can %@ a Townsperson! The Traitors win if all the Townspeople are %@.", GGKEliminateString, GGKEliminatedString];
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
            self.shortBlurb = @"(Towns.) abcdefghijklmnopqrstuvwxy";
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
        } else if ([self.key isEqualToString:GGKKingpinKeyString]) {
            self.name = @"Kingpin";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Kingpin blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"If another Traitor remains, then for attempts to reveal your role, you appear as “Townsperson.”"];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Kingpin."
                                 "\n\nYou win with the Traitors."
                                 "\n\nIf another Traitor remains, then for attempts to reveal your role, you appear as “Townsperson.”"];
        } else if ([self.key isEqualToString:GGKDarkJudgeKeyString]) {
            self.name = @"Dark Judge";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.isTraitor = YES;
            self.shortBlurb = @"(Trait.) Dark Judge blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"During the night, the Dark Judge may %@ the Dictator, and it can't be prevented.", GGKExileString];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Dark Judge."
                                 "\n\nYou win with the Traitors."
                                 "\n\nDuring the night, you may %@ the Dictator, and it can't be prevented.", GGKExileString];
        } else if ([self.key isEqualToString:GGKHermitKeyString]) {
            self.name = @"Hermit";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Hermit blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"If elected Dictator, the Hermit automatically %@s herself. That night, the Traitors do not get to %@ anyone.", GGKExileString, GGKEliminateString];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Hermit."
                                 "\n\nYou win with the Town."
                                 "\n\nIf elected Dictator, you automatically %@ yourself. That night, the Traitors do not get to %@ anyone.", GGKExileString, GGKEliminateString];
        } else if ([self.key isEqualToString:GGKGossipKeyString]) {
            self.name = @"Gossip";
            self.longNameWithArticle = [NSString stringWithFormat:@"a %@", self.name];
            self.shortBlurb = @"(Towns.) Gossip blurb1 here";
            self.longBlurb = [NSString stringWithFormat:@"At night, the Gossip picks a player. That player cannot be Dictator tomorrow (due to gossip). Be careful: if more than one Gossip target the same player, that player will %@ herself (due to overwhelming gossip)!", GGKExileString];
            self.youAreBlurb1 = [NSString stringWithFormat:@"You are a Gossip."
                                 "\n\nYou win with the Town."
                                 "\n\nAt night, you pick a player. The target cannot be elected Dictator tomorrow. If a player is targeted by multiple Gossips, the overwhelming gossip drives her into %@.", GGKExileString];
        } else {
            NSLog(@"Warning: unknown role:%@", self.key);
        }
    }
    return self;
}
@end
