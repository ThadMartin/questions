//
//  engagementViewController.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>


@interface engagementViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIButton *linkButton;
- (IBAction)linkButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *unlinkButton;
- (IBAction)unlinkButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)continueButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *linkLabel;

@end
