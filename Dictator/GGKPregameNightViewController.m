//
//  GGKPregameNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKPregameNightViewController.h"

#import "GGKGameModel.h"

@interface GGKPregameNightViewController ()
@end

@implementation GGKPregameNightViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Show whose turn it is.
    GGKPlayer *theCurrentPlayer = self.gameModel.currentPlayer;
    self.currentPlayerNameLabel.text = theCurrentPlayer.name;
    NSString *theButtonTitleString = [NSString stringWithFormat:@"I am %@", theCurrentPlayer.name];
    [self.verifyPlayerButton setTitle:theButtonTitleString forState:UIControlStateNormal];
}
@end
