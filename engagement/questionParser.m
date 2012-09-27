//
//  questionParser.m
//  engagement
//
//  Created by Thad Martin on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "questionParser.h"
#import "QuestionData.h"
#import "questionSelector.h"
#import "newSlider.h"
#import "wordFill.h"
#import "numberFill.h"
#import "multipleChoice.h"
#import "picture.h"
#import "speech.h"
#import "branchOut.h"
#import "audioNumberLine.h"
#import "engagementAppDelegate.h"
#import "feedback.h"
#import "titration.h"



@implementation questionParser{
    
    engagementAppDelegate * appDelegate;
    
    NSArray * fields;
}

@synthesize infile = _infile;
@synthesize questionLine = _questionLine;
@synthesize lineNumber = _lineNumber;
@synthesize previousAnswer;
@synthesize titrationVerbalCorrect;
@synthesize titrationSpatialCorrect;


int lineNumber = 0;

NSString * infile;

NSString * docPath;

QuestionData * thisQuestionData;

NSString * stringOfFile;
NSString * stringOfOrder;

BOOL loadFailed;

BOOL inRandom = NO;

NSMutableArray * randomMatrix;

int inRandomNumber = 0;

NSArray * linesOfFile;
NSArray * linesOfOrder;

int numberOfLinesOfFile;

int linesBeforeRandom = 0;

int lengthOfOrder = 0;

int titrationVerbalLevel = 1;
int titrationVerbalAskedAtLevel = 0;
int titrationVerbalCorrectAtLevel = 0;
int titrationVerbalNumAtLevel = 0;

int titrationSpatialLevel = 1;
int titrationSpatialAskedAtLevel = 0;
int titrationSpatialCorrectAtLevel = 0;
int titrationSpatialNumAtLevel = 0;

BOOL anotherFromTaskOrder = NO;

int taskOrderPosition = 0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(void)loadInFile{
    NSData *data = [NSData dataWithContentsOfFile:infile];
    
    //stringOfFile = [NSString stringWithUTF8String:[data bytes]];
    stringOfFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
    stringOfFile = [stringOfFile stringByAppendingString:@"\r"];
    
    for (int retries = 0; retries < 40; retries ++){
        if  ([stringOfFile length] == 0){   // for some reason, doesn't always work on fisrt try.
            NSLog(@"reloading working ##########################");
            [NSThread sleepForTimeInterval:0.3];
            data = [NSData dataWithContentsOfFile:infile];
            //NSLog(@"data length %i",[data length]);
            stringOfFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
            stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
            stringOfFile = [stringOfFile stringByAppendingString:@"\r"];
            NSLog(@"retries = %i",retries);
        }
        
    }  //that's enough tries to reload.
    
    if  ([stringOfFile length] == 0)  
        loadFailed = YES;  // bad input file format.
    else{  //copy the headerline of the new file to the output file.
        
        linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
        numberOfLinesOfFile = [linesOfFile count];
        NSLog(@"NumberOfLinesOfFile: %i",numberOfLinesOfFile);
        
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        NSString * headerLine = [linesOfFile objectAtIndex:0];
        
        headerLine = [headerLine stringByAppendingString:@"\r"];    
        NSMutableArray * headerLineArray = [[NSMutableArray alloc] init];
        [headerLineArray addObject:headerLine];
        [thisQuestionData saveData:headerLineArray];
        
        if(lineNumber == 0)
            lineNumber ++;
        
        NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
        NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
        
        fields = [line componentsSeparatedByString:@"\t"];
        NSLog(@"fields:  %@",fields);
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    fields = NULL;
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSLog (@"infile: %@ %@",_infile,infile);
    NSLog (@"lineNumber: %i %i",_lineNumber,lineNumber);
    loadFailed = NO;
    
    
    if (( _infile && ![infile isEqualToString:_infile]) ||( _lineNumber>0 && _lineNumber != lineNumber)){  //first execution or changed infile or line number
        
        infile = _infile;
        
        
        
        if ([infile hasSuffix:@".ord"]){
            NSData *orderData = [NSData dataWithContentsOfFile:infile];
            stringOfOrder = [[NSString alloc] initWithData:orderData encoding:NSUTF8StringEncoding];
            //stringOfOrder = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            stringOfOrder = [stringOfOrder stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
            stringOfOrder = [stringOfOrder stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
            stringOfOrder = [stringOfOrder stringByAppendingString:@"\r"];
            linesOfOrder = [stringOfOrder componentsSeparatedByString:@"\r"];
            taskOrderPosition = 1;
            
            //appDelegate = [[UIApplication sharedApplication] delegate];
            
            NSString * taskOrderInfile = [linesOfOrder objectAtIndex:taskOrderPosition];
            
            //NSString * newInputFile;
            
            NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
            
            for (NSString * thisFile in theQuestions){
                if ([[thisFile lastPathComponent] isEqualToString:taskOrderInfile])
                    infile = thisFile;
            }
            
            for(NSString * checkLength in linesOfOrder){
                if ([checkLength length]>0)
                    lengthOfOrder ++;
            }
            if (taskOrderPosition < lengthOfOrder-1)
                anotherFromTaskOrder = YES;
            
            //infile = newInputFile;
            
        }
        
        NSLog(@"infile:  %@",infile);
        
        // if (_lineNumber)  
        lineNumber = _lineNumber;
        
        NSLog (@"lineNumber: %i %i",_lineNumber,lineNumber);
        

        [self loadInFile];
        
        NSLog(@"loadfailed: %i",loadFailed);
        
        // At this point, set inRandom to NO, randomMatrix to null, and check fields(2)
        if (!loadFailed){
            // inRandom = NO;
            //ranomMatrix = NULL;
            NSString * blockString = [fields objectAtIndex:2];
            int blockNum = [blockString intValue];
            if ((blockNum != 0)&& !inRandom){
                NSLog(@"going to initialize random");
                inRandom = YES;
                [self initializeRandomMatrix];
            }
        }
        
    }  // end of if infile or line number changed.
}

static NSInteger Compare(NSArray * array1, NSArray * array2, void *context) {
    // This is used initializing random question order.
    
    //NSLog(@"array 1,2:  %@,%@",array1,array2);
    int num1 = [[array1 objectAtIndex:1] intValue];
    int num2 = [[array2 objectAtIndex:1] intValue];
    //NSLog(@" 1:2 %i,%i",num1,num2);
    if (num1 < num2){
        //NSLog(@"ascending");
        return NSOrderedAscending;
    }
    else if (num1 > num2){
        //NSLog(@"descending");
        return NSOrderedDescending;
    }
    else {
        //NSLog(@"same");
        return NSOrderedSame;
    }
}


-(void) initializeRandomMatrix{
    
    //    randomMatrix 
    //    row 0: block number from fields(2)
    //    row 1: random number, 1 to 1000;
    
    NSLog(@"initializing random matrix");
    int randomizeLine = lineNumber;
    NSNumber * randomizeLineNumber = [NSNumber numberWithInt:randomizeLine];
    
    //NSLog(@"randomizeLineNumber: %@",randomizeLineNumber);
    
    NSNumber * randOrderNumber = 0;   //this will be the random number.
    
    int randOrder = 0;
    int previousBlock = 0;
    randomMatrix = [[NSMutableArray alloc] init];
    NSArray * randAndLine;
    
    NSString * randomizeFieldsString = [linesOfFile objectAtIndex:randomizeLine]; 
    
    
    NSArray * randomizeFields =  [randomizeFieldsString componentsSeparatedByString:@"\t"]; 
    
    
    NSLog(@"randomizing:  %@",randomizeFields);
    
    NSString * blockString = [randomizeFields objectAtIndex:2];
    
    int block = [blockString intValue]; 
    
    while (block != 0 ){
        //NSString * blockString = [randomizeFields objectAtIndex:2];
        //int block = [blockString intValue];
        if (block != previousBlock){
            randOrder = rand() % 1000 + 1;
            randOrderNumber = [NSNumber numberWithInt:randOrder];
        }
        randAndLine = [[NSArray alloc] initWithObjects:randomizeLineNumber,randOrderNumber,nil];
        [randomMatrix addObject:randAndLine];
        
        //NSLog(@"randomMatrixEntry: %@",randAndLine);
        
        randomizeLine ++;
        
        randomizeLineNumber = [NSNumber numberWithInt:randomizeLine];
        
        //NSLog(@"randomizeLine:  %i",randomizeLine);
        
        previousBlock = block;
        
        randomizeFieldsString = [linesOfFile objectAtIndex:randomizeLine];
        
        //NSLog(@"randomizeFieldsString: %@",randomizeFieldsString);
        
        randomizeFields =  [randomizeFieldsString componentsSeparatedByString:@"\t"]; 
        
        blockString = [randomizeFields objectAtIndex:2];
        
        block = [blockString intValue];
        
        //NSLog(@"block: %i",block);
        
        
        
    } // end of while the next line also gets randomized.
    
    //NSLog(@"exited while loop");
    
    // should now have a 2D array with [random by blocks] [line number]
    
    NSArray * sortedArray = [randomMatrix sortedArrayUsingFunction:Compare context:nil];
    
    randomMatrix = [sortedArray mutableCopy] ;
    
    //NSLog(@"sorted array: %@",randomMatrix);
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (loadFailed){
        [self performSegueWithIdentifier: @"toBadInfile" sender: self];
    } else {
        
        titrationVerbalCorrectAtLevel += titrationVerbalCorrect;
        titrationSpatialCorrectAtLevel += titrationSpatialCorrect;
        
        if((titrationVerbalAskedAtLevel == 3)&&(titrationVerbalCorrectAtLevel >=2)){
            titrationVerbalLevel ++;
            titrationVerbalAskedAtLevel = 0;
            titrationVerbalCorrectAtLevel = 0;
            //NSLog(@"titrationVerbalLevel: %i",titrationVerbalLevel);
        }
        if((titrationSpatialAskedAtLevel == 3)&&(titrationSpatialCorrectAtLevel >=2)){
            titrationSpatialLevel ++;
            titrationSpatialAskedAtLevel = 0;
            titrationSpatialCorrectAtLevel = 0;
            //NSLog(@"titrationSpatialLevel: %i",titrationSpatialLevel);
        }
        
        NSLog(@"titrationVerbalLevel: %i, titrationSpatialLevel, %i",titrationVerbalLevel,titrationSpatialLevel);
        
        NSLog(@"anotherFromTaskOrder %i",(int)anotherFromTaskOrder);
        NSLog(@"task order position %i",taskOrderPosition);
        NSLog(@"lengthOfOrder %i",lengthOfOrder);
        
        
        
        
        
        NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
        
        NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
        
        fields = [line componentsSeparatedByString:@"\t"];
        
        if ([fields count ]> 4){
            
            NSString * blockString = [fields objectAtIndex:2];
            int blockNum = [blockString intValue];
            //NSLog(@"fields: %@",fields);
            //NSLog(@"blockNum:  %i",blockNum);
            
            if ((blockNum != 0)&& !inRandom){
                NSLog(@"going to initialize random");
                inRandom = YES;
                linesBeforeRandom = lineNumber;
                [self initializeRandomMatrix];
            }
            
            if (inRandom){
                //NSLog(@"randomMatrix: %@",randomMatrix);
                //inRandomNumber ++;
                //int lineQuest;
                if (inRandomNumber >= ([randomMatrix count])){
                    inRandom = NO;
                    lineNumber = linesBeforeRandom + [randomMatrix count];
                }
                else{
                    lineNumber = [[[randomMatrix objectAtIndex:inRandomNumber] objectAtIndex:0] intValue];
                    inRandomNumber ++;
                }
            }
        }
        
        //int numberOfLinesOfFile;
        //NSArray * linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
        
        NSLog(@"lineNumber,linesOfFile: %i , %i",lineNumber,numberOfLinesOfFile);
        
        NSString * tester0 = NULL;
        NSString * tester1 =@"numberline";
        NSString * tester2 =@"wordFill";
        NSString * tester3 =@"numberFill";
        NSString * tester4 =@"multipleChoice";
        NSString * tester5 =@"instruction";
        NSString * tester6 =@"picture";
        NSString * tester7 =@"speech";
        NSString * tester8 =@"branchOut";
        NSString * tester9 =@"audioNumberLine";
        NSString * tester10 =@"branchTo";
        NSString * tester11 =@"feedback";
        NSString * tester12 =@"titration";
        NSString * tester13 =@"titrationBranch";
        
        NSLog(@"previousAnswer:  %@",previousAnswer);
        
        if (lineNumber >= numberOfLinesOfFile){
            
            if (!anotherFromTaskOrder){
                
                tester0 = @"goodbye";
                NSLog(@"tester changed to goodbye");
            }
            
            if (anotherFromTaskOrder){
                taskOrderPosition ++;
                
                NSString * taskOrderInfile = [linesOfOrder objectAtIndex:taskOrderPosition];
                
                NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
                
                for (NSString * thisFile in theQuestions){
                    if ([[thisFile lastPathComponent] isEqualToString:taskOrderInfile])
                        infile = thisFile;
                }
                
                lineNumber = 0;
                
                NSLog(@"linesOfOrder count: %i",[linesOfOrder count]);
                NSLog(@"task order position %i",taskOrderPosition);
                
                
                if (taskOrderPosition< lengthOfOrder -1)
                    anotherFromTaskOrder = YES;
                else{
                    anotherFromTaskOrder = NO;
                    //tester0 = @"goodbye";
                }
                [self loadInFile];
            }
        }
        else{
            
            QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
            
            NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
            
            NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
            
            fields = [line componentsSeparatedByString:@"\t"];
            
            while ([fields count] < 4){  //This is not a valid question, copy it to the output file.
                
                NSString * headerLine = [linesOfFile objectAtIndex:lineNumber];
                //NSLog(@"headerline %@",linesOfFile);
                //headerLine = [headerLine stringByAppendingString:@" \r"];    
                NSMutableArray * headerLineArray = [[NSMutableArray alloc] init];
                [headerLineArray addObject:headerLine];
                
                [thisQuestionData saveData:headerLineArray];
                
                lineNumber++;
                
                if (lineNumber >= numberOfLinesOfFile){
                    if (!anotherFromTaskOrder){
                        
                        tester0 = @"goodbye";
                        NSLog(@"tester changed to goodbye");
                        break;
                    }
                    
                    if (anotherFromTaskOrder){
                        taskOrderPosition ++;
                        
                        NSString * taskOrderInfile = [linesOfOrder objectAtIndex:taskOrderPosition];
                        
                        NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
                        
                        for (NSString * thisFile in theQuestions){
                            if ([[thisFile lastPathComponent] isEqualToString:taskOrderInfile])
                                infile = thisFile;
                        }
                        
                        NSLog(@"2linesOfOrder count: %i",lengthOfOrder);
                        NSLog(@"2task order position %i",taskOrderPosition);
                        
                        
                        if (taskOrderPosition< lengthOfOrder -1)
                                 anotherFromTaskOrder = YES;
                        else{
                            anotherFromTaskOrder = NO;
                           // tester0 = @"goodbye";
                        }
                        lineNumber = 0;
                        
                        [self loadInFile];

                        
                        break;
                    }
                   // break; 
                }
                
//                NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
//                NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
//                
//                fields = [line componentsSeparatedByString:@"\t"];
                
            }  //end of copy line to output file
            
        }  //here we should have the fields of the question.
        
        if ([fields count] > 4){
            tester0 =[fields objectAtIndex:3];
        }
        else{
            tester0 = @"goodbye";
        }
        
        bool selectedSomething = false;
        
        NSLog(@"selector is:  %@",tester0);
        
        if ([tester1 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"Going toNewSlider");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toNewSlider" sender: self];
        }
        
        if ([tester2 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toWordFill");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toWordFill" sender: self];
        }
        if ([tester3 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"Going toNumberFill");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toNumberFill" sender: self];
        }
        if ([tester4 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toMultipleChoice");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toMultipleChoice" sender: self];
        }
        if ([tester5 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toInstruction");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toInstruction" sender: self];
        }
        if ([tester6 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toPicture");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toPicture" sender: self];
        }
        if ([tester7 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toSpeech");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toSpeech" sender: self];
        }
        if ([tester8 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toBranchOut");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toBranchOut" sender: self];
        }
        if ([tester9 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toAudioNumberLine");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toAudioNumberLine" sender: self];
        }
        if ([tester10 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toBranchTo");
            lineNumber ++;
            [self branchTo];
        }
        if ([tester11 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toFeedback");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toFeedback" sender: self];
        }
        if ([tester12 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toTitration");
            lineNumber ++;
            if ([[fields objectAtIndex:6] isEqualToString:@"verbal"])
                titrationVerbalAskedAtLevel ++;
            if ([[fields objectAtIndex:6] isEqualToString:@"spatial"])
                titrationSpatialAskedAtLevel ++;
            
            [self performSegueWithIdentifier: @"toTitration" sender: self];
        }
        if ([tester13 isEqualToString:tester0]){
            selectedSomething = true;
            NSLog(@"going toTitrationBranch");
            lineNumber ++;
            [self titrationBranch];
        }
        
        
        
        
        if ((! selectedSomething) && ![tester0 isEqualToString:@"goodbye"])
            [self performSegueWithIdentifier: @"toBadInfile" sender: self];
        
        //done with all questions 
        
        if ([tester0 isEqualToString:@"goodbye"]){
            [self performSegueWithIdentifier: @"toGoodbye" sender: self];
        }
    }
}

-(void) branchTo{
    //this comes from code in branchOut, see that for some comments and debug.
    //line 0 is the header line.  
    NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
    int lengthQnsPths = [theQuestions count];
    NSString * newInputFile = [fields objectAtIndex:5];
    NSString * stringLineNumber = [fields objectAtIndex:6];
    _lineNumber = [stringLineNumber intValue];
    for (int stepThrough = 0; stepThrough < lengthQnsPths; stepThrough++){
        NSString * checkThis = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
        NSString * checkingString = [checkThis lastPathComponent];
        // NSLog(@"they are: %@ %@",checkThis,checkingString);
        if ([checkingString isEqualToString: newInputFile]) {
            newInputFile = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
            //NSLog(@"they are: %@ %@",checkThis,checkingString);
        }
    }
    
    NSLog(@"new input file:  %@",newInputFile);
    
    _infile = newInputFile;
    NSLog(@"next question");
    [self viewDidLoad];
    [self viewDidAppear:true];
    
}

-(void) titrationBranch{
    //this comes from code in branchOut, see that for some comments and debug.
    //line 0 is the header line.  
    NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
    int lengthQnsPths = [theQuestions count];
    
    int theLevel;
    NSString * newInputFile;
    NSString * stringLineNumber;
    int numOfChoices = 0;
    BOOL modified;
    int checkNum;
    
    modified = NO;
    
    
    if ([[fields objectAtIndex:5] isEqualToString:@"verbal"])
        theLevel = titrationVerbalLevel;
    
    if ([[fields objectAtIndex:5] isEqualToString:@"spatial"])
        theLevel = titrationSpatialLevel;
    
    for (int choiceCounter = 6;choiceCounter < [fields count];choiceCounter+=3){
        NSString * theChoice = [fields objectAtIndex:choiceCounter];
        if([theChoice length] >0)
            numOfChoices ++;
    }
    
    NSLog(@"NumOfChoices:  %i",numOfChoices);
    
    switch (numOfChoices) {
        case 1:
            
            checkNum = [[fields objectAtIndex:6] intValue];
            
            NSLog(@"CheckNum:  %i",checkNum);
            
            
            if (checkNum == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                NSLog(@"trying to change to %@",newInputFile);
                modified = YES;
            }
            
            break;
            
        case 2:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            break;
            
        case 3:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                modified = YES;
                
                
            }
            break;
            
        case 4:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:15] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:16];
                stringLineNumber = [fields objectAtIndex:17];
                
                modified = YES;
            }
            break;
            
        case 5:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:15] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:16];
                stringLineNumber = [fields objectAtIndex:17];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:18] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:19];
                stringLineNumber = [fields objectAtIndex:20];
                modified = YES;
            }
            break;
            
        default:
            
            break;
            
            
    }
    
    if (modified){
        inRandom = NO;
        _lineNumber = [stringLineNumber intValue];
        NSLog (@"lineNumber: %i %i",_lineNumber,lineNumber);    
        for (int stepThrough = 0; stepThrough < lengthQnsPths; stepThrough++){
            NSString * checkThis = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
            NSString * checkingString = [checkThis lastPathComponent];
            NSLog(@"they are: %@ %@",newInputFile,checkingString);
            if ([checkingString isEqualToString: newInputFile]) {
                NSString * newInputFile2 = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
                NSLog(@"they are place 2: %@ %@",newInputFile2,checkingString);
                _infile = newInputFile2;
                NSLog(@"new input file first:  %@",_infile);
            }
            
            
        }
        
    }
    
    
    
    NSLog(@"new input file:  %@",_infile);
    
    //_infile = newInputFile;
    NSLog(@"Did titrationBranch");
    [self viewDidLoad];
    [self viewDidAppear:true];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toNewSlider"]){
        newSlider * svc = [segue destinationViewController];
        svc.fields = fields; 
    } 
    if ([segue.identifier isEqualToString:@"toWordFill"]){
        wordFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    } 
    if ([segue.identifier isEqualToString:@"toNumberFill"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toMultipleChoice"]){
        multipleChoice * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toInstruction"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toPicture"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields;
    }
    if ([segue.identifier isEqualToString:@"toSpeech"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toBranchOut"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toAudioNumberLine"]){
        numberFill * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toFeedback"]){
        feedback * svc = [segue destinationViewController];
        svc.fields = fields; 
        svc.previousAnswer = previousAnswer;
    }
    if ([segue.identifier isEqualToString:@"toTitration"]){
        titration * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    
    
}


- (void)viewDidUnload
{
    //[self setLinkButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return NO;   
    else
        return YES;
}

@end
