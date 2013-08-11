//
//  GGKSetRolesViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/8/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKSetRolesViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"
#import "GGKRole.h"

@interface GGKSetRolesViewController ()

// The roles for this game. An array of roles.
@property (strong, nonatomic) NSMutableArray *allAssignedRolesMutableArray;

// The roles available to assign to this game. 
@property (strong, nonatomic) NSArray *availableRolesArray;

// Roles the user specifically added to this game.
@property (strong, nonatomic) NSMutableArray *explicitlyAssignedRolesMutableArray;

@property (strong, nonatomic) GGKGameModel *gameModel;

// Number of players in this game.
@property (assign, nonatomic) NSInteger numberOfPlayersInteger;

// Update roles based on how many were explicitly assigned.
- (void)updateAssignedRoles;

@end

@implementation GGKSetRolesViewController

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    UITableViewCell *aTableViewCell;
    static NSString *theCellIdentifier;
    if (theTableView == self.availableRolesTableView) {
        
        theCellIdentifier = @"AvailableRoleCell";
        aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:theCellIdentifier];
        if (aTableViewCell == nil) {
            
            aTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:theCellIdentifier];
        }
        GGKRole *aRole = [self.availableRolesArray objectAtIndex:theIndexPath.row];
        aTableViewCell.textLabel.text = aRole.name;
        aTableViewCell.detailTextLabel.text = aRole.blurb1;
    } else if (theTableView == self.assignedRolesTableView) {
        
        theCellIdentifier = @"AssignedRoleCell";
        aTableViewCell = [theTableView dequeueReusableCellWithIdentifier:theCellIdentifier];
        if (aTableViewCell == nil) {
            
            // This should be the same as the "right detail" style in the storyboard.
            aTableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:theCellIdentifier];
        }
        GGKRole *aRole = [self.allAssignedRolesMutableArray objectAtIndex:theIndexPath.row];
        aTableViewCell.textLabel.text = aRole.name;
        aTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%d", aRole.startingCount];
    }
    
    return aTableViewCell;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection
{
    NSInteger theNumberOfRows = 0;
    if (theTableView == self.availableRolesTableView) {
        
        theNumberOfRows = [self.availableRolesArray count];
    } else if (theTableView == self.assignedRolesTableView) {
        
        theNumberOfRows = [self.allAssignedRolesMutableArray count];
    }
    return theNumberOfRows;
}

- (void)updateAssignedRoles
{
    // Whoever isn't explicitly assigned should be a townsperson. Update the number of townspeople. May be negative.
    
    // calculate
    // update the data
    // update the table
    // update the game model
    
    // for each explicitly assigned role, get the count. total those counts. compare to number of players.
    
    if (self.explicitlyAssignedRolesMutableArray == nil) {
        
        // Assign initial roles: all townspeople.
        GGKRole *theTownspersonRole = [GGKRole role:GGKTownspersonKeyString fromArray:self.availableRolesArray];
        theTownspersonRole.startingCount = self.numberOfPlayersInteger;
        self.allAssignedRolesMutableArray = [NSMutableArray arrayWithObject:theTownspersonRole];        
    }
    
//    NSInteger theNumberOfUnassignedPlayers = [self.gameModel.allPlayersArray count] - [self.explicitlyAssignedRolesMutableArray count];
    
    [self.assignedRolesTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Get number of players from model.
    
    GGKAppDelegate *theAppDelegate = (GGKAppDelegate *)[UIApplication sharedApplication].delegate;
    self.gameModel = theAppDelegate.gameModel;
    
    self.numberOfPlayersInteger = [self.gameModel.allPlayersArray count];
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%d", self.numberOfPlayersInteger];
    
    // Get available roles.
    self.availableRolesArray = [self.gameModel.availableRolesMutableArray copy];
    
    // Get previously-assigned roles.
    self.explicitlyAssignedRolesMutableArray = [self.gameModel.explicitlyAssignedRolesArray mutableCopy];
    [self updateAssignedRoles];
    
    
        
    
    // Put table into editing mode.
//    [self.playersTableView setEditing:YES animated:NO];
}

@end
