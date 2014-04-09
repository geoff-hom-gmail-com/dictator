//
//  GGKChoosePlayerNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 3/27/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKChoosePlayerNightViewController.h"

#import "GGKGameModel.h"

@interface GGKChoosePlayerNightViewController ()
// Current player's role.
@property (strong, nonatomic) GGKRole *currentRole;
// All remaining players, minus this one.
@property (strong, nonatomic) NSArray *remainingPlayersMinusSelfArray;
@end

@implementation GGKChoosePlayerNightViewController
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self askForNextPlayerOrEnd];
}
- (void)doRoleActions {
    [super doRoleActions];
    NSIndexPath *theSelectedIndexPath = [self.remainingPlayersMinusSelfTableView indexPathForSelectedRow];
    GGKPlayer *theChosenPlayer = self.remainingPlayersMinusSelfArray[theSelectedIndexPath.row];
    NSString *theCurrentRoleString = self.currentRole.key;
    if ([@[GGKTownspersonKeyString, GGKHermitKeyString] containsObject:theCurrentRoleString]) {
        [self askForNextPlayerOrEnd];
    } else if ([theCurrentRoleString isEqualToString:GGKDoctorKeyString]) {
        [self.gameModel.playersToSaveMutableArray addObject:theChosenPlayer];
        [self askForNextPlayerOrEnd];
    } else if ([theCurrentRoleString isEqualToString:GGKPrivateEyeKeyString]) {
        NSString *theWinConditionString = @"Town";
        // Kingpin with other Traitor remaining appears as Townie.
        BOOL aKingpinPowerPertains = NO;
        if ([theChosenPlayer.role.key isEqualToString:GGKKingpinKeyString]) {
            for (GGKPlayer *aPlayer in self.gameModel.remainingPlayersMutableArray) {
                if (aPlayer.role.isTraitor && aPlayer != theChosenPlayer) {
                    aKingpinPowerPertains = YES;
                    break;
                }
            }
        }
        if (theChosenPlayer.role.isTraitor && !aKingpinPowerPertains) {
            theWinConditionString = @"Traitors";
        }
        NSString *theMessageString = [NSString stringWithFormat:@"%@ wins with the %@.", theChosenPlayer.name, theWinConditionString];
        UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:@"Investigation Complete" message:theMessageString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [anAlertView show];
    } else if ([theCurrentRoleString isEqualToString:GGKVigilanteKeyString]) {
        if (![self.gameModel.playersToVigilanteEliminateMutableArray containsObject:theChosenPlayer]) {
            [self.gameModel.playersToVigilanteEliminateMutableArray addObject:theChosenPlayer];
        }
        [self askForNextPlayerOrEnd];
    } else {
        NSLog(@"CPNVC warning: unknown role, %@", theCurrentRoleString);
    }
}
- (IBAction)handleNoOneChosen {
    NSString *theCurrentRoleString = self.currentRole.key;
    if ([theCurrentRoleString isEqualToString:GGKVigilanteKeyString]) {
        [self askForNextPlayerOrEnd];
    } else {
        NSLog(@"hNOC warning: unknown role, %@", theCurrentRoleString);
    }
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath {
    UITableViewCell *aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:@"PlayerNameCell"];
    GGKPlayer *aPlayer = [self.remainingPlayersMinusSelfArray objectAtIndex:theIndexPath.row];
    aTableViewCell.textLabel.text = aPlayer.name;
    return aTableViewCell;
}
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath {
    self.thisPersonButton.enabled = YES;
}
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection {
    return [self.remainingPlayersMinusSelfArray count];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.currentRole = self.gameModel.currentPlayer.role;
    NSString *theCurrentRoleString = self.currentRole.key;
    self.navigationItem.title = theCurrentRoleString;
    NSString *thePromptString;
    if ([@[GGKTownspersonKeyString, GGKHermitKeyString] containsObject:theCurrentRoleString]) {
        thePromptString = @"Who do you think is a Traitor?";
    } else if ([theCurrentRoleString isEqualToString:GGKDoctorKeyString]) {
        thePromptString = @"Save whom?";
    } else if ([theCurrentRoleString isEqualToString:GGKPrivateEyeKeyString]) {
        thePromptString = @"Investigate whom?";
    } else if ([theCurrentRoleString isEqualToString:GGKVigilanteKeyString]) {
        thePromptString = [NSString stringWithFormat:@"%@ whom?", GGKEliminateTitleString];
    } else {
        NSLog(@"CPNVC warning: unknown role, %@", theCurrentRoleString);
    }
    self.promptLabel.text = thePromptString;
    NSArray *theRolesWhichCanPassArray = @[GGKVigilanteKeyString];
    if ([theRolesWhichCanPassArray containsObject:theCurrentRoleString]) {
        self.noOneButton.hidden = NO;
    } else {
        self.noOneButton.hidden = YES;
    }
    self.thisPersonButton.enabled = NO;
    // Make list of remaining players, minus this one.
    NSMutableArray *aTestMutableArray = [self.gameModel.remainingPlayersMutableArray mutableCopy];
    [aTestMutableArray removeObject:self.gameModel.currentPlayer];
    self.remainingPlayersMinusSelfArray = [aTestMutableArray copy];
}
@end
