//
//  GGKTownspersonNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKTownspersonNightViewController.h"

#import "GGKGameModel.h"

@interface GGKTownspersonNightViewController ()
// All remaining players, minus this Townsperson.
@property (strong, nonatomic) NSArray *remainingPlayersMinusSelfArray;
@end

@implementation GGKTownspersonNightViewController
- (void)doRoleActions {
    [super doRoleActions];
    // Could store a history of each player's guesses and report them at the end. For now, just log it.
    NSIndexPath *theSelectedIndexPath = [self.remainingPlayersMinusSelfTableView indexPathForSelectedRow];
    GGKPlayer *theSuspectedPlayer = self.remainingPlayersMinusSelfArray[theSelectedIndexPath.row];
    NSLog(@"ToNVC tV dSRAIP suspected player: %@", theSuspectedPlayer.name);
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
