//
//  GGKGameOverViewController.h
//  Dictator
//
//  Created by Geoff Hom on 2/19/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"

@interface GGKGameOverViewController : GGKViewController
// User can see the results.
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
- (IBAction)goToMainMenu;
// Override.
- (void)viewDidLoad;
@end
