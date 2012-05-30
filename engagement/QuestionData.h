//
//  questionData.h
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>


DBRestClient *restClient;

@class DBRestClient;

@class QuestionData;


@interface QuestionData: NSObject

@property int answerIndex;
@property (copy) NSMutableArray * questionAnswers;
@property (copy) NSString * docPath;
@property (retain) QuestionData * thisQuestionData;

- (id)init;

- (void)saveData:(NSMutableArray *)questionAnswers: (int)numQuestions: (NSString *) docPath;

- (NSArray *) getQuestions;

- (NSString *) createDataPath: (NSMutableArray *)firstName;

- (void) uploadToDropBox:(NSString *) filePath;


@end
