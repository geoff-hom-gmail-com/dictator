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
    NSArray *theChoosePlayerRoleArray = @[GGKTownspersonKeyString, GGKDoctorKeyString, GGKPrivateEyeKeyString, GGKVigilanteKeyString];
    NSArray *theTraitorRoleArray = @[GGKTraitorKeyString, GGKDarkJudgeKeyString, GGKKingpinKeyString];
    if ([theChoosePlayerRoleArray containsObject:theCurrentRoleString]) {
        theSegue = @"ShowChoosePlayerNightSegue";
    } else if ([theTraitorRoleArray containsObject:theCurrentRoleString]) {
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
    [self.gameModel prepForNight];
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
