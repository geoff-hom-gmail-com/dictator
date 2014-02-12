//
//  GGKTraitorNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

@interface GGKTraitorNightViewController : GGKAbstractRoleNightViewController
// Override.
// traitor: eliminate player(s), record who they prefer, etc.
- (void)doRoleActions;
// Override.
- (void)viewDidLoad;
@end
