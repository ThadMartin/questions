//
//  wordFill.m
//  engagement
//
//  Created by Thad Martin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "wordFill.h"
#import "QuestionData.h"
#import "questionSelector.h"
#import "engagementAppDelegate.h"
#import "questionParser.h"


@implementation wordFill

@synthesize wordFillText;

@synthesize wordFillLabel;
@synthesize wordFillSubmit;
@synthesize fields;
@synthesize infile;


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
    
    //[wordFillSubmit setEnabled:NO];
    //[wordFillSubmit setTitle:@"Enter answer" forState:normal];
    self.wordFillLabel.text = [fields objectAtIndex:3];
//    [disablesAutomaticKeyboardDismissal NO];
    
}

//- (BOOL)disablesAutomaticKeyboardDismissal {
//    return NO;
//}
//


- (void)viewDidUnload
{
    [self setWordFillLabel:nil];
    [self setWordFillSubmit:nil];
    [self setWordFillText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (BOOL)wordFillTextShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return (YES);
}


- (IBAction)wordFillSubmitPressed:(id)sender {
    
    NSString * wordFillAnswer = self.wordFillText.text;

    
            if (wordFillAnswer.length > 0) {
    
    NSMutableArray * questionAnswers = [[NSMutableArray alloc] init ];
    
    NSString * tabStr =@"\t"; 
    
    int retab = [fields count];
    
    for (int retabCounter = 0;retabCounter<retab;retabCounter++){
        
        [questionAnswers addObject:[fields objectAtIndex:retabCounter]];
        [questionAnswers addObject:tabStr]; 
    }
    
    

            NSString *answerObj = [NSString stringWithFormat:@"\t%@\n",wordFillAnswer];
            [questionAnswers addObject: answerObj];
            engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];        
            NSString * theDocPath = delegate.docPath;
            
           int answerLen = [questionAnswers count];
            
            QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
            [thisQuestionData saveData:questionAnswers: answerLen:theDocPath];

            [self performSegueWithIdentifier: @"backToQuestionParser" 
                                      sender: self];
        }
 
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"backToQuestionParser"]){
        questionParser * svc = [segue destinationViewController];
        svc.infile = infile; 
    } 
}



@end
