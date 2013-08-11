//
//  GGKSetRolesViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/8/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGKSetRolesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Assign 1 of the selected role to this game.
@property (strong, nonatomic) IBOutlet UIButton *addRoleButton;

// List of all roles (and counts) for this game.
@property (strong, nonatomic) IBOutlet UITableView *assignedRolesTableView;

// List of all available roles.
@property (strong, nonatomic) IBOutlet UITableView *availableRolesTableView;

// Minimum number of players needed to satisfy all assigned roles.
@property (strong, nonatomic) IBOutlet UILabel *minimumNumberOfPlayersLabel;

// Number of players currently in the game.
@property (strong, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;

// Remove 1 of the selected role from this game.
@property (strong, nonatomic) IBOutlet UIButton *removeRoleButton;

// Assign 1 of the selected role to this game.
- (IBAction)add1Role;

// Override.
// Convey role info.
- (void)prepareForSegue:(UIStoryboardSegue *)theSegue sender:(id)theSender;

// Remove 1 of the selected role from this game.
- (IBAction)remove1Role;

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
// So, enable/disable buttons accordingly.

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;

// Override.
- (void)viewDidLoad;

@end
