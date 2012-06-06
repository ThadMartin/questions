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
#import "engagementAppDelegate.h"
#import "newSlider.h"


@implementation questionParser

@synthesize infile;

@synthesize questionLine;

int lineNumber = 0;

NSArray *fields;


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
    
    if (lineNumber == 0){
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:infile];
    
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    NSArray *lines = [string componentsSeparatedByString:@"\r"];
    
    NSString * headerLine = [lines objectAtIndex:0];
    headerLine = [headerLine stringByAppendingString:@"\n"];    
    
    
    NSMutableArray * headerLineArray;
    headerLineArray = [[NSMutableArray alloc] init ];
    
    [headerLineArray addObject:headerLine];
    
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    NSString * theDocPath = delegate.docPath;
    
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    [thisQuestionData saveData:headerLineArray:1:theDocPath];
    
    

    lineNumber ++;
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    
    
    NSString *questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:infile];
    
    NSLog(@"%@",questionListPath);
    
    NSData *data = [NSData dataWithContentsOfFile:questionListPath];
    NSString *string = [NSString stringWithUTF8String:[data bytes]];
    while ([string length] == 0){
        NSLog(@"reloading worked##############################################################");
        questionListPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:infile];
            data = [NSData dataWithContentsOfFile:questionListPath];
        string = [NSString stringWithUTF8String:[data bytes]];
    }
        
        
    NSArray *lines = [string componentsSeparatedByString:@"\r"];
    if (lineNumber < ([lines count]-1)){
        
        NSString * line = [lines objectAtIndex:lineNumber];
        
        fields = [line componentsSeparatedByString:@"\t"];
        
        NSLog (@"something wrong? %@ ",string);
    //    }

    
     NSString * tester1 =@"numberline";
    
    NSString * tester5 =[fields objectAtIndex:2];
    
    
    if ([tester1 isEqualToString:tester5]){
       // NSLog(@"seems equal");
        lineNumber ++;
        [self performSegueWithIdentifier: @"toNewSlider" sender: self];
    }
    //else{
    //    
    //}
    }//done with all questions       

    else{
                engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
                
               NSString * theDocPath = delegate.docPath;
        
        
                
                [NSThread sleepForTimeInterval:1];
               QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
               [thisQuestionData uploadToDropBox:theDocPath];
        NSLog(@"this is where we upload");
                [NSThread sleepForTimeInterval:1]; 
        
        [self performSegueWithIdentifier: @"toGoodbye" sender: self];

        
    }
        
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"toNewSlider"]){
        newSlider * svc = [segue destinationViewController];
        svc.fields = fields; 
        svc.infile = infile;
    } 
}



- (void)viewDidUnload
{
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
