//
//  GGKStartGameViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/11/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKStartGameViewController.h"

#import "GGKGameModel.h"
#import "GGKPlayer.h"
#import "GGKRole.h"

@interface GGKStartGameViewController ()
// Number of (plain) Townspeople in the game.
//@property (assign, nonatomic) NSInteger numberOfTownspeople;
@end

@implementation GGKStartGameViewController

- (IBAction)startGame {
    [self.gameModel startGame];
    [self performSegueWithIdentifier:@"ShowPregameSegue" sender:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Make UI blank so we can make launch images via screenshot.
    BOOL aCreateLaunchImagesBOOL = NO;
    // Uncomment to create launch images.
//    aCreateLaunchImagesBOOL = YES;
    if (aCreateLaunchImagesBOOL) {
        self.navigationItem.title = @"";
        for (UIView *aSubView in self.view.subviews) {
            aSubView.hidden = YES;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Enable start only if players >= minimum players.
    NSInteger theNumberOfPlayersInteger = [self.gameModel.allPlayersMutableArray count];
    if (theNumberOfPlayersInteger > 0 && [self.gameModel numberOfTownspeopleAtStart] >= 0) {
        self.startButton.enabled = YES;
    } else {
        self.startButton.enabled = NO;
    }
}
@end
