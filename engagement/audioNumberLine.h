//
//  audioNumberLine.h
//  engagement
//
//  Created by Thad Martin on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class FliteTTS;

@interface audioNumberLine : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel * questionLabel;
@property (weak, nonatomic) IBOutlet UIView * moveBox;
@property (weak, nonatomic) IBOutlet UIView * qSlider;
@property (weak, nonatomic) IBOutlet UILabel * lowLabel;
@property (weak, nonatomic) IBOutlet UIButton * sliderSubmit;
@property (nonatomic, strong) NSString * infile;
@property (weak, nonatomic) NSArray * fields;
- (IBAction)sliderSubmitPressed:(id)sender;
 @property (weak, nonatomic) IBOutlet UILabel * highLabel;

@property (strong) FliteTTS *fliteEngine;
 
@end
