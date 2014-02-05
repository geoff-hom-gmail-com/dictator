//
//  GGKAddPlayersViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKAddPlayersViewController : GGKViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

// Number of players currently in the game.
@property (strong, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;

// List of all players in the game.
@property (strong, nonatomic) IBOutlet UITableView *playersTableView;

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)theEditingStyle forRowAtIndexPath:(NSIndexPath *)theIndexPath;
// So, delete the given row.

- (void)tableView:(UITableView *)theTableView moveRowAtIndexPath:(NSIndexPath *)theSourceIndexPath toIndexPath:(NSIndexPath *)theDestinationIndexPath;
// So, move the row in the data and update the model.

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;

- (void)textFieldDidEndEditing:(UITextField *)theTextField;
// So, add name to table.

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
// So, dismiss the keyboard.

// Override.
- (void)viewDidLoad;

@end
