//
//  GGKAbstractRoleNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

#import "GGKGameModel.h"

@interface GGKAbstractRoleNightViewController ()
@end

@implementation GGKAbstractRoleNightViewController
- (void)askForNextPlayerOrEnd {
    if (self.gameModel.currentPlayer != self.gameModel.lastPlayerThisRound) {
        NSInteger theCurrentPlayerIndex = [self.gameModel.remainingPlayersMutableArray indexOfObject:self.gameModel.currentPlayer];
        NSInteger theNextIndex = (theCurrentPlayerIndex + 1) % [self.gameModel.remainingPlayersMutableArray count];
        self.gameModel.currentPlayer = self.gameModel.remainingPlayersMutableArray[theNextIndex];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self performSegueWithIdentifier:@"ShowNightSummarySegue" sender:self];
    }
}
- (void)doRoleActions {
}
- (IBAction)handlePlayerDone {
    [self doRoleActions];
    [self askForNextPlayerOrEnd];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
}
@end
