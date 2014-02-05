//
//  GGKViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"

@interface GGKViewController ()
@end

@implementation GGKViewController
- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex {
    // If quit game, go to main menu.
    if (theAlertView == self.quitGameAlertView) {
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}
- (IBAction)verifyQuitGame {
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:@"Quit Game" message:@"End this game and return to the main menu?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
    self.quitGameAlertView = anAlertView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    GGKAppDelegate *theAppDelegate = (GGKAppDelegate *)[UIApplication sharedApplication].delegate;
    self.gameModel = theAppDelegate.gameModel;
}
@end
