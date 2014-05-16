//
//  GGKFeedbackViewController.h
//  Dictator
//
//  Created by Geoff Hom on 5/15/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKViewController.h"
#import <MessageUI/MessageUI.h>

@interface GGKFeedbackViewController : GGKViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
- (IBAction)emailCreators;
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
// So, dismiss the email view.
@end
