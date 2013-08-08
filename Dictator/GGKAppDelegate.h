//
//  GGKAppDelegate.h
//  Dictator
//
//  Created by Geoff Hom on 8/7/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

@class GGKGameModel;

@interface GGKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) GGKGameModel *gameModel;

@property (strong, nonatomic) UIWindow *window;

@end
