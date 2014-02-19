//
//  GGKSetRolesViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/8/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKSetRolesViewController.h"

#import <QuartzCore/QuartzCore.h>
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
    
    // Because the assigned-roles table data is reloaded at the end, any selection there is removed but the button remains enabled. The button should be disabled.
    self.removeRoleButton.enabled = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)theSegue sender:(id)theSender
{
    if ([theSegue.identifier hasPrefix:@"ShowRoleInfoSegue"]) {
        
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

- (IBAction)remove1Role
{
    // Get selected role. -1. If 0, remove role. Update model. Update townspeople.
    // Because the table data is reloaded at the end, the selection is removed but the button remains enabled. If a role is still in the table, the user expects the role to still be selected and the button to remain enabled. Else, the button should be disabled.
    
    NSIndexPath *theSelectedIndexPath = self.assignedRolesTableView.indexPathForSelectedRow;
    GGKRole *theSelectedRole = self.allAssignedRolesArray[theSelectedIndexPath.row];
    
    GGKRole *aRole = [GGKRole role:theSelectedRole.key fromArray:self.explicitlyAssignedRolesMutableArray];
    aRole.startingCount--;
    BOOL reselectRow = YES;
    if (aRole.startingCount == 0) {
        
        [self.explicitlyAssignedRolesMutableArray removeObject:aRole];
        reselectRow = NO;
    }
    
    self.gameModel.explicitlyAssignedRolesArray = [self.explicitlyAssignedRolesMutableArray copy];
    
    [self updateAssignedRoles];
    
    if (reselectRow) {
        
        [self.assignedRolesTableView selectRowAtIndexPath:theSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        // Needed to scroll properly. See docs for selectRowAtIndexPath:animated:scrollPosition:.
        [self.assignedRolesTableView scrollToRowAtIndexPath:theSelectedIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
        self.removeRoleButton.enabled = YES;
    } else {
        
        self.removeRoleButton.enabled = NO;
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
    
    self.minimumNumberOfPlayersLabel.text = [NSString stringWithFormat:@"%d", theTotalCount];

    [self.assignedRolesTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Get number of players from model.
    self.numberOfPlayersInteger = [self.gameModel.allPlayersMutableArray count];
    self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%d", self.numberOfPlayersInteger];
    
    // Get available roles.
    self.availableRolesArray = [self.gameModel.availableRolesMutableArray copy];
    
    // Initialize assigned roles.
    GGKRole *theTownspersonRole = [GGKRole role:GGKTownspersonKeyString fromArray:self.availableRolesArray];
    theTownspersonRole.startingCount = self.numberOfPlayersInteger;
    self.allAssignedRolesArray = [NSArray arrayWithObject:theTownspersonRole];
    
    // Get previously-assigned roles.
    self.explicitlyAssignedRolesMutableArray = [self.gameModel.explicitlyAssignedRolesArray mutableCopy];
    [self updateAssignedRoles];
    
//    self.addRoleButton.layer.cornerRadius = 2;
//    self.addRoleButton.layer.borderWidth = 1;
//    self.addRoleButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.addRoleButton.enabled = NO;
    self.removeRoleButton.enabled = NO;
}

@end
