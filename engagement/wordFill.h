//
//  wordFill.h
//  engagement
//
//  Created by Thad Martin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wordFill : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *wordFillText;

@property (nonatomic, strong) NSString *infile;
@property (weak, nonatomic) NSArray * fields;
@property (weak, nonatomic) IBOutlet UILabel *wordFillLabel;
@property (weak, nonatomic) IBOutlet UIButton *wordFillSubmit;
- (IBAction)wordFillSubmitPressed:(id)sender;



@end
