//
//  numberFill.h
//  engagement
//
//  Created by Thad Martin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface numberFill : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) NSArray * fields;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *numberFillText;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersPlease;

@end
