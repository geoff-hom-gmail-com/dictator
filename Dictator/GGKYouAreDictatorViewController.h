//
//  GGKYouAreDictatorViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKYouAreDictatorViewController : GGKViewController <UITableViewDataSource, UITableViewDelegate>

// Info for the given player as dictator.
@property (strong, nonatomic) IBOutlet UILabel *dictatorInfoLabel;

// To exile selected player.
@property (strong, nonatomic) IBOutlet UIButton *exileButton;

// To exile no one.
@property (strong, nonatomic) IBOutlet UIButton *noExileButton;
// List of remaining players.
@property (strong, nonatomic) IBOutlet UITableView *playersTableView;
// Override.
// User handled alert. Could be no exile. Could be exile.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
// So, enable/disable buttons accordingly.

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;
// Make sure dictator wants to exile selected person.
- (IBAction)verifyExile;
// Make sure player wants to exile no one.
- (IBAction)verifyNoExile;
// Override.
- (void)viewDidLoad;

@end
