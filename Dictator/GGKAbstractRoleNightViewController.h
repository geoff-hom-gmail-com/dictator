//
//  GGKAbstractRoleNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

@interface GGKAbstractRoleNightViewController : GGKViewController
// If players still have night actions, go back and ask for next player. Else, go to night summary.
- (void)askForNextPlayerOrEnd;
// Do what the player said.
// Subclasses should override.
- (void)doRoleActions;
// The player finished, so do her actions.
- (IBAction)handlePlayerDone;
// Override.
- (void)viewDidLoad;
@end
