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
- (IBAction)goToDayOrEnd {
    if ([self.gameModel isGameOver]) {
        [self performSegueWithIdentifier:@"ShowGameOverSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"ShowDaySegue" sender:self];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    // Report what happened last night.
    [self.gameModel calculateNightSummary];
    NSArray *thePlayersEliminatedLastNightArray = self.gameModel.playersEliminatedLastNightArray;
    NSString *theSummaryTextString;
    if ((thePlayersEliminatedLastNightArray == nil) || ([thePlayersEliminatedLastNightArray count] == 0)) {
        theSummaryTextString = [NSString stringWithFormat:@"Last night, no one was %@.", GGKEliminatedString];
    } else {
        // For now, assuming only 0 or 1 players can be eliminated.
        GGKPlayer *theEliminatedPlayer = thePlayersEliminatedLastNightArray[0];
        // If there was a voting tie, note that.
        NSString *theTieTextString = @"";
        if (self.gameModel.thereWasATieBOOL) {
            // "Last night, whispered arguments were heard … and %@ was eliminated!"
            theTieTextString = @"whispered arguments were heard … and ";
        }
        theSummaryTextString = [NSString stringWithFormat:@"Reveal this to all:"
                                "\n\nLast night, %@%@ was %@!"
                                "\n%@ was %@.", theTieTextString, theEliminatedPlayer.name, GGKEliminatedString, theEliminatedPlayer.name, theEliminatedPlayer.role.longNameWithArticle];
    }
    self.summaryTextView.text = theSummaryTextString;
    if ([self.gameModel isGameOver]) {
        NSLog(@"TEMP NOTE: Game should be over!");
    }
}
@end
