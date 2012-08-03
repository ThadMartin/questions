//
//  speech.h
//  engagement
//
//  Created by Thad Martin on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface speech : UIViewController

@property (weak, nonatomic) NSArray * fields;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *speechLabel;

@end
