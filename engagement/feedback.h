//
//  feedback.h
//  engagement
//
//  Created by Thad Martin on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface feedback : UIViewController

@property (weak, nonatomic) NSArray * fields;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (nonatomic,strong) NSString * previousAnswer;

- (IBAction)continueButtonPressed:(id)sender;


@end
