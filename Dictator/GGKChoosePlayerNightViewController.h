//
//  GGKChoosePlayerNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 3/27/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//
// For roles in which the current player chooses another player for some action.
// Current roles: Townsperson, Doctor, Private Eye.
// Townsperson has to guess a Traitor but gets no feedback. For fun/stats at end.

#import "GGKAbstractRoleNightViewController.h"

@interface GGKChoosePlayerNightViewController : GGKAbstractRoleNightViewController <UITableViewDataSource, UITableViewDelegate>
// The prompt for the current player. Role-specific.
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;
// List of remaining players, except this one, in the game.
@property (strong, nonatomic) IBOutlet UITableView *remainingPlayersMinusSelfTableView;
// When done choosing, player taps this button.
@property (strong, nonatomic) IBOutlet UIButton *thisPersonButton;
// Override.
// User handled alert. Could be private-eye investigation.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// Override.
- (void)doRoleActions;
// Each row is a remaining player.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;
// The player chose someone. So, enable the button to proceed.
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Override.
- (void)viewDidLoad;
@end
