//
//  questionParser.h
//  engagement
//
//  Created by Thad Martin on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "multipleChoice.h"
#import "titration.h"
#import "branchTo.h"
#import "titrationBranch.h"
#import "QuestionData.h"

@interface questionParser : UIViewController

@property (nonatomic, weak) NSString *infile;
@property (assign) NSArray * questionLine;
@property (nonatomic) int lineNumber;
@property (nonatomic,strong) NSString * previousAnswer;

-(void) initializeRandomMatrix;

-(void) setOldAnswer:(NSString *)pAnswer;

-(void) setVerbalAnswer:(int)verCorrect;
-(void) setSpatialAnswer:(int)spaCorrect;

-(void) setInputFile:(NSString *)newFile;
-(void) setLineNbr:(int)lnNbr;

-(void) setInRnd:(BOOL)inRand;

-(void) setOutFileError:(NSString *)errDetails;

@end
