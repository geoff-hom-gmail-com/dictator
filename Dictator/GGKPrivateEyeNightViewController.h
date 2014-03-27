//
//  GGKPrivateEyeNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 3/26/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

@interface GGKPrivateEyeNightViewController : GGKAbstractRoleNightViewController <UITableViewDataSource, UITableViewDelegate>
// List of remaining players, except this one, in the game.
@property (strong, nonatomic) IBOutlet UITableView *remainingPlayersMinusSelfTableView;
// Private Eye has to investigate someone. When done, taps this button.
@property (strong, nonatomic) IBOutlet UIButton *thisPersonButton;
// Override.
// Show an alert with the investigation results.
- (void)doRoleActions;
// Each row is a remaining player.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;
// The player chose someone. So, enable the button to proceed.
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Override.
- (void)viewDidLoad;
@end
