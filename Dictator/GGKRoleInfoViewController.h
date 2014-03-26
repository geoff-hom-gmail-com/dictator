//
//  GGKRoleInfoViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"
@class GGKRole;

@interface GGKRoleInfoViewController : GGKViewController

// The role to display info about.
@property (strong, nonatomic) GGKRole *role;

// Role title.
@property (strong, nonatomic) IBOutlet UILabel *roleTitleLabel;

// Role blurb, detailed.
@property (strong, nonatomic) IBOutlet UILabel *roleBlurbDetailedLabel;
// Override.
- (void)viewDidLoad;
@end
