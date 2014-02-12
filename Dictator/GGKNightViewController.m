//
//  GGKNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKNightViewController.h"

#import "GGKGameModel.h"

@interface GGKNightViewController ()

@end

@implementation GGKNightViewController
- (IBAction)showNightActions {
    NSString *theSegue;
    NSString *theCurrentRoleString = self.gameModel.currentPlayer.role.key;
    if ([theCurrentRoleString isEqualToString:GGKTownspersonKeyString]) {
        theSegue = @"ShowTownspersonNightSegue";
    } else if ([theCurrentRoleString isEqualToString:GGKTraitorKeyString]) {
        theSegue = @"ShowTraitorNightSegue";
    } else {
        NSLog(@"NVC warning: unknown role, %@", theCurrentRoleString);
    }
    [self performSegueWithIdentifier:theSegue sender:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    // Start to left of the current player/dictator. Will end with current player/dictator.
    self.gameModel.lastPlayerThisRound = self.gameModel.currentPlayer;
    NSInteger anIndex = [self.gameModel.remainingPlayersMutableArray indexOfObject:self.gameModel.currentPlayer];
    NSInteger theNextIndex = (anIndex + 1) % [self.gameModel.remainingPlayersMutableArray count];
    self.gameModel.currentPlayer = self.gameModel.remainingPlayersMutableArray[theNextIndex];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Show whose turn it is.
    GGKPlayer *theCurrentPlayer = self.gameModel.currentPlayer;
    self.currentPlayerNameLabel.text = theCurrentPlayer.name;
    NSString *theButtonTitleString = [NSString stringWithFormat:@"I am %@", theCurrentPlayer.name];
    [self.verifyPlayerButton setTitle:theButtonTitleString forState:UIControlStateNormal];
}
@end
