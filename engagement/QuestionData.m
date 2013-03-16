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
#import "questionParser.h"

@implementation QuestionData 


@synthesize docPath = _docPath;
@synthesize questionAnswers = _questionAnswers;
@synthesize answerIndex = _answerIndex;
@synthesize thisQuestionData;
@synthesize questionParser;

- (id)init {
    if ((self = [super init])) {        
    }
    return self;
}


- (NSString*) getDateNow{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd_MMMMyyyy_HH_mm_ss.SSS"];
    return [df stringFromDate:myDate];
}

//find path, create file, and put the first entry in the file.  Return the path of the file to save more data to.  

- (NSString * )createDataPath{ 
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat: @"/questions__%@__%@.ans",[[UIDevice currentDevice] name], [self getDateNow]];
    _docPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSString * element = [NSString stringWithFormat: @"%@\n", _docPath];  
    
    BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!success) 
        NSLog(@"%@", error);
    
    return _docPath;  //Later, do propper error checking...    
}


- (void)saveData: (NSMutableArray *)questionAnswers{
    
    NSLog(@"questionData:save");
    
    int answerLength = [questionAnswers count];
    
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    NSString * docPath = delegate.docPath;
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:docPath];
    
    if (!fileExists){
        
        NSLog(@"Outfile is missing!");
        
        //outFileProblem * outPr = [[outFileProblem alloc] init];
        NSString * errorMsg = @"Output file does not exist.";
        
        questionParser * thisQuestionParser = [[questionParser alloc] init]; 
        [thisQuestionParser setOutFileError:(errorMsg)];
        
      //  [thisQuestionParser presentModalViewController:self animated:NO];

        
        //[self.questionParser setOutFileError:(errorMsg)];
        
        //[self presentModalViewController:outPr animated:false ];
    }

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:docPath];
    
    
    for (int writeIndex =0;writeIndex < answerLength;writeIndex++){          
        

        [fileHandle seekToEndOfFile];
        NSString *element = [questionAnswers objectAtIndex:writeIndex] ;
        
        element = [element stringByReplacingOccurrencesOfString:@"\n" withString:@"&NL"];
        
        NSData *textData = [element dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:textData];
                
    } //end of step through writing file.
    
    [fileHandle closeFile];    
    
}


@end

