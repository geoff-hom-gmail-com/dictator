//
//  GGKYouAreDictatorViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYouAreDictatorViewController.h"

#import "GGKGameModel.h"

@interface GGKYouAreDictatorViewController ()
// Players that can be exiled today.
@property (strong, nonatomic) NSArray *exilablePlayersArray;
// Title for alert view to confirm exile. To determine which alert view was shown.
@property (strong, nonatomic) NSString *exileTitleString;
// Title for alert view to confirm no exile. To determine which alert view was shown.
@property (strong, nonatomic) NSString *noExileTitleString;
@end

@implementation GGKYouAreDictatorViewController
- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)theButtonIndex {
    [super alertView:theAlertView clickedButtonAtIndex:theButtonIndex];
    if ([theAlertView.title isEqualToString:self.noExileTitleString]) {
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            // Go to night.
            [self performSegueWithIdentifier:@"ShowNightSegue2" sender:self];
        }
    } else if ([theAlertView.title isEqualToString:self.exileTitleString]) {
        if ([[theAlertView buttonTitleAtIndex:theButtonIndex] isEqualToString:@"OK"]) {
            // Exile selected player.
            [self.gameModel removePlayer:self.gameModel.currentlySelectedPlayer];
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
    
    GGKPlayer *aPlayer = [self.exilablePlayersArray objectAtIndex:theIndexPath.row];
    aTableViewCell.textLabel.text = aPlayer.name;
    
    return aTableViewCell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    self.exileButton.enabled = YES;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection {
    return [self.exilablePlayersArray count];
}
- (IBAction)verifyExile {
    NSIndexPath *anIndexPath = [self.playersTableView indexPathForSelectedRow];
    self.gameModel.currentlySelectedPlayer = [self.exilablePlayersArray objectAtIndex:anIndexPath.row];
    self.exileTitleString = [NSString stringWithFormat:@"%@ %@?", GGKExileTitleString, self.gameModel.currentlySelectedPlayer.name];
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:self.exileTitleString message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [anAlertView show];
}
- (IBAction)verifyNoExile {
    NSString *aMessageString = [NSString stringWithFormat:@"%@ no one today?", GGKExileTitleString];
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:self.noExileTitleString message:aMessageString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
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
    self.noExileTitleString = [NSString stringWithFormat:@"No %@", GGKExileTitleString];
    self.exilablePlayersArray = [self.gameModel.remainingPlayersMutableArray copy];
    // Hermit must exile herself.
    if ([theDictatorPlayer.role.key isEqualToString:GGKHermitKeyString]) {
        self.noExileButton.enabled = NO;
        self.exilablePlayersArray = @[theDictatorPlayer];
    }
}
@end
