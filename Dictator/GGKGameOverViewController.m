//
//  GGKGameOverViewController.m
//  Dictator
//
//  Created by Geoff Hom on 2/19/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKGameOverViewController.h"
#import "GGKGameModel.h"

@interface GGKGameOverViewController ()

@end

@implementation GGKGameOverViewController
- (IBAction)goToMainMenu {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *summaryText;
    if (self.gameModel.townDidWinBOOL) {
        summaryText = @"The Townspeople win!";
    } else {
        summaryText = @"The Traitors win!";
    }
    self.summaryLabel.text = summaryText;
}
@end
