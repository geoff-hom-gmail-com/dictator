//
//  GGKNightSummaryViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKNightSummaryViewController.h"

#import "GGKGameModel.h"

@interface GGKNightSummaryViewController ()

@end

@implementation GGKNightSummaryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    // Report what happened last night.
    [self.gameModel calculateNightSummary];
    NSArray *thePlayersEliminatedLastNightArray = self.gameModel.playersEliminatedLastNightArray;
    if (thePlayersEliminatedLastNightArray == nil) {
        self.summaryTextView.text = @"Last night, no one was eliminated.";
    } else {
        // For now, assuming only 0 or 1 players can be eliminated.
        GGKPlayer *theEliminatedPlayer = thePlayersEliminatedLastNightArray[0];
        self.summaryTextView.text = [NSString stringWithFormat:@"Last night, %@ was eliminated!"
                                     "\n%@ was %@."
                                     "\n\nReveal this to all.", theEliminatedPlayer.name, theEliminatedPlayer.name, theEliminatedPlayer.role.longNameWithArticle];
    }
    if ([self.gameModel isGameOver]) {
        NSLog(@"TEMP NOTE: Game should be over!");
    }
}
@end
