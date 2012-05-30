//
//  questionData.h
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionData;

@interface QuestionData: NSObject

@property int answerIndex;
@property (copy) NSMutableArray *questionAnswers;
@property (copy) NSString *docPath;

- (id)init;

- (void)saveData:(NSMutableArray *)questionAnswers: (int)numQuestions;

- (NSArray *) getQuestions;

@end
