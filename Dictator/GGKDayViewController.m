//
//  GGKDayViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKDayViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"

NSString *NoDictatorAlertViewTitleString = @"No Dictator";

@interface GGKDayViewController ()

@property (strong, nonatomic) GGKGameModel *gameModel;

@end

@implementation GGKDayViewController

- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex
{
    if ([theAlertView.title isEqualToString:NoDictatorAlertViewTitleString]) {
        
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            
            // Go to night.
            [self performSegueWithIdentifier:@"ShowNightSegue" sender:self];
        }
    } else if ([theAlertView.title isEqualToString:QuitGameAlertViewTitleString]) {
        
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            
            // Return to start-game screen.
//            [self.navigationController popToRootViewControllerAnimated:YES];
            UIViewController *theDesiredViewController = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:theDesiredViewController animated:YES];
        }
    }
}

- (IBAction)electDictator
{
    // Selected player is dictator.
    NSIndexPath *anIndexPath = [self.playersTableView indexPathForSelectedRow];
    GGKPlayer *aPlayer = [self.gameModel.remainingPlayersMutableArray objectAtIndex:anIndexPath.row];
    self.gameModel.currentDictatorPlayer = aPlayer;
    
    [self performSegueWithIdentifier:@"ShowDictatorElectedSegue" sender:self];
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
    self.electDictatorButton.enabled = YES;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection
{
    return [self.gameModel.remainingPlayersMutableArray count];
}

- (IBAction)verifyNoDictator
{
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:NoDictatorAlertViewTitleString message:@"Skip election and go directly to night phase?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}

- (IBAction)verifyQuitGame
{
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:QuitGameAlertViewTitleString message:@"End this game and return to the main menu?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    GGKAppDelegate *theAppDelegate = (GGKAppDelegate *)[UIApplication sharedApplication].delegate;
    self.gameModel = theAppDelegate.gameModel;
    
    NSInteger theNumberOfPlayersInteger = [self.gameModel.remainingPlayersMutableArray count];
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%d", theNumberOfPlayersInteger];
    NSInteger theNumberOfVotesNeededInteger = (theNumberOfPlayersInteger / 2) + 1;
    self.numberOfVotesNeededLabel.text = [NSString stringWithFormat:@"%d", theNumberOfVotesNeededInteger];
    
    self.noDictatorButton.enabled = YES;
    self.electDictatorButton.enabled = NO;
    
    self.navigationItem.hidesBackButton = YES;
}

@end
