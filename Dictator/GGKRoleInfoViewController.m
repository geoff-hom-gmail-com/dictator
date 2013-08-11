//
//  GGKRoleInfoViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/10/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKRoleInfoViewController.h"

#import "GGKRole.h"

@interface GGKRoleInfoViewController ()

@end

@implementation GGKRoleInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.roleTitleLabel.text = self.role.name;
    self.roleBlurbDetailedLabel.text = self.role.blurb1;
}

@end
