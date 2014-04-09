//
//  GGKTraitorNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

@interface GGKTraitorNightViewController : GGKAbstractRoleNightViewController <UITableViewDataSource, UITableViewDelegate>
// List of players selected by fellow Traitors this round.
@property (strong, nonatomic) IBOutlet UITableView *hitListTableView;
// List of remaining players in the game. (Traitors may want to vote for each other, including self.)
@property (strong, nonatomic) IBOutlet UITableView *remainingPlayersTableView;
// Traitor has to vote for someone to eliminate. When done, taps this button.
@property (strong, nonatomic) IBOutlet UIButton *thisPersonButton;
// User handled alert. Could be exile Dictator.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// Override.
// Add an elimination vote to the selected player.
- (void)doRoleActions;
// There are two tables. In the hit-list table, each row is a player and the number of elimination votes she has received so far. In the remaining-players table, each row is a remaining player.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;
// The Traitor voted for someone to eliminate. So, enable the button to proceed.
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Override.
- (void)viewDidLoad;
@end
