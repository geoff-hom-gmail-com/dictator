//
//  GGKHowToPlayViewController.m
//  Dictator
//
//  Created by Geoff Hom on 5/15/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKHowToPlayViewController.h"

@interface GGKHowToPlayViewController ()
- (void)showText;
@end

@implementation GGKHowToPlayViewController
- (void)showText {
    NSMutableAttributedString *aMutableAttributedString;
    UIFont *aRegularFont = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    UIFont *aBoldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    aMutableAttributedString = [[NSMutableAttributedString alloc] initWithString:@"\nTown:" attributes:@{NSFontAttributeName:aBoldFont}];
    NSAttributedString *anAttributedString = [[NSAttributedString alloc] initWithString:@" If you win with the town, your objective is to figure out who the traitors are, and exile them. Each day, all the players will elect a Dictator by majority vote, try to make sure the Dictator isn’t a Traitor! This is your chance to eliminate Traitors." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nTraitor:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@" If you win with the traitors, your objective is to exile enough townspeople that the traitors are in the majority. Each night, the traitor who goes last will get to choose one player and exile them." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nStarting the Game" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nAdd/Remove Players:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@" Here you can add or remove the players who will be in your game. By organizing them in the order you are sitting you can simplify passing your device." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nSet Roles:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@" Here you can add or remove which Roles will appear in your game. The number of Townies is automatically set to fill all the roles you don’t set. “Either” roles will be assigned randomly to players who don’t have a role (basic traitors and townies.)" attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    self.textView.attributedText = [aMutableAttributedString copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showText];
}
@end
