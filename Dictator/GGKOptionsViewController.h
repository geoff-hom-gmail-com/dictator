//
//  GGKOptionsViewController.h
//  Dictator
//
//  Created by Geoff Hom on 5/23/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

@interface GGKOptionsViewController : GGKViewController
@property (weak, nonatomic) IBOutlet UILabel *electionHasTimeLimitLabel;
@property (weak, nonatomic) IBOutlet UISwitch *electionHasTimeLimitSwitch;
- (IBAction)handleElectionHasTimeLimitSwitchChanged:(id)sender;
// Override.
- (void)viewDidLoad;
@end
