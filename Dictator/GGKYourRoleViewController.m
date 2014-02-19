//
//  GGKYourRoleViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYourRoleViewController.h"

#import "GGKGameModel.h"

@interface GGKYourRoleViewController ()
@end

@implementation GGKYourRoleViewController

- (IBAction)askForNextPlayerOrEnd {
    NSInteger anIndex = [self.gameModel.allPlayersMutableArray indexOfObject:self.gameModel.currentPlayer];
    NSInteger theNextIndex = anIndex + 1;
    if (theNextIndex < [self.gameModel.allPlayersMutableArray count]) {
        // Ask for next player.
        self.gameModel.currentPlayer = self.gameModel.allPlayersMutableArray[theNextIndex];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if ([self.gameModel isGameOver]) {
            [self performSegueWithIdentifier:@"ShowGameOverSegue" sender:self];
        } else {
            [self performSegueWithIdentifier:@"ShowFirstDaySegue" sender:self];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    GGKPlayer *theCurrentPlayer = self.gameModel.currentPlayer;
    self.playerNameLabel.text = theCurrentPlayer.name;
    self.roleInfoLabel.text = theCurrentPlayer.role.youAreBlurb1;
    if (theCurrentPlayer.role.isTraitor) {
        self.otherMembersLabel.hidden = NO;
        // Show names of other traitors, or none if only 1.
        // Make string of each other traitor's name. Show it.
        NSMutableString *theOtherTraitorsMutableString;
        for (GGKPlayer *aPlayer in self.gameModel.allPlayersMutableArray) {
            if (aPlayer == theCurrentPlayer) {
                continue;
            }
            if (aPlayer.role.isTraitor) {
                if (theOtherTraitorsMutableString == nil) {
                    theOtherTraitorsMutableString = [NSMutableString stringWithFormat:@"%@", aPlayer.name];
                } else {
                    [theOtherTraitorsMutableString appendFormat:@", %@", aPlayer.name];
                }
            }
        }
        if (theOtherTraitorsMutableString == nil) {
            theOtherTraitorsMutableString = [NSMutableString stringWithFormat:@"none"];
        }
        self.otherMembersLabel.text = [NSString stringWithFormat:@"Your fellow Traitors are: %@.", theOtherTraitorsMutableString];
    } else {
        self.otherMembersLabel.hidden = YES;
    }
    self.navigationItem.hidesBackButton = YES;
}
@end
