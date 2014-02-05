//
//  GGKDictatorElectedViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/23/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKDictatorElectedViewController : GGKViewController
// Name of the current dictator.
@property (strong, nonatomic) IBOutlet UILabel *dictatorNameLabel;
// If player is dictator, she taps this button.
@property (strong, nonatomic) IBOutlet UIButton *verifyPlayerButton;
// Override.
- (void)viewDidLoad;
@end
