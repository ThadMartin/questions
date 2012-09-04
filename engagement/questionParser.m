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



@implementation questionParser{
    
    engagementAppDelegate * appDelegate;
    
    NSArray * fields;
}

@synthesize infile = _infile;
@synthesize questionLine = _questionLine;
@synthesize lineNumber = _lineNumber;

int lineNumber = 0;

NSString * infile;

NSString * docPath;

QuestionData * thisQuestionData;

NSString * stringOfFile;

BOOL loadFailed;


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
        
        // if (_lineNumber)  
        lineNumber = _lineNumber;
        
        NSData *data = [NSData dataWithContentsOfFile:infile];
        
        stringOfFile = [NSString stringWithUTF8String:[data bytes]];
        stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
        stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
        
        for (int retries = 0; retries < 20; retries ++){
            if  ([stringOfFile length] == 0){   // for some reason, doesn't always work on fisrt try.
                NSLog(@"reloading working ##########################");
                [NSThread sleepForTimeInterval:0.3];
                data = [NSData dataWithContentsOfFile:infile];
                stringOfFile = [NSString stringWithUTF8String:[data bytes]];
                stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
                stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
                stringOfFile = [stringOfFile stringByAppendingString:@"\r"];
                NSLog(@"retries = %i",retries);
            }
            
        }  //that's enough tries to reload.
        
        if  ([stringOfFile length] == 0)  
            loadFailed = YES;  // bad input file format.
        else{  //copy the headerline of the new file to the output file.
            
            QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
            NSArray * linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
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
            
        }
        
        NSLog(@"loadfailed: %i",loadFailed);
        
        
    }  // end of if infile or line number changed.
}


-(void)viewDidAppear:(BOOL)animated {
    
    if (loadFailed){
        [self performSegueWithIdentifier: @"toBadInfile" sender: self];
    } else {
        int numberOfLinesOfFile;
        NSArray * linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
        numberOfLinesOfFile = [linesOfFile count];
        
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
        //NSString * tester11 =@"titration";
        //NSString * tester12 =@"";
        
        
        
        if (lineNumber >= numberOfLinesOfFile){
            tester0 = @"goodbye";
            NSLog(@"tester changed to goodbye");
        }
        else{
            
            QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
            
            NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
            
            NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
            
            fields = [line componentsSeparatedByString:@"\t"];
            
            while ([fields count] < 4){  //This is not a valid question, copy it to the output file.
                
                NSString * headerLine = [linesOfFile objectAtIndex:lineNumber];
                NSLog(@"headerline %@",linesOfFile);
                //headerLine = [headerLine stringByAppendingString:@" \r"];    
                NSMutableArray * headerLineArray = [[NSMutableArray alloc] init];
                [headerLineArray addObject:headerLine];
                
                [thisQuestionData saveData:headerLineArray];
                int headLength = [headerLineArray count];
                NSLog(@"headerlinearray length %i",headLength);
                NSLog(@"headerLineArray  %@",headerLineArray);
                
                lineNumber++;
                
                if (lineNumber >= numberOfLinesOfFile){
                    tester0 = @"goodbye";
                    NSLog(@"tester changed to goodbye place 2");
                    
                    break; 
                }
                
                NSString * lineNoEnt = [linesOfFile objectAtIndex:lineNumber];
                NSString * line = [lineNoEnt stringByReplacingOccurrencesOfString:@"&NL" withString:@"\n"];
                
                fields = [line componentsSeparatedByString:@"\t"];
                
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
    NSString * newInputFile = [fields objectAtIndex:4];
    NSString * stringLineNumber = [fields objectAtIndex:5];
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
