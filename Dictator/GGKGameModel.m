//
//  GGKGameModel.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKGameModel.h"

@implementation GGKGameModel

- (id)init
{
    self = [super init];
    if (self) {
        
        self.allPlayersArray = [NSArray array];
    }
    return self;
}

@end
