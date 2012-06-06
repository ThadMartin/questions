//
//  newSlider.h
//  engagement
//
//  Created by Thad Martin on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <DropboxSDK/DropboxSDK.h>

@interface newSlider : UIViewController //<DBRestClientDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIView *moveBox;
@property (weak, nonatomic) IBOutlet UIView *qSlider;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UIButton *sliderSubmit;
@property (nonatomic, strong) NSString *infile;
@property (weak, nonatomic) NSArray * fields;
- (IBAction)sliderSubmitPressed:(id)sender;
//- (IBAction)linkButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
//@property (weak, nonatomic) IBOutlet UIButton *linkButton;

@end
