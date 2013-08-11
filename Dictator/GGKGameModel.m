//
//  GGKGameModel.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKGameModel.h"

#import "GGKRole.h"

@implementation GGKGameModel

- (id)init
{
    self = [super init];
    if (self) {
        
        self.allPlayersArray = [NSArray array];
        
        // Create available-roles array.
        // Order presented should be Townsperson, Traitor, then alphabetically.
        
        // Townsperson.
        GGKRole *aRole = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
        self.availableRolesMutableArray = [NSMutableArray arrayWithObject:aRole];
        
        // Traitor.
        aRole = [[GGKRole alloc] initWithType:GGKTraitorKeyString];
        [self.availableRolesMutableArray addObject:aRole];
        
        // Just do these for my testing of the scrolling. Comment out for testers.
        
//        // Assassin.
//        aRole = [[GGKRole alloc] initWithType:GGKAssassinKeyString];
//        [self.availableRolesMutableArray addObject:aRole];
//        
//        // Doctor.
//        aRole = [[GGKRole alloc] initWithType:GGKDoctorKeyString];
//        [self.availableRolesMutableArray addObject:aRole];
    }
    return self;
}

@end
