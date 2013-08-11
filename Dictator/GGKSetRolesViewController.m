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
#import "GGKRoleInfoViewController.h"

@interface GGKSetRolesViewController ()

// The roles for this game. An array of roles.
@property (strong, nonatomic) NSArray *allAssignedRolesArray;

// The roles available to assign to this game. 
@property (strong, nonatomic) NSArray *availableRolesArray;

// Roles the user specifically added to this game.
@property (strong, nonatomic) NSMutableArray *explicitlyAssignedRolesMutableArray;

@property (strong, nonatomic) GGKGameModel *gameModel;

// Number of players in this game.
@property (assign, nonatomic) NSInteger numberOfPlayersInteger;

// Traitor, then alphabetical.
- (void)reorderExplicitRoles;

// Update roles based on how many were explicitly assigned.
- (void)updateAssignedRoles;

@end

@implementation GGKSetRolesViewController

- (IBAction)add1Role
{
    // Get selected role. If already assigned, +1. Else, add role. Update model. Update townspeople.
    
    GGKRole *theSelectedRole = self.availableRolesArray[self.availableRolesTableView.indexPathForSelectedRow.row];
    
    GGKRole *aRole = [GGKRole role:theSelectedRole.key fromArray:self.explicitlyAssignedRolesMutableArray];
    if (aRole != nil) {
        
        aRole.startingCount++;
    } else {
        
        theSelectedRole.startingCount++;
        if (self.explicitlyAssignedRolesMutableArray == nil) {
            
            self.explicitlyAssignedRolesMutableArray = [NSMutableArray arrayWithObject:theSelectedRole];
        } else {
            
            [self.explicitlyAssignedRolesMutableArray addObject:theSelectedRole];
        }
        [self reorderExplicitRoles];
    }
    
    self.gameModel.explicitlyAssignedRolesArray = [self.explicitlyAssignedRolesMutableArray copy];
    
    [self updateAssignedRoles];
}

- (void)prepareForSegue:(UIStoryboardSegue *)theSegue sender:(id)theSender
{
    if ([theSegue.identifier hasPrefix:@"ShowRoleInfoSelector"]) {
        
        // Get role.
        NSIndexPath *theIndexPath = [self.availableRolesTableView indexPathForCell:theSender];
        GGKRole *theRole = self.availableRolesArray[theIndexPath.row];
        
        // Convey role.
        GGKRoleInfoViewController *aRoleInfoViewController = (GGKRoleInfoViewController *)theSegue.destinationViewController;
        aRoleInfoViewController.role = theRole;
    } else {
        
        [super prepareForSegue:theSegue sender:theSender];
    }
}

- (void)reorderExplicitRoles
{
    // Alphabetize. Move Traitor role to front.
    NSSortDescriptor *aNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *aSortedArray = [self.explicitlyAssignedRolesMutableArray sortedArrayUsingDescriptors:@[aNameSortDescriptor]];
    self.explicitlyAssignedRolesMutableArray = [aSortedArray mutableCopy];
    GGKRole *theTraitorRole = [GGKRole role:GGKTraitorKeyString fromArray:self.explicitlyAssignedRolesMutableArray];
    if (theTraitorRole != nil) {
        
        [self.explicitlyAssignedRolesMutableArray removeObject:theTraitorRole];
        [self.explicitlyAssignedRolesMutableArray insertObject:theTraitorRole atIndex:0];
    }
}

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
        GGKRole *aRole = [self.allAssignedRolesArray objectAtIndex:theIndexPath.row];
        aTableViewCell.textLabel.text = aRole.name;
        aTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%d", aRole.startingCount];
    }
    
    return aTableViewCell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)theIndexPath
{
    if (theTableView == self.availableRolesTableView) {
        
        // If the Townsperson, disable button.
        GGKRole *theRole = self.availableRolesArray[theIndexPath.row];
        if ([theRole.key isEqualToString:GGKTownspersonKeyString]) {
            
            self.addRoleButton.enabled = NO;
        } else {
            
            self.addRoleButton.enabled = YES;
        }
    } else if (theTableView == self.assignedRolesTableView) {
        
        // If the Townsperson, disable button.
        GGKRole *theRole = self.availableRolesArray[theIndexPath.row];
        if ([theRole.key isEqualToString:GGKTownspersonKeyString]) {
            
            self.removeRoleButton.enabled = NO;
        } else {
            
            self.removeRoleButton.enabled = YES;
        }
    }
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)theSection
{
    NSInteger theNumberOfRows = 0;
    if (theTableView == self.availableRolesTableView) {
        
        theNumberOfRows = [self.availableRolesArray count];
    } else if (theTableView == self.assignedRolesTableView) {
        
        theNumberOfRows = [self.allAssignedRolesArray count];
    }
    return theNumberOfRows;
}

- (void)updateAssignedRoles
{
    // Whoever isn't explicitly assigned should be a townsperson. Update the number of townspeople. May be negative.
    
    if (self.explicitlyAssignedRolesMutableArray == nil) {
        
        // Assign initial roles: all townspeople.
        GGKRole *theTownspersonRole = [GGKRole role:GGKTownspersonKeyString fromArray:self.availableRolesArray];
        theTownspersonRole.startingCount = self.numberOfPlayersInteger;
        self.allAssignedRolesArray = [NSArray arrayWithObject:theTownspersonRole];
    } else {
        
        // For each explicitly assigned role, get the count. Total those counts. Compare to number of players.
        NSInteger theTotalCount = 0;
        for (GGKRole *aRole in self.explicitlyAssignedRolesMutableArray) {
            
            theTotalCount += aRole.startingCount;
        }
        NSInteger theNumberOfTownspeople = self.numberOfPlayersInteger - theTotalCount;
        
        GGKRole *theTownspersonRole = [GGKRole role:GGKTownspersonKeyString fromArray:self.allAssignedRolesArray];
        theTownspersonRole.startingCount = theNumberOfTownspeople;
        
        NSArray *anArray = @[theTownspersonRole];
        self.allAssignedRolesArray = [anArray arrayByAddingObjectsFromArray:self.explicitlyAssignedRolesMutableArray];
    }
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
    
    self.addRoleButton.enabled = NO;
    self.removeRoleButton.enabled = NO;
    
    // Put table into editing mode.
//    [self.playersTableView setEditing:YES animated:NO];
}

@end
