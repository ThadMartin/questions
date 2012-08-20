//
//  questionData.h
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionData : NSObject 

@property int answerIndex;
@property (copy) NSMutableArray * questionAnswers;
@property (copy) NSString * docPath;
@property (retain) QuestionData * thisQuestionData;

- (void)saveData:(NSMutableArray *)questionAnswers;

- (NSString *) createDataPath;

- (NSString *) getDateNow;

- (id)init;

@end
