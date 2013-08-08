//
//  GGKGameModel.h
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGKGameModel : NSObject

// The number of players in the game.
//@property (nonatomic, assign) NSInteger numberOfPlayersInteger;

// Players at the start of the game.
@property (strong, nonatomic) NSArray *allPlayersArray;

- (id)init;

@end
