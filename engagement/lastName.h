//
//  lastName.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionData.h"

@interface lastName : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;

@property(nonatomic, strong) NSString *filePath;


@end
