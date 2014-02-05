//
//  GGKStartGameViewController.h
//  Dictator
//
//  Created by Geoff Hom on 8/11/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GGKViewController.h"

@interface GGKStartGameViewController : GGKViewController

@property (strong, nonatomic) IBOutlet UIButton *startButton;

// Calculate stuff for starting the game.
- (IBAction)startGame;
// Override.
// Note: Works when the view appears from another view in this app, not from the app entering the foregroun.
- (void)viewWillAppear:(BOOL)animated;

@end
