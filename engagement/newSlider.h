//
//  newSlider.h
//  engagement
//
//  Created by Thad Martin on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface newSlider : UIViewController <DBRestClientDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIView *moveBox;
@property (weak, nonatomic) IBOutlet UIView *qSlider;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UIButton *sliderSubmit;
@property (nonatomic, strong) NSString *infile;
- (IBAction)sliderSubmitPressed:(id)sender;
//@property (weak, nonatomic) IBOutlet UIView *linkButton;
- (IBAction)linkButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
//@property int answerIndex;
//@property (assign) NSArray * questionList;
//@property NSMutableArray questionAnswers;
//@property int numQuestions;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;

@end
