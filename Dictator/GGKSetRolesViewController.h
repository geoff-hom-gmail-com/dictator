//
//  GGKSetRolesViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/8/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGKSetRolesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Number of players currently in the game.
@property (strong, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;

// List of all roles (and counts) for this game.
@property (strong, nonatomic) IBOutlet UITableView *assignedRolesTableView;

// List of all available roles.
@property (strong, nonatomic) IBOutlet UITableView *availableRolesTableView;

// Override.
// Convey role info.
- (void)prepareForSegue:(UIStoryboardSegue *)theSegue sender:(id)theSender;

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;

// Override.
- (void)viewDidLoad;

@end
