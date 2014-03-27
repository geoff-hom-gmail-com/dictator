//
//  GGKPrivateEyeNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 3/26/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKPrivateEyeNightViewController.h"

#import "GGKGameModel.h"

@interface GGKPrivateEyeNightViewController ()
// All remaining players, minus this one.
@property (strong, nonatomic) NSArray *remainingPlayersMinusSelfArray;
@end

@implementation GGKPrivateEyeNightViewController
- (void)doRoleActions {
    [super doRoleActions];
    NSIndexPath *theSelectedIndexPath = [self.remainingPlayersMinusSelfTableView indexPathForSelectedRow];
    GGKPlayer *theTargetPlayer = self.remainingPlayersMinusSelfArray[theSelectedIndexPath.row];
    NSString *theWinConditionString = @"Town";
    if (theTargetPlayer.role.isTraitor) {
        theWinConditionString = @"Traitors";
    }
    NSString *theMessageString = [NSString stringWithFormat:@"%@ wins with the %@.", theTargetPlayer.name, theWinConditionString];
    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:@"Investigation Complete" message:theMessageString delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [anAlertView show];
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
    self.thisPersonButton.enabled = NO;
    // Make list of remaining players, minus this Townsperson.
    NSMutableArray *aTestMutableArray = [self.gameModel.remainingPlayersMutableArray mutableCopy];
    [aTestMutableArray removeObject:self.gameModel.currentPlayer];
    self.remainingPlayersMinusSelfArray = [aTestMutableArray copy];
}
@end
