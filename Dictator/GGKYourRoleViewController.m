//
//  GGKYourRoleViewController.m
//  Dictator
//
//  Created by Geoff Hom on 8/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//

#import "GGKYourRoleViewController.h"

#import "GGKAppDelegate.h"
#import "GGKGameModel.h"

@interface GGKYourRoleViewController ()

@property (strong, nonatomic) GGKGameModel *gameModel;

@end

@implementation GGKYourRoleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    GGKAppDelegate *theAppDelegate = (GGKAppDelegate *)[UIApplication sharedApplication].delegate;
    self.gameModel = theAppDelegate.gameModel;
    
    GGKPlayer *theCurrentPlayer = self.gameModel.currentPlayer;
    self.playerNameLabel.text = theCurrentPlayer.name;
    self.roleInfoLabel.text = theCurrentPlayer.role.youAreBlurb1;
    
    if (theCurrentPlayer.role.isTraitor) {
        
        self.otherMembersLabel.hidden = NO;
        
        // Show names of other traitors, or none if only 1.
        // Make string of each other traitor's name. Show it.
        
        NSMutableString *theOtherTraitorsMutableString;
        for (GGKPlayer *aPlayer in self.gameModel.allPlayersArray) {
            
            if (aPlayer == theCurrentPlayer) {
                
                continue;
            }
            if (aPlayer.role.isTraitor) {
                
                if (theOtherTraitorsMutableString == nil) {
                    
                    theOtherTraitorsMutableString = [NSMutableString stringWithFormat:@"%@", aPlayer.name];
                } else {
                    
                    [theOtherTraitorsMutableString appendFormat:@", %@", aPlayer.name];
                }
            }
        }
        if (theOtherTraitorsMutableString == nil) {
            
            theOtherTraitorsMutableString = [NSMutableString stringWithFormat:@"none"];
        }
        
        self.otherMembersLabel.text = [NSString stringWithFormat:@"Your fellow Traitors are: %@.", theOtherTraitorsMutableString];
    } else {
        
        self.otherMembersLabel.hidden = YES;
    }
}

@end
