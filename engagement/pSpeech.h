//
//  pSpeech.h
//  engagement
//
//  Created by Thad Martin on 11/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FliteTTS.h"

@class FliteTTS;

@interface pSpeech : UIViewController

@property (weak, nonatomic) NSArray * fields;
@property (strong) FliteTTS *fliteEngine;

@end
