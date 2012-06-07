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


@implementation questionParser{

    NSArray * fields;
    
}

@synthesize infile = _infile;
@synthesize questionLine = _questionLine;

int lineNumber = 0;

NSString * infile;

NSString * docPath;

QuestionData * thisQuestionData;

NSString * stringOfFile;



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
    
    if (lineNumber == 0){  //first execution
        
        NSLog(@"_infile %@ infile %@",_infile,infile);
        
        infile = _infile;
        
        NSData *data = [NSData dataWithContentsOfFile:infile];
        stringOfFile = [NSString stringWithUTF8String:[data bytes]];
        
        while ([stringOfFile length] == 0){
            NSLog(@"reloading working ##########################");
            data = [NSData dataWithContentsOfFile:infile];
            stringOfFile = [NSString stringWithUTF8String:[data bytes]];
        }
        
        
        NSArray *linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
        
        NSString * headerLine = [linesOfFile objectAtIndex:0];
        headerLine = [headerLine stringByAppendingString:@"\n"];    
        
        NSMutableArray * headerLineArray = [[NSMutableArray alloc] init];
        
        [headerLineArray addObject:headerLine];
                
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:headerLineArray];
        
        lineNumber ++;
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    NSArray * linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
    
    if (lineNumber < ([linesOfFile count]-1)){
        
        NSString * line = [linesOfFile objectAtIndex:lineNumber];
        
        fields = [line componentsSeparatedByString:@"\t"];
          
        NSString * tester1 =@"numberline";
        NSString * tester2 =@"wordFill";
        NSString * tester3 =@"numberFill";
//        NSString * tester4 =@"multipleChoice";
//        NSString * tester5 =@"instruction";

        NSString * tester6 =[fields objectAtIndex:2];
        
        
        if ([tester1 isEqualToString:tester6]){
            NSLog(@"Going toNewSlider");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toNewSlider" sender: self];
        }
        
        if ([tester2 isEqualToString:tester6]){
            NSLog(@"going toWordFill");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toWordFill" sender: self];
            
        }
        if ([tester3 isEqualToString:tester6]){
            NSLog(@"Going toNumberFill");
            lineNumber ++;
            [self performSegueWithIdentifier: @"toNumberFill" sender: self];
        }
//        
//        if ([tester4 isEqualToString:tester6]){
//            NSLog(@"going toMultipleChoice");
//            lineNumber ++;
//            [self performSegueWithIdentifier: @"toMultipleChoice" sender: self];
//            
//        }
//        if ([tester5 isEqualToString:tester6]){
//            NSLog(@"going toInstruction");
//            lineNumber ++;
//            [self performSegueWithIdentifier: @"toInstruction" sender: self];
//            
//        }
        
    }//done with all questions       
    [self performSegueWithIdentifier: @"toGoodbye" sender: self];
    
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
    // Return YES for supported orientations
    return YES;
}



@end
