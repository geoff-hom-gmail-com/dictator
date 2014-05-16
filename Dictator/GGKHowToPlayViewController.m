//
//  GGKHowToPlayViewController.m
//  Dictator
//
//  Created by Geoff Hom on 5/15/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKHowToPlayViewController.h"

#import "GGKGameModel.h"
@interface GGKHowToPlayViewController ()
- (void)showText;
@end

@implementation GGKHowToPlayViewController
- (void)showText {
    NSMutableAttributedString *aMutableAttributedString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *anAttributedString;
    UIFont *aRegularFont = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    UIFont *aBoldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\"Dictator!\" is a party game in the vein of Werewolf, Mafia and Witch Hunt, but with a key twist! Instead of voting on a player to remove from the game, the players vote for one player to be the Dictator, and then the Dictator decides whom to remove!"
        "\n\nThis official Dictator! app includes all the roles and rules needed to play this exciting social game on one phone. All you need to supply is a group of friends to play!" attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nTeams" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nTown:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    NSString *aString = [NSString stringWithFormat:@" If you are on the Town team, your goal is to figure out who the Traitors are and %@ them. Each day, all the players elect a Dictator by majority vote. Try to make sure the Dictator isn’t a Traitor! The Dictator's your best chance to %@ Traitors.", GGKExileString, GGKExileString];
    anAttributedString = [[NSAttributedString alloc] initWithString:aString attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nTraitor:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    aString = [NSString stringWithFormat:@" If you are on the Traitor team, your goal is to %@ or %@ enough Townspeople so that the Traitors are in the majority. Each night, the Traitors conduct a secret vote to %@ one player.", GGKExileString, GGKEliminateString, GGKEliminateString];
    anAttributedString = [[NSAttributedString alloc] initWithString:aString attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nStarting the Game" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nAdd/Remove Players:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@" Here you can add or remove the players who will be in your game. By organizing them in the order you are sitting, you can simplify passing your device." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nSet Roles:" attributes:@{NSFontAttributeName:aBoldFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@" Here you can add or remove which Roles will appear in your game. The number of Townspeople is automatically set to fill all the roles you don’t set." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nFirst Night" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nAt the start of the game, you get a description of who you are and what you can do. If are a Traitor, it pays to pretend to be a Townsperson." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nDay Phase" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    aString = [NSString stringWithFormat:@"\nEach day, the players elect one person to be the Dictator. The Dictator  then picks one player to %@. After the Dictator acts, the game proceeds to the night phase.", GGKExileString];
    anAttributedString = [[NSAttributedString alloc] initWithString:aString attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\n\nNight Phase" attributes:@{NSFontAttributeName:aRegularFont, NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    anAttributedString = [[NSAttributedString alloc] initWithString:@"\nEach night, the Traitors (and certain other roles) make their decisions. Also, the other players are asked to pick a player they find suspicious, to help disguise who's who. Once everyone has acted, a summary of the night is read aloud, and a new day begins." attributes:@{NSFontAttributeName:aRegularFont}];
    [aMutableAttributedString appendAttributedString:anAttributedString];
    self.textView.attributedText = [aMutableAttributedString copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showText];
}
@end
