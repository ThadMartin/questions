//
//  titration.h
//  engagement
//
//  Created by Thad Martin on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@class questionParser;

@interface titration : UIViewController

@property (weak, nonatomic) NSArray * fields;

@property (weak, nonatomic) IBOutlet UILabel *multipleChoiceQuestion;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice1;
- (IBAction)choice1pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice2;
- (IBAction)choice2pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice3;
- (IBAction)choice3pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice4;
- (IBAction)choice4pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice5;
- (IBAction)choice5pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice6;
- (IBAction)choice6pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice7;
- (IBAction)choice7pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice8;
- (IBAction)choice8pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice9;
- (IBAction)choice9pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice10;
- (IBAction)choice10pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice11;
- (IBAction)choice11pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *choice12;
- (IBAction)choice12pressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *choice1Label;
@property (weak, nonatomic) IBOutlet UILabel *choice2Label;
@property (weak, nonatomic) IBOutlet UILabel *choice3Label;
@property (weak, nonatomic) IBOutlet UILabel *choice4Label;
@property (weak, nonatomic) IBOutlet UILabel *choice5Label;
@property (weak, nonatomic) IBOutlet UILabel *choice6Label;
@property (weak, nonatomic) IBOutlet UILabel *choice7Label;
@property (weak, nonatomic) IBOutlet UILabel *choice8Label;
@property (weak, nonatomic) IBOutlet UILabel *choice9Label;
@property (weak, nonatomic) IBOutlet UILabel *choice10Label;
@property (weak, nonatomic) IBOutlet UILabel *choice11Label;
@property (weak, nonatomic) IBOutlet UILabel *choice12Label;

- (void)highlightButton;

@property (assign, nonatomic) questionParser * questionParser;

@end
