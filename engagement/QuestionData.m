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
#import "newSlider.h"

@implementation QuestionData // : <DBRestClientDelegate>


@synthesize docPath = _docPath;
@synthesize questionAnswers = _questionAnswers;
@synthesize answerIndex = _answerIndex;
@synthesize thisQuestionData;

//DBRestClient* restClient;

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

//find path, create file, and put the first entry in the file.  Return the path of the file to save more data to.  Takes array with only one entry.

- (NSString * )createDataPath{ 
    
    NSError *error;

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat: @"/questions__%@__%@.txt",[[UIDevice currentDevice] name], [self getDateNow]];
    _docPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
   // NSString *element = [_docPath ];
    
    NSString * element = [NSString stringWithFormat: @"%@\n", _docPath];  //each entry on new line
    
    BOOL success = [element writeToFile:_docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (!success) 
        NSLog(@"%@", error);
    //_answerIndex++;
        
    
    return _docPath;  //Later, do propper error checking...    
}


- (NSArray *)getQuestions : (NSString *) infile{
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:infile];  //no enpty newline at end? 
    //NSString *qListPath = [[NSBundle mainBundle] bundlePath]; 
    NSLog(@"\n %@ \n",questionListPath);
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];    
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    NSArray *lines = [string componentsSeparatedByString:@"\r"];  //  or \n?  Each line becomes a question.
    

    
    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    
//    NSArray *filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:nil];
//    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.txt'"];
//    
//    NSArray *onlyQns = [filelist filteredArrayUsingPredicate:fltr];
//    
//    int count = [onlyQns count];
//    
//    NSLog (@"NumberOfFiles is %i",count);
    
        return lines;
    
}




- (void)saveData: (NSMutableArray *)questionAnswers: (int)numQuestions: (NSString *) filePath{
    
    
    for (int writeIndex =0;writeIndex < numQuestions;writeIndex++){          
            
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            [fileHandle seekToEndOfFile];
            //NSString *element = [[questionAnswers objectAtIndex:writeIndex] stringValue];
            NSString *element = [questionAnswers objectAtIndex:writeIndex] ;
            //element = [NSString stringWithFormat: @"%@\n", element];
            NSData *textData = [element dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:textData];
            
            [fileHandle closeFile];
       // }   
        
    } //end of step through writing file.
    

}



- (void) uploadToDropBox: (NSString *) filePath{
    

    
    NSString *filename = [filePath lastPathComponent];
    NSLog(@"filename,%@", filename);
    NSLog(@"docPath %@", filePath);
    
    NSString *destDir = @"/";
    
    restClient =
    [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    
   // restClient.delegate = newSlider ;

    
    [restClient uploadFile:filename toPath:destDir
                          withParentRev:nil  fromPath:filePath];
    
      //[NSThread sleepForTimeInterval:6];
}

//- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
//              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
//    
//    NSLog(@"File uploaded successfully to path: %@", metadata.path);
//    //exit(0);
//}
//
//- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
//    NSLog(@"File upload failed with error - %@", error);
//}
//



@end

