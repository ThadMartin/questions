//
//  picture.h
//  engagement
//
//  Created by Thad Martin on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface picture : UIViewController{

    IBOutlet UIImageView *imgView;
}

@property (weak, nonatomic) NSArray * fields;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)continueButtonPressed:(id)sender;

@end
