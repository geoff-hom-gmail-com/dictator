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
    BOOL someoneWasEliminated = NO;
    NSMutableString *theSummaryTextMutableString = [NSMutableString stringWithString:@"Reveal this to all:"
                                                    @"\n\nLast night … "];
    NSString *anUneventfulNightString = [theSummaryTextMutableString copy];
    if (self.gameModel.doJudgeExileDictatorBOOL) {
        someoneWasEliminated = YES;
        GGKPlayer *theDictatorPlayer = self.gameModel.currentDictatorPlayer;
        [theSummaryTextMutableString appendFormat:@"\n\nA Judge %@ Dictator %@!"
         "\n%@ was %@.", GGKExiledString, theDictatorPlayer.name, theDictatorPlayer.name, theDictatorPlayer.role.longNameWithArticle];
    }
    for (GGKPlayer *aPlayer in self.gameModel.playersWithOverwhelmingGossipMutableArray) {
        someoneWasEliminated = YES;
        [theSummaryTextMutableString appendFormat:@"\n\nOverwhelming gossip drove %@ into %@!"
         "\n%@ was %@.", aPlayer.name, GGKExileString, aPlayer.name, aPlayer.role.longNameWithArticle];
    }
    NSArray *thePlayersEliminatedLastNightArray = self.gameModel.playersEliminatedLastNightMutableArray;
    if ([thePlayersEliminatedLastNightArray count] >= 1) {
        // If there was a voting tie, note that.
        NSString *theTieTextString = @"";
        if (self.gameModel.thereWasATieBOOL) {
            // "Last night, whispered arguments were heard … and %@ was eliminated!"
            theTieTextString = @"Whispered arguments were heard … and ";
        }
        // For now, assume the Traitors can eliminate only 0 or 1 players.
        GGKPlayer *theEliminatedPlayer = thePlayersEliminatedLastNightArray[0];
        [theSummaryTextMutableString appendFormat:@"\n\n%@%@ was %@!"
                                       "\n%@ was %@.", theTieTextString, theEliminatedPlayer.name, GGKEliminatedString, theEliminatedPlayer.name, theEliminatedPlayer.role.longNameWithArticle];
    }
    for (GGKPlayer *anEliminatedPlayer in self.gameModel.playersToVigilanteEliminateMutableArray) {
        [theSummaryTextMutableString appendFormat:@"\n\n%@ was %@ by Vigilantes!"
         "\n%@ was %@.", anEliminatedPlayer.name, GGKEliminatedString, anEliminatedPlayer.name, anEliminatedPlayer.role.longNameWithArticle];
    }
    for (GGKPlayer *aPlayer in self.gameModel.playersWithRegularGossipMutableArray) {
        [theSummaryTextMutableString appendFormat:@"\n\nSomeone gossiped about %@! %@ cannot be elected Dictator today!", aPlayer.name, aPlayer.name];
    }
    // If nothing happened, note that.
    if ([theSummaryTextMutableString isEqualToString:anUneventfulNightString]) {
        [theSummaryTextMutableString appendFormat:@"\n\nNo one was %@….", GGKEliminatedString];
    }
    self.summaryTextView.text = theSummaryTextMutableString;
}
@end
