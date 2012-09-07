//
//  questionParser.h
//  engagement
//
//  Created by Thad Martin on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionParser : UIViewController

@property (nonatomic, weak) NSString *infile;
@property (assign) NSArray * questionLine;
@property (nonatomic) int lineNumber;
@property (nonatomic,strong) NSString * previousAnswer;

-(void) branchTo;
-(void) initializeRandomMatrix;

@end
