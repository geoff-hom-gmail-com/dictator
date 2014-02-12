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
@property (strong, nonatomic) NSMutableArray *currentPlayersMutableArray;

// Make sure the game model has all the players.
- (void)updateGameModel;

// Make sure the user sees the total number of players.
- (void)updateNumberOfPlayersLabel;

@end

@implementation GGKAddPlayersViewController

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    static NSString *PlayerCellIdentifier = @"PlayerNameCell";
    
    UITableViewCell *aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:PlayerCellIdentifier];
    
    // should not need this; test
    if (aTableViewCell == nil) {
        
        aTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlayerCellIdentifier];
    }
    
    GGKPlayer *aPlayer = [self.currentPlayersMutableArray objectAtIndex:theIndexPath.row];
    aTableViewCell.textLabel.text = aPlayer.name;
        
    return aTableViewCell;
}

- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)theEditingStyle forRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    // Remove name from array. Update table. Update model.
    
    [self.currentPlayersMutableArray removeObjectAtIndex:theIndexPath.row];
    
    [theTableView deleteRowsAtIndexPaths:@[theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self updateNumberOfPlayersLabel];
    [self updateGameModel];
}

- (void)tableView:(UITableView *)theTableView moveRowAtIndexPath:(NSIndexPath *)theSourceIndexPath toIndexPath:(NSIndexPath *)theDestinationIndexPath
{
    id theObjectToMove = [self.currentPlayersMutableArray objectAtIndex:theSourceIndexPath.row];
    [self.currentPlayersMutableArray removeObjectAtIndex:theSourceIndexPath.row];
    [self.currentPlayersMutableArray insertObject:theObjectToMove atIndex:theDestinationIndexPath.row];
    
    [self updateGameModel];
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection
{
    return [self.currentPlayersMutableArray count];
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField
{
    // Add name to array. Update table. Update model.
    
    GGKPlayer *aPlayer = [[GGKPlayer alloc] init];
    aPlayer.name = theTextField.text;
    [self.currentPlayersMutableArray addObject:aPlayer];
    [self.playersTableView reloadData];
    
    // Scroll to name added.
    NSIndexPath *anIndexPath = [NSIndexPath indexPathForRow:[self.currentPlayersMutableArray count] - 1 inSection:0];
    [self.playersTableView scrollToRowAtIndexPath:anIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    [self updateNumberOfPlayersLabel];
    [self updateGameModel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

- (void)updateGameModel
{
    self.gameModel.allPlayersArray = [self.currentPlayersMutableArray copy];
}

- (void)updateNumberOfPlayersLabel
{
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%d", [self.currentPlayersMutableArray count]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Get players from model.
    self.currentPlayersMutableArray = [self.gameModel.allPlayersArray mutableCopy];
    [self updateNumberOfPlayersLabel];
    // Put table into editing mode.
    [self.playersTableView setEditing:YES animated:NO];
}

@end
