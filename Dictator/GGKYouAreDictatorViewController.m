//
//  GGKYouAreDictatorViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYouAreDictatorViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"

NSString *NoExileAlertViewTitleString = @"No Exile";

@interface GGKYouAreDictatorViewController ()

@property (strong, nonatomic) GGKGameModel *gameModel;

@end

@implementation GGKYouAreDictatorViewController

- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex
{
    if ([theAlertView.title isEqualToString:QuitGameAlertViewTitleString]) {
        
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            
            // Return to start-game screen.
            UIViewController *theDesiredViewController = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:theDesiredViewController animated:YES];
        }
    } else if ([theAlertView.title isEqualToString:NoExileAlertViewTitleString]) {
        
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            
            // Go to night.
            [self performSegueWithIdentifier:@"ShowNightSegue2" sender:self];
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

- (IBAction)verifyNoExile
{
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:NoExileAlertViewTitleString message:@"Exile no one today?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
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
    
    self.navigationItem.hidesBackButton = YES;
    GGKPlayer *theDictatorPlayer = self.gameModel.currentDictatorPlayer;
    self.navigationItem.title = [NSString stringWithFormat:@"Dictator: %@!", theDictatorPlayer.name];
    
    self.dictatorInfoLabel.text = [NSString stringWithFormat:@"%@, you are the Dictator! %@", theDictatorPlayer.name, theDictatorPlayer.role.youAreDictator1];
    
    self.noExileButton.enabled = YES;
    self.exileButton.enabled = NO;
}

@end
