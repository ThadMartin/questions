//
//  questionData.m
//  questions
//
//  Created by Thad Martin on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionData.h"
#import "questionsViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface QuestionData () <DBRestClientDelegate>

@property (nonatomic, readonly) DBRestClient* restClient;

@end


@implementation QuestionData

@synthesize docPath = _docPath;
@synthesize questionAnswers = _questionAnswers;
@synthesize answerIndex = _answerIndex;
//@synthesize filePath;
@synthesize thisQuestionData;

- (id)init {
    if ((self = [super init])) {        
    }
    //QuestionData * hereQuestionData = [[QuestionData alloc] init];
    //hereQuestionData = questionData;
    return self;
}


- (NSString*) getDateNow{
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd_MMMMyyyy_HH_mm_ss"];
    return [df stringFromDate:myDate];
}

//find path, create file, and put the first entry in the file.  Return the path of the file to save more data to.  Takes array with only one entry.

- (NSString * )createDataPath: (NSMutableArray *)firstName { 
    
    NSError *error;

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat: @"/engagement__%@__%@.txt",[[UIDevice currentDevice] name], [self getDateNow]];
    _docPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSString *element = [firstName objectAtIndex:0];
    
    element = [NSString stringWithFormat: @"%@\n", element];  //each entry on new line
    
    BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!success) 
        NSLog(@"%@", error);
    //_answerIndex++;
        
    
    return _docPath;  //Later, do propper error checking...    
}


- (NSArray *)getQuestions {
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"questionList.txt"];  //no enpty newline at end? 
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];    
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    NSArray *lines = [string componentsSeparatedByString:@"\r"];  //  or \n?  Each line becomes a question.
    
    return lines;
}




- (void)saveData: (NSMutableArray *)questionAnswers: (int)numQuestions: (NSString *) filePath{
    
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    
   // NSError *error;
    
    //[self createDataPath];  //get _docPath, includes filename.
    
    for (int writeIndex =0;writeIndex < numQuestions;writeIndex++){          
     //   if (![fileManager fileExistsAtPath:_docPath]) {
            
           // NSString *element = [questionAnswers objectAtIndex:writeIndex];
            
           // element = [NSString stringWithFormat: @"%@\n", element];  //each entry on new line
            
           // BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
           // if (!success) 
           //     NSLog(@"%@", error);
            //_answerIndex++;
            
       // }
        
      //  else {   // the file already exists, so we should append the text to the end
            
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            [fileHandle seekToEndOfFile];
            //NSString *element = [[questionAnswers objectAtIndex:writeIndex] stringValue];
            NSString *element = [questionAnswers objectAtIndex:writeIndex] ;
            element = [NSString stringWithFormat: @"%@\n", element];
            NSData *textData = [element dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:textData];
            
            [fileHandle closeFile];
       // }   
        
    } //end of step through writing file.
    
    //[self setQuestionAnswers:nil ];
    //numQuestions = 0;
    //element = nil;
}

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

- (void) uploadToDropBox: (NSString *) filePath{
    

    
    NSString *filename = [filePath lastPathComponent];
    NSLog(@" hey filename,%@", filename);
    NSLog(@"docPath %@", filePath);

    
    
    NSString *destDir = @"/Questions2/";
    [[self restClient] uploadFile:filename toPath:destDir
                          withParentRev:nil  fromPath:filePath];
    
   //   [NSThread sleepForTimeInterval:2];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    //exit(0);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    NSLog(@"File upload failed with error - %@", error);
}




@end

