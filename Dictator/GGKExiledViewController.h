//
//  GGKExiledViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/4/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKExiledViewController : GGKViewController
// Label for showing who was exiled.
@property (strong, nonatomic) IBOutlet UILabel *exiledPlayerLabel;
// Label for showing the exiled player's role.
@property (strong, nonatomic) IBOutlet UILabel *exiledRoleLabel;
// Override.
- (void)viewDidLoad;
@end
