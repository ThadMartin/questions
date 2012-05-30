//
//  questionsViewController.h
//  questions
//
//  Created by Thad Martin on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *sliderOne;
@property (weak, nonatomic) IBOutlet UIButton *butonTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;

- (IBAction)sliderOneMoved:(id)sender;
- (IBAction)buttonTwoPressed:(id)sender;

@end
