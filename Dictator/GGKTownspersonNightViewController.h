//
//  GGKTownspersonNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/11/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKAbstractRoleNightViewController.h"

@interface GGKTownspersonNightViewController : GGKAbstractRoleNightViewController
// Override.
// Record who the Townsperson suspected as Traitor.
- (void)doRoleActions;
// Override.
- (void)viewDidLoad;
@end
