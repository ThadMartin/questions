//
//  questionData.m
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionData.h"
#import <DropboxSDK/DropboxSDK.h>
#import "newSlider.h"
#import "engagementAppDelegate.h"

@implementation QuestionData 


@synthesize docPath = _docPath;
@synthesize questionAnswers = _questionAnswers;
@synthesize answerIndex = _answerIndex;
@synthesize thisQuestionData;

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

//find path, create file, and put the first entry in the file.  Return the path of the file to save more data to.  

- (NSString * )createDataPath{ 
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat: @"/questions__%@__%@.txt",[[UIDevice currentDevice] name], [self getDateNow]];
    _docPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSString * element = [NSString stringWithFormat: @"%@\n", _docPath];  
    
    BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!success) 
        NSLog(@"%@", error);
    
    return _docPath;  //Later, do propper error checking...    
}


- (NSArray *)getQuestions : (NSString *) infile{
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:infile];  //no enpty newline at end? 
    NSLog(@"\n %@ \n",questionListPath);
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];    
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    NSArray *lines = [string componentsSeparatedByString:@"\r"];  //  or \n?  Each line becomes a question.
    
    
    return lines;
    
}


- (void)saveData: (NSMutableArray *)questionAnswers{
    
    int answerLength = [questionAnswers count];
    
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    NSString * docPath = delegate.docPath;

    
    
    for (int writeIndex =0;writeIndex < answerLength;writeIndex++){          
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:docPath];
        [fileHandle seekToEndOfFile];
        NSString *element = [questionAnswers objectAtIndex:writeIndex] ;
        NSData *textData = [element dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:textData];
        
        [fileHandle closeFile];
        
    } //end of step through writing file.
    
    
}


@end

