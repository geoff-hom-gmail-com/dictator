//
//  GGKYouAreDictatorViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGKYouAreDictatorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Info for the given player as dictator.
@property (strong, nonatomic) IBOutlet UILabel *dictatorInfoLabel;

// To exile selected player.
@property (strong, nonatomic) IBOutlet UIButton *exileButton;

// To exile no one.
@property (strong, nonatomic) IBOutlet UIButton *noExileButton;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
// So, if user confirmed an action, do it.

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath;

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath;
// So, enable/disable buttons accordingly.

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection;

// Make sure player wants to exile no one.
- (IBAction)verifyNoExile;

// Make sure player wants to end the game.
- (IBAction)verifyQuitGame;

// Override.
- (void)viewDidLoad;

@end
