//
//  GGKExiledViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKExiledViewController.h"

#import "GGKGameModel.h"

@interface GGKExiledViewController ()
@end

@implementation GGKExiledViewController
- (IBAction)goToNightOrEnd {
    if ([self.gameModel isGameOver]) {
        [self performSegueWithIdentifier:@"ShowGameOverSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"ShowNightSegue" sender:self];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    GGKPlayer *theExiledPlayer = self.gameModel.currentlySelectedPlayer;
    self.exiledPlayerLabel.text = [NSString stringWithFormat:@"%@ was %@!", theExiledPlayer.name, GGKExiledString];
    NSMutableString *aMutableString = [NSMutableString stringWithFormat:@"%@ was %@.", theExiledPlayer.name, theExiledPlayer.role.longNameWithArticle];
    // If Dictator was a Hermit, then note special night rules.
    if (self.gameModel.hermitWasDictator) {
        [aMutableString appendFormat:@"\n\nThanks to %@'s sacrifice, the Traitors cannot %@ anyone tonight!", theExiledPlayer.name, GGKEliminateString];
    }
    self.exiledRoleTextView.text = aMutableString;
}
@end
