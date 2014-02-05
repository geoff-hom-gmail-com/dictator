//
//  GGKDictatorElectedViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKDictatorElectedViewController.h"

#import "GGKGameModel.h"

@interface GGKDictatorElectedViewController ()
@end

@implementation GGKDictatorElectedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Show whose turn it is.
    NSString *aName = self.gameModel.currentDictatorPlayer.name;
    self.dictatorNameLabel.text = aName;
    NSString *theButtonTitleString = [NSString stringWithFormat:@"I am %@", aName];
    [self.verifyPlayerButton setTitle:theButtonTitleString forState:UIControlStateNormal];
}
@end
