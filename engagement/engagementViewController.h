//
//  engagementViewController.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>


@interface engagementViewController : UIViewController  <DBRestClientDelegate>

@property (weak, nonatomic) IBOutlet UIButton *linkButton;
- (IBAction)linkButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *unlinkButton;
- (IBAction)unlinkButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
- (IBAction)downloadButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)continueButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

- (IBAction)uploadButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;
- (IBAction)quitPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *clearMemory;
- (IBAction)clearMemoryPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *downloadDirLabel;
@property (weak, nonatomic) IBOutlet UITextField *downloadDirTxt;
@property (weak, nonatomic) IBOutlet UIButton *downloadDirChange;
- (IBAction)downloadDirChangePressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *uploadDirLabel;
@property (weak, nonatomic) IBOutlet UITextField *uploadDirText;
@property (weak, nonatomic) IBOutlet UIButton *uploadDirChange;
- (IBAction)uploadDirChangePressed:(id)sender;


@end
