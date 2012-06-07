//
//  instruction.h
//  engagement
//
//  Created by Thad Martin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface instruction : UIViewController

@property (weak, nonatomic) NSArray * fields;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)continueButtonPressed:(id)sender;


@end
