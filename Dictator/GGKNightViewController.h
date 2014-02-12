//
//  GGKNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKNightViewController : GGKViewController
// Name of the current player.
@property (strong, nonatomic) IBOutlet UILabel *currentPlayerNameLabel;
// User taps button to note they are said player.
@property (strong, nonatomic) IBOutlet UIButton *verifyPlayerButton;
// Show the night actions for the player's role.
- (IBAction)showNightActions;
// Override.
- (void)viewDidLoad;
// Override.
// Show whose turn it is. The first player is to the left of the current player/dictator. After the player makes her night action, she'll return to this view. This will then ask for the next player.
- (void)viewWillAppear:(BOOL)animated;
@end
