//
//  GGKPregameNightViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKPregameNightViewController : GGKViewController
// Name of the current player.
@property (strong, nonatomic) IBOutlet UILabel *currentPlayerNameLabel;
// User taps button to note they are said player.
@property (strong, nonatomic) IBOutlet UIButton *verifyPlayerButton;
// Override.
// Note: Works when the view appears from another view in this app, not from the app entering the foregroun.
- (void)viewWillAppear:(BOOL)animated;
@end
