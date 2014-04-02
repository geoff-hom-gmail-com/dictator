//
//  GGKAddPlayersViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKAddPlayersViewController.h"

#import "GGKGameModel.h"
#import "GGKPlayer.h"

@interface GGKAddPlayersViewController ()
// All players in the game.
@property (strong, nonatomic) NSArray *currentPlayersArray;
// Whether to cancel adding the current player.
@property (assign, nonatomic) BOOL doCancelAddPlayer;
// Keyboard extension. (A cancel button.)
@property (strong, nonatomic) UIInputView *keyboardAccessoryInputView;
// Make sure the player won't be added and dismiss the keyboard.
- (void)cancelAddPlayer;
// Make sure the user sees the total number of players.
- (void)updateNumberOfPlayersLabel;
@end

@implementation GGKAddPlayersViewController
- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex {
    [super alertView:theAlertView clickedButtonAtIndex:theButtonIndex];
    // Delete all players.
    if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
        // Prep to animate.
        NSMutableArray *anIndexPathMutableArray = [NSMutableArray arrayWithCapacity:[self.currentPlayersArray count] ];
        [self.currentPlayersArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
            NSIndexPath *anIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [anIndexPathMutableArray addObject:anIndexPath];
        }];        
        // Actually do it.
        [self.gameModel deleteAllPlayers];
        self.currentPlayersArray = [self.gameModel.allPlayersMutableArray copy];
        [self updateNumberOfPlayersLabel];
        [self.playersTableView deleteRowsAtIndexPaths:anIndexPathMutableArray withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)cancelAddPlayer {
    self.doCancelAddPlayer = YES;
    [self.playerNameTextField resignFirstResponder];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath {
    static NSString *PlayerCellIdentifier = @"PlayerNameCell";
    UITableViewCell *aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:PlayerCellIdentifier];
    GGKPlayer *aPlayer = [self.currentPlayersArray objectAtIndex:theIndexPath.row];
    aTableViewCell.textLabel.text = aPlayer.name;
    return aTableViewCell;
}
- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)theEditingStyle forRowAtIndexPath:(NSIndexPath *)theIndexPath {
    // Delete player. Update.
    GGKPlayer *thePlayerToDelete = [self.currentPlayersArray objectAtIndex:theIndexPath.row];
    [self.gameModel deletePlayer:thePlayerToDelete];
    self.currentPlayersArray = [self.gameModel.allPlayersMutableArray copy];
    [self updateNumberOfPlayersLabel];
    [theTableView deleteRowsAtIndexPaths:@[theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)tableView:(UITableView *)theTableView moveRowAtIndexPath:(NSIndexPath *)theSourceIndexPath toIndexPath:(NSIndexPath *)theDestinationIndexPath {
    // Move player. Update.
    GGKPlayer *thePlayerToMove = [self.currentPlayersArray objectAtIndex:theSourceIndexPath.row];
    [self.gameModel movePlayer:thePlayerToMove toIndex:theDestinationIndexPath.row];
    self.currentPlayersArray = [self.gameModel.allPlayersMutableArray copy];
}
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection {
    return [self.currentPlayersArray count];
}
- (void)textFieldDidEndEditing:(UITextField *)theTextField {
    if (!self.doCancelAddPlayer) {
        // Add player. Update.
        [self.gameModel addPlayerWithName:theTextField.text];
        self.currentPlayersArray = [self.gameModel.allPlayersMutableArray copy];
        [self updateNumberOfPlayersLabel];
        NSIndexPath *anIndexPath = [NSIndexPath indexPathForRow:[self.currentPlayersArray count] - 1 inSection:0];
        [self.playersTableView insertRowsAtIndexPaths:@[anIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // Scroll to player added.
        [self.playersTableView scrollToRowAtIndexPath:anIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {
    theTextField.inputAccessoryView = self.keyboardAccessoryInputView;
    self.doCancelAddPlayer = NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)updateNumberOfPlayersLabel {
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.currentPlayersArray count]];
}
- (IBAction)verifyDeleteAll {
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:@"Delete All Players?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Get data from model.
    self.currentPlayersArray = [self.gameModel.allPlayersMutableArray copy];
    [self updateNumberOfPlayersLabel];
    // Put table into editing mode.
    [self.playersTableView setEditing:YES animated:NO];
    // Make accessory view for keyboard.
    CGSize theToolbarSize = CGSizeMake(self.view.frame.size.width, 44);
    UIToolbar *aToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, theToolbarSize.width, theToolbarSize.height)];
    // Make toolbar-background transparent.
    [aToolbar setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [aToolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    UIBarButtonItem *aCancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAddPlayer)];
    UIBarButtonItem *aFlexibleSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    aToolbar.items = @[aFlexibleSpaceBarButtonItem, aCancelBarButtonItem];
    UIInputView *anInputView = [[UIInputView alloc] initWithFrame:CGRectMake(0, 0, theToolbarSize.width, theToolbarSize.height) inputViewStyle:UIInputViewStyleKeyboard];
    [anInputView addSubview:aToolbar];
    self.keyboardAccessoryInputView = anInputView;
}
@end
