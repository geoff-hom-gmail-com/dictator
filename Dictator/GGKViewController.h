//
//  GGKViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GGKGameModel;

@interface GGKViewController : UIViewController
@property (strong, nonatomic) GGKGameModel *gameModel;
// An alert verifying whether to quit this game.
// Need this to dismiss programmatically.
@property (nonatomic, strong) UIAlertView *quitGameAlertView;
// User handled alert. Could be quit game.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// Make sure player wants to end the game.
- (IBAction)verifyQuitGame;
// Override.
- (void)viewDidLoad;
@end
