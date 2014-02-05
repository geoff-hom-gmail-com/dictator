//
//  GGKYourRoleViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKYourRoleViewController : GGKViewController

// Name of the player.
@property (strong, nonatomic) IBOutlet UILabel *playerNameLabel;

// If a member of a knowing team (e.g., Traitors, Masons), shows who the other members are.
@property (strong, nonatomic) IBOutlet UILabel *otherMembersLabel;

// Player's role info.
@property (strong, nonatomic) IBOutlet UILabel *roleInfoLabel;

// Ask for the next player. If done, go to first day.
- (IBAction)askForNextPlayerOrEnd;

// Override.
- (void)viewDidLoad;

@end
