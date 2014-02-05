//
//  GGKDayViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGKDayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// User taps button to elect dictator.
@property (strong, nonatomic) IBOutlet UIButton *electDictatorButton;
// If the time shown reaches 0, no dictator is elected.
@property (strong, nonatomic) IBOutlet UILabel *electDictatorTimerLabel;
// User taps button to elect no dictator. (Go directly to night phase.)
@property (strong, nonatomic) IBOutlet UIButton *noDictatorButton;

// Number of players remaining in the game.
@property (strong, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;

// Number of votes needed to elect the dictator.
@property (strong, nonatomic) IBOutlet UILabel *numberOfVotesNeededLabel;

// List of remaining players.
@property (strong, nonatomic) IBOutlet UITableView *playersTableView;
// User handled alert. Could be no dictator. Could be quit game. Could be time up for electing dictator.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// Store info and show next screen.
- (IBAction)electDictator;

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
// So, enable/disable buttons accordingly.

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;

// Make sure player wants to elect no dictator.
- (IBAction)verifyNoDictator;

// Make sure player wants to end the game.
- (IBAction)verifyQuitGame;

// Override.
- (void)viewDidLoad;
// Override.
// Cancel any timer.
- (void)viewWillDisappear:(BOOL)animated;
@end
