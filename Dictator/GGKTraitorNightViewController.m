//
//  GGKTraitorNightViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKTraitorNightViewController.h"

#import "GGKGameModel.h"

@interface GGKTraitorNightViewController ()
// Players who already received elimination votes tonight.
@property (strong, nonatomic) NSMutableArray *hitListMutableArray;
@end

@implementation GGKTraitorNightViewController
- (void)doRoleActions {
    [super doRoleActions];
    NSIndexPath *theSelectedIndexPath = [self.remainingPlayersTableView indexPathForSelectedRow];
    GGKPlayer *theSelectedPlayer = [self.gameModel.remainingPlayersMutableArray objectAtIndex:theSelectedIndexPath.row];
    theSelectedPlayer.numberOfVotesThisRoundInteger++;
    [self askForNextPlayerOrEnd];
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath {
    UITableViewCell *aTableViewCell;
    if (theTableView == self.hitListTableView) {
        aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:@"HitListCell"];
        GGKPlayer *aPlayer = [self.hitListMutableArray objectAtIndex:theIndexPath.row];
        aTableViewCell.textLabel.text = aPlayer.name;
        aTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)aPlayer.numberOfVotesThisRoundInteger];
    } else if (theTableView == self.remainingPlayersTableView) {
        aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:@"PlayerNameCell"];
        GGKPlayer *aPlayer = [self.gameModel.remainingPlayersMutableArray objectAtIndex:theIndexPath.row];
        aTableViewCell.textLabel.text = aPlayer.name;
    }
    return aTableViewCell;
}
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath {
    self.thisPersonButton.enabled = YES;
}
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection {
    NSInteger theNumberOfRowsInteger = 0;
    if (theTableView == self.hitListTableView) {
        theNumberOfRowsInteger = [self.hitListMutableArray count];
    } else if (theTableView == self.remainingPlayersTableView) {
        theNumberOfRowsInteger = [self.gameModel.remainingPlayersMutableArray count];
    }
    return theNumberOfRowsInteger;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.thisPersonButton.enabled = NO;
    // Make list of players who already received elimination votes.
    self.hitListMutableArray = [NSMutableArray arrayWithCapacity:5];
    [self.gameModel.remainingPlayersMutableArray enumerateObjectsUsingBlock:^(GGKPlayer *aPlayer, NSUInteger idx, BOOL *stop) {
        if (aPlayer.numberOfVotesThisRoundInteger >= 1) {
            [self.hitListMutableArray addObject:aPlayer];
        }
    }];
}
@end
