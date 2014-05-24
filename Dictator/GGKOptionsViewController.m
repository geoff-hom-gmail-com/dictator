//
//  GGKOptionsViewController.m
//  Dictator
//
//  Created by Geoff Hom on 5/23/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKOptionsViewController.h"

#import "GGKGameModel.h"
@interface GGKOptionsViewController ()
// Show current values.
- (void)updateUI;
@end
@implementation GGKOptionsViewController
- (IBAction)handleElectionHasTimeLimitSwitchChanged:(id)sender {
    self.gameModel.electionHasTimeLimitBOOL = self.electionHasTimeLimitSwitch.on;
    [self updateUI];
}
- (void)updateUI {
    self.electionHasTimeLimitSwitch.on = self.gameModel.electionHasTimeLimitBOOL;
    self.electionHasTimeLimitLabel.enabled = self.electionHasTimeLimitSwitch.on;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}
@end
