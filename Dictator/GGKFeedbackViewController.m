//
//  GGKFeedbackViewController.m
//  Dictator
//
//  Created by Geoff Hom on 5/15/14.
//  Copyright (c) 2014 Geoff Hom. All rights reserved.
//

#import "GGKFeedbackViewController.h"

@interface GGKFeedbackViewController ()
@end

@implementation GGKFeedbackViewController
- (IBAction)emailCreators {
    MFMailComposeViewController *aMailComposeViewController = [[MFMailComposeViewController alloc] init];
    aMailComposeViewController.mailComposeDelegate = self;
    NSArray *theToRecipientsArray = @[@"antifinitygames@gmail.com"];
    [aMailComposeViewController setToRecipients:theToRecipientsArray];
    NSString *theAppName = @"Dictator!";
    [aMailComposeViewController setSubject:theAppName];
    // Include info helpful for debugging.
    NSString *theVersionString = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    UIDevice *theDevice = [UIDevice currentDevice];
    NSString *theMessageBody = [NSString stringWithFormat:@"(Version %@ on an %@ running iOS %@.)"
                                "\n\nFeedback:", theVersionString, theDevice.localizedModel, theDevice.systemVersion];
    [aMailComposeViewController setMessageBody:theMessageBody isHTML:NO];
    [self presentViewController:aMailComposeViewController animated:YES completion:nil];
}
- (void)mailComposeController:(MFMailComposeViewController *)theViewController didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [theViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Show version number.
    NSString *versionString = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", versionString];
}
@end
