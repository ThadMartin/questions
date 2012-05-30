//
//  questionData.m
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionData.h"
#import "questionsViewController.h"

@implementation QuestionData

@synthesize docPath = _docPath;
@synthesize questionAnswers = _questionAnswers;
@synthesize answerIndex = _answerIndex;

- (id)init {
    if ((self = [super init])) {        
    }
    return self;
}


- (NSString*) getDateNow{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd_MMMMyyyy_HH_mm_ss"];
    return [df stringFromDate:myDate];
}


- (BOOL)createDataPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat: @"/questions__%@__%@.txt",[[UIDevice currentDevice] name], [self getDateNow]];
    _docPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return TRUE;  //Later, do propper error checking...    
}


- (NSArray *)getQuestions {
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"questionList.txt"];  //now enpty newline at end.  
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];    
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    NSArray *lines = [string componentsSeparatedByString:@"\r"];  //  or \n?  Each line becomes a question.
    
    return lines;
}


- (void)saveData: (NSMutableArray *)questionAnswers: (int)numQuestions {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    [self createDataPath];  //get _docPath, includes filename.
    
    for (int writeIndex = 0;writeIndex < numQuestions;writeIndex++){          
        if (![fileManager fileExistsAtPath:_docPath]) {
            
            NSString *element = [[questionAnswers objectAtIndex:writeIndex] stringValue];
            
            element = [NSString stringWithFormat: @"%@\n", element];  //each entry on new line
            
            BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if (!success) 
                NSLog(@"%@", error);
            
        }
        
        else {   // the file already exists, so we should append the text to the end
            
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:_docPath];
            [fileHandle seekToEndOfFile];
            NSString *element = [[questionAnswers objectAtIndex:writeIndex] stringValue];
            element = [NSString stringWithFormat: @"%@\n", element];
            NSData *textData = [element dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:textData];
            
            [fileHandle closeFile];
        }   
        
    } //end of step through writing file.   
    
}

@end

