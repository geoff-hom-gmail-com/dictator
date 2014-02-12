//
//  GGKTownspersonNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

@interface GGKTownspersonNightViewController : GGKAbstractRoleNightViewController <UITableViewDataSource, UITableViewDelegate>
// List of remaining players, except this Townsperson, in the game.
@property (strong, nonatomic) IBOutlet UITableView *remainingPlayersMinusSelfTableView;
// Townsperson has to guess a Traitor. (Just for fun/stats at end. Also, so the other players can't tell this person is a Townsperson because they don't do anything.) When done, taps this button.
@property (strong, nonatomic) IBOutlet UIButton *thisPersonButton;
// Override.
// Record who the Townsperson suspected as Traitor.
- (void)doRoleActions;
// Each row is a remaining player.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;
// The Townsperson selected a suspect. So, enable the button to proceed.
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Override.
- (void)viewDidLoad;
@end