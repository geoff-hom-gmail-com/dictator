//
//  GGKStartGameViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/11/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKStartGameViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"
#import "GGKPlayer.h"
#import "GGKRole.h"

@interface GGKStartGameViewController ()

@property (strong, nonatomic) GGKGameModel *gameModel;

// Number of (plain) Townspeople in the game.
@property (assign, nonatomic) NSInteger numberOfTownspeople;

@end

@implementation GGKStartGameViewController

- (IBAction)startGame
{
    // Make an array of all roles. Remove random role: assign to first player. Repeat.
    
    NSMutableArray *theAssignedRolesMutableArray = [NSMutableArray arrayWithCapacity:30];
    for (GGKRole *aRole in self.gameModel.explicitlyAssignedRolesArray) {
        
        for (int i = 0; i < aRole.startingCount; i++) {
            
            GGKRole *anIndividualRole = [[GGKRole alloc] initWithType:aRole.key];
            [theAssignedRolesMutableArray addObject:anIndividualRole];
        }
    }
    for (int i = 0; i < self.numberOfTownspeople; i++) {
        
        GGKRole *anIndividualRole = [[GGKRole alloc] initWithType:GGKTownspersonKeyString];
        [theAssignedRolesMutableArray addObject:anIndividualRole];
    }
    
    for (GGKPlayer *aPlayer in self.gameModel.allPlayersArray) {
        
        uint32_t aRandomNumberInt = arc4random_uniform([theAssignedRolesMutableArray count]);
        GGKRole *theAssignedRole = [theAssignedRolesMutableArray objectAtIndex:aRandomNumberInt];
        aPlayer.role = theAssignedRole;
        [theAssignedRolesMutableArray removeObject:theAssignedRole];
    }
    
    self.gameModel.remainingPlayersMutableArray = [self.gameModel.allPlayersArray mutableCopy];
    
    self.gameModel.currentPlayer = self.gameModel.allPlayersArray[0];
    
    // Check via log. For testing.
    for (GGKPlayer *aPlayer in self.gameModel.allPlayersArray) {
    
        NSLog(@"SGVC player name: %@, role: %@", aPlayer.name, aPlayer.role.name);
    }
    
    [self performSegueWithIdentifier:@"ShowPregameSegue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    GGKAppDelegate *theAppDelegate = (GGKAppDelegate *)[UIApplication sharedApplication].delegate;
    self.gameModel = theAppDelegate.gameModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Enable start only if players >= minimum players.
    
    NSInteger theNumberOfPlayersInteger = [self.gameModel.allPlayersArray count];
    NSInteger theMinimumNumberOfPlayersInteger = 0;
    for (GGKRole *aRole in self.gameModel.explicitlyAssignedRolesArray) {
        
        theMinimumNumberOfPlayersInteger += aRole.startingCount;
    }
    self.numberOfTownspeople = theNumberOfPlayersInteger - theMinimumNumberOfPlayersInteger;
    if (theNumberOfPlayersInteger > 0 && self.numberOfTownspeople >= 0) {
        
        self.startButton.enabled = YES;
    } else {
        
        self.startButton.enabled = NO;
    }
}

@end
