//
//  branchTo.h
//  engagement
//
//  Created by Thad Martin on 11/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class questionParser;

@interface branchTo : UIViewController

@property (weak, nonatomic) NSArray * fields;
@property (assign, nonatomic) questionParser * questionParser;

@end
