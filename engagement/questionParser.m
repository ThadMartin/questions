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
#import "instruction.h"
#import "titrationBranch.h"

@implementation questionParser{
    
    engagementAppDelegate * appDelegate;
    
    NSArray * fields;
}

@synthesize infile = _infile;
@synthesize questionLine = _questionLine;
@synthesize lineNumber = _lineNumber;
@synthesize previousAnswer;

int lineNumber = 0;

NSString * infile;
NSString * previousInfile;

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

int titrationVerbalCorrect = 0;
int titrationVerbalLevel = 1;
int titrationVerbalAskedAtLevel = 0;
int titrationVerbalCorrectAtLevel = 0;
int titrationVerbalNumAtLevel = 0;

int titrationSpatialCorrect = 0;
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
    
    NSLog(@"Loading infile: %@",infile);
    
    NSData *data = [NSData dataWithContentsOfFile:infile];
    
    //stringOfFile = [NSString stringWithUTF8String:[data bytes]];
    stringOfFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
    stringOfFile = [stringOfFile stringByAppendingString:@"\r"];
    
    // switched to 'dataWithContentsOfFile' so this shouldn't be necessary any more.
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
        loadFailed = YES;  // bad input file format?
    else{  //copy the headerline of the new file to the output file.
        
        linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
        //for (int line in [linesOfFile count])
        
        numberOfLinesOfFile = 0;
        
        for(NSString * checkLength in linesOfFile ){
            if ([checkLength length]>0)
                numberOfLinesOfFile ++;
        }
        
        
        //numberOfLinesOfFile = [linesOfFile count];
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
        // NSLog(@"fields:  %@",fields);
        
    }
    
}



-(void) setOldAnswer:(NSString *)prAnswer{
    previousAnswer = prAnswer;
    //NSLog(@"setPrevious ran.");
    //NSLog(@"%@",prAnswer);
}

-(void) setSpatialAnswer:(int)spaCorrect{
    titrationSpatialCorrect = spaCorrect;
}

-(void) setVerbalAnswer:(int)verCorrect{
    titrationVerbalCorrect = verCorrect;
    //NSLog(@"verCorrect:  %i",verCorrect);
}

-(void) setInputFile:(NSString *)newInputFile{
    infile = newInputFile;
    //[self loadInFile];
}
-(void) setLineNbr:(int)newQuestionNumber{
    lineNumber = newQuestionNumber;    
}

-(void) setInRnd:(BOOL)inRand{
    inRandom = inRand;
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
    NSLog(@"with line number:  %i %i",_lineNumber, lineNumber);
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"beginning of view did load.");
    
    fields = NULL;
    appDelegate = [[UIApplication sharedApplication] delegate];
    NSLog (@"infile: %@ %@",_infile,infile);
    NSLog (@"lineNumber (beginning of view did load): %i %i",_lineNumber,lineNumber);
    loadFailed = NO;
    
    
    //first execution.
    
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
        
        NSString * taskOrderInfile = [linesOfOrder objectAtIndex:taskOrderPosition];
        
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
        else
            anotherFromTaskOrder = NO;
        
    }//end of if it is an .ord file
    
    NSLog(@"infile:  %@",infile);
    
   lineNumber = 0;
    
    //NSLog (@"lineNumber (end of view did load): %i %i",_lineNumber,lineNumber);
    
    
    [self loadInFile];
    
    previousInfile = infile;
    
    NSLog(@"loadfailed: %i",loadFailed);
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog (@"Beginning of questionParser view did appear");
    
    if(![previousInfile isEqualToString:infile]){
        NSLog(@"loading infile.");
        [self loadInFile];
    }
    
    NSString * lineNoEnt;            
    NSString * line;
    
    NSString * tester0 = NULL;
    
    NSLog(@"_infile,infile:  %@ %@",_infile,infile);
    
    if (!loadFailed){
        
        NSLog(@"line number, numberOfLinesOf file: %i, %i",lineNumber,numberOfLinesOfFile);
        
        if (lineNumber+1 > numberOfLinesOfFile){
            
            if (anotherFromTaskOrder){
                
                NSLog(@"another from task order.");
                
                taskOrderPosition ++;
                
                NSLog(@"taskorder position: %i",taskOrderPosition);
                
                NSString * taskOrderInfile = [linesOfOrder objectAtIndex:taskOrderPosition];
                
                NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
                
                for (NSString * thisFile in theQuestions){
                    if ([[thisFile lastPathComponent] isEqualToString:taskOrderInfile])
                        infile = thisFile;
                }
                
                lineNumber = 0;
                inRandom = NO;
                
                NSLog(@"linesOfTaskOrder count: %i",[linesOfOrder count]);
                NSLog(@"task order position %i",taskOrderPosition);
                
                
                if (taskOrderPosition< lengthOfOrder -1)
                    anotherFromTaskOrder = YES;
                else{
                    anotherFromTaskOrder = NO;
                    //tester0 = @"goodbye";
                }
                [self loadInFile];
                
            }// end of if more from taskorder
            
            else{
                
                tester0 = @"goodbye";
                NSLog(@"tester changed to goodbye");
            }
            
             NSLog(@"anotherFromTaskOrder %i",(int)anotherFromTaskOrder);
            NSLog(@"task order position %i",taskOrderPosition);
            NSLog(@"lengthOfOrder %i",lengthOfOrder);
            
        }// end of if past end of infile
        else{
            
            lineNoEnt = [linesOfFile objectAtIndex:lineNumber];            
            line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];            
            fields = [line componentsSeparatedByString:@"\t"];
            
            NSLog(@"fields:  %@",fields);
            
            if([[fields objectAtIndex:0]hasPrefix:@"head"]){
                QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
                
                NSString * headerLine = [linesOfFile objectAtIndex:lineNumber];
                NSMutableArray * headerLineArray = [[NSMutableArray alloc] init];
                [headerLineArray addObject:headerLine];
                
                [thisQuestionData saveData:headerLineArray];
                
                lineNumber++;
                
                lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
                line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
                fields = [line componentsSeparatedByString:@"\t"];
                
                //NSLog(@"fields:  %@",fields);
                
            }// end if if it is header line.
            
            
        }  //here we should have the fields of the question.
        
        NSString * blockString = [fields objectAtIndex:2];
        int blockNum = [blockString intValue];
        
        if ((blockNum != 0)&& !inRandom){
            NSLog(@"going to initialize random");
            inRandom = YES;
            inRandomNumber = 0;
            linesBeforeRandom = lineNumber;
            NSLog(@"lines before random:  %i",linesBeforeRandom);
            [self initializeRandomMatrix];
        }
        
        if (inRandom){
            if (inRandomNumber >= ([randomMatrix count])){
                NSLog(@"done with random");
                inRandom = NO;
                lineNumber = linesBeforeRandom + [randomMatrix count];
            }
            else{
                NSLog(@"next random");
                lineNumber = [[[randomMatrix objectAtIndex:inRandomNumber] objectAtIndex:0] intValue];
                inRandomNumber ++;
            }
            lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
            line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
            fields = [line componentsSeparatedByString:@"\t"];
            
        }else
            NSLog(@"not in random");
        
        if (([fields count] > 4)&&!([tester0 isEqualToString:@"goodbye"])) {
            tester0 =[fields objectAtIndex:3];
        }
        else{
            tester0 = @"goodbye";
        }
        
        titrationVerbalCorrectAtLevel += titrationVerbalCorrect;
        titrationSpatialCorrectAtLevel += titrationSpatialCorrect;
        
        titrationVerbalCorrect = 0;
        titrationSpatialCorrect = 0;
        
        if((titrationVerbalAskedAtLevel == 3)&&(titrationVerbalCorrectAtLevel >=2)){
            titrationVerbalLevel ++;
            titrationVerbalAskedAtLevel = 0;
            titrationVerbalCorrectAtLevel = 0;
        }
        if((titrationSpatialAskedAtLevel == 3)&&(titrationSpatialCorrectAtLevel >=2)){
            titrationSpatialLevel ++;
            titrationSpatialAskedAtLevel = 0;
            titrationSpatialCorrectAtLevel = 0;
        }
        
        NSLog(@"titrationVerbalLevel: %i, titrationSpatialLevel, %i",titrationVerbalLevel,titrationSpatialLevel);
        NSLog(@"in random:  %i",inRandom);
        NSLog(@"line number, view did appear %i,%i",_lineNumber,lineNumber);
        
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
        NSLog(@"line number, lines of file: %i, %i",lineNumber,numberOfLinesOfFile);
        
        bool selectedSomething = false;
        
        previousInfile = infile;
        
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
            //[NSThread sleepForTimeInterval:3];
            [self performSegueWithIdentifier: @"toBranchTo" sender: self];
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
            [self performSegueWithIdentifier: @"toTitrationBranch" sender: self];
        }
        
        
        if ((! selectedSomething) && ![tester0 isEqualToString:@"goodbye"])
            [self performSegueWithIdentifier: @"toBadInfile" sender: self];
        
        //done with all questions 
        
        if ([tester0 isEqualToString:@"goodbye"]){
            [self performSegueWithIdentifier: @"toGoodbye" sender: self];
        }
    }//end of load didn't fail.
    else{
        [self performSegueWithIdentifier: @"toBadInfile" sender: self];
    }
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
        [svc setQuestionParser:self];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toInstruction"]){
        instruction * svc = [segue destinationViewController];
        //[svc setQuestionParser:self];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toPicture"]){
        picture * svc = [segue destinationViewController];
        svc.fields = fields;
    }
    if ([segue.identifier isEqualToString:@"toSpeech"]){
        speech * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toBranchOut"]){
        branchOut * svc = [segue destinationViewController];
        svc.fields = fields; 
        [svc setQuestionParser:self];
    }
    if ([segue.identifier isEqualToString:@"toAudioNumberLine"]){
        audioNumberLine * svc = [segue destinationViewController];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toFeedback"]){
        feedback * svc = [segue destinationViewController];
        svc.fields = fields; 
        svc.previousAnswer = previousAnswer;
    }
    if ([segue.identifier isEqualToString:@"toTitration"]){
        titration * svc = [segue destinationViewController];
        [svc setQuestionParser:self];
        svc.fields = fields; 
    }
    if ([segue.identifier isEqualToString:@"toBranchTo"]){
        branchTo * svc = [segue destinationViewController];
        [svc setQuestionParser:self];
        svc.fields = fields; 
        //[NSThread sleepForTimeInterval:3];
    }
    if ([segue.identifier isEqualToString:@"toTitrationBranch"]){
        titrationBranch * svc = [segue destinationViewController];
        [svc setQuestionParser:self];
        svc.fields = fields; 
        svc.titrationSpatialLevel = titrationSpatialLevel;
        svc.titrationVerbalLevel = titrationVerbalLevel;
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
