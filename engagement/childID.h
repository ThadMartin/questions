//
//  childID.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface childID : UIViewController

@property (nonatomic, strong) NSString *filePath;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end