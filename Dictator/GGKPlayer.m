//
//  GGKPlayer.m
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKPlayer.h"
// Key for storing player's name.
NSString *GGKPlayerNameKeyString = @"Player's name.";
// Key for storing player's role.
NSString *GGKPlayerRoleKeyString = @"Player's role.";

@implementation GGKPlayer
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:GGKPlayerNameKeyString];
    [aCoder encodeObject:self.role forKey:GGKPlayerRoleKeyString];
}
- (id)init {
    self = [super init];
    if (self) {
        self.name = @"Bob Smith";
        self.role = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:GGKPlayerNameKeyString];
        self.role = [aDecoder decodeObjectForKey:GGKPlayerRoleKeyString];
    }
    return self;
}
@end
