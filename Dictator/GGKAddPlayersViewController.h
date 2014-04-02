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
@property (weak, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;
@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;
// List of all players in the game.
@property (weak, nonatomic) IBOutlet UITableView *playersTableView;
// Override.
// User handled alert. Could be delete all players.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;
// Delete the given row.
- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)theEditingStyle forRowAtIndexPath:(NSIndexPath *)theIndexPath;
// Move the given row.
- (void)tableView:(UITableView *)theTableView moveRowAtIndexPath:(NSIndexPath *)theSourceIndexPath toIndexPath:(NSIndexPath *)theDestinationIndexPath;
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Text field finished editing. So, add named player.
- (void)textFieldDidEndEditing:(UITextField *)theTextField;
// Add accessory view.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
// Text field should return. So, dismiss the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
// Ensure the user wants to delete all players.
- (IBAction)verifyDeleteAll;
// Override.
- (void)viewDidLoad;
@end
