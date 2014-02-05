//
//  GGKYouAreDictatorViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYouAreDictatorViewController.h"

#import "GGKGameModel.h"

NSString *NoExileAlertViewTitleString = @"No Exile";

@interface GGKYouAreDictatorViewController ()
@end

@implementation GGKYouAreDictatorViewController
- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex {
    [super alertView:theAlertView clickedButtonAtIndex:theButtonIndex];
    if ([theAlertView.title isEqualToString:NoExileAlertViewTitleString]) {
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            // Go to night.
            [self performSegueWithIdentifier:@"ShowNightSegue2" sender:self];
        }
    } else if (theAlertView.message == nil) {
        // If "Exile X?" alert view and dictator said OK, then exile selected player.
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            [self.gameModel.remainingPlayersMutableArray removeObject:self.gameModel.currentlySelectedPlayer];
            [self performSegueWithIdentifier:@"ExileSegue1" sender:self];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    static NSString *PlayerCellIdentifier = @"PlayerNameCell";
    
    UITableViewCell *aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:PlayerCellIdentifier];
    if (aTableViewCell == nil) {
        
        aTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlayerCellIdentifier];
    }
    
    GGKPlayer *aPlayer = [self.gameModel.remainingPlayersMutableArray objectAtIndex:theIndexPath.row];
    aTableViewCell.textLabel.text = aPlayer.name;
    
    return aTableViewCell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    self.exileButton.enabled = YES;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection
{
    return [self.gameModel.remainingPlayersMutableArray count];
}
- (IBAction)verifyExile {
    NSIndexPath *anIndexPath = [self.playersTableView indexPathForSelectedRow];
    self.gameModel.currentlySelectedPlayer = [self.gameModel.remainingPlayersMutableArray objectAtIndex:anIndexPath.row];
    NSString *theAlertTitleString = [NSString stringWithFormat:@"Exile %@?", self.gameModel.currentlySelectedPlayer.name];
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:theAlertTitleString message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}
- (IBAction)verifyNoExile {
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:NoExileAlertViewTitleString message:@"Exile no one today?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    GGKPlayer *theDictatorPlayer = self.gameModel.currentDictatorPlayer;
    self.navigationItem.title = [NSString stringWithFormat:@"Dictator: %@!", theDictatorPlayer.name];
    self.dictatorInfoLabel.text = [NSString stringWithFormat:@"%@, you are the Dictator! %@", theDictatorPlayer.name, theDictatorPlayer.role.youAreDictator1];
    self.noExileButton.enabled = YES;
    self.exileButton.enabled = NO;
}

@end
