//
//  GGKPlayer.m
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKPlayer.h"

@implementation GGKPlayer

- (id)init
{
    self = [super init];
    if (self) {
        
        self.name = @"Bob Smith";
        self.role = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
    }
    return self;
}

@end
