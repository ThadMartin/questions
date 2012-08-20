//
//  wordFill.m
//  engagement
//
//  Created by Thad Martin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "wordFill.h"
#import "questionParser.h"
#import "QuestionData.h"


@implementation wordFill{
    NSTimer * timer;
}

@synthesize textField;
@synthesize wordFillLabel;
@synthesize wordFillSubmit;
@synthesize fields;


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
    
    self.wordFillLabel.text = [fields objectAtIndex:4];
    NSString * timerTime = [fields objectAtIndex:3];
    int timerTimeNumber = [timerTime intValue];
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
    
}

-(void) timeIsUp:(NSTimer*)timer{
    NSString * wordFillAnswer2 = self.textField.text;
    NSString * wordFillAnswer;
    
    wordFillAnswer = [@"time ran out. " stringByAppendingString:wordFillAnswer2];    
    
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    NSString *answerObj = [NSString stringWithFormat:@"%@",wordFillAnswer];
    
    [questionAnswers2 addObject:answerObj];
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH_mm_ss.SSS"];
    NSString * timeNow2 = [df stringFromDate:myDate];
    
    [questionAnswers2 addObject:timeNow2];
    
    NSMutableArray * questionAnswers = [[NSMutableArray alloc] init]; 
    
    int retab = [questionAnswers2 count];
    
    for (int retabCounter = 0;retabCounter<retab;retabCounter++){
        NSString * retabWhatever = [questionAnswers2 objectAtIndex:retabCounter];
        retabWhatever = [retabWhatever stringByAppendingString:@"\t"];
        [questionAnswers addObject:retabWhatever];
    }
    
    NSString * newLn = @"\r";
    [questionAnswers addObject:newLn];
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    [thisQuestionData saveData:questionAnswers];
    
    [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
    
}



- (void)viewDidUnload
{
    [self setWordFillLabel:nil];
    [self setWordFillSubmit:nil];
    [self setTextField:nil];
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


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return (YES);
}


- (IBAction)wordFillSubmitPressed:(id)sender {
    
        [timer invalidate];
    
    NSString * wordFillAnswer = self.textField.text;
    
    if (wordFillAnswer.length > 0) {
        NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
        
        NSString *answerObj = [NSString stringWithFormat:@"%@",wordFillAnswer];
        
        [questionAnswers2 addObject:answerObj];
        
        NSDate *myDate = [NSDate date];
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"HH_mm_ss.SSS"];
        NSString * timeNow2 = [df stringFromDate:myDate];
        
        [questionAnswers2 addObject:timeNow2];
        
        NSMutableArray * questionAnswers = [[NSMutableArray alloc] init]; 
        
        int retab = [questionAnswers2 count];
        
        for (int retabCounter = 0;retabCounter<retab;retabCounter++){
            NSString * retabWhatever = [questionAnswers2 objectAtIndex:retabCounter];
            retabWhatever = [retabWhatever stringByAppendingString:@"\t"];
            [questionAnswers addObject:retabWhatever];
        }
        
        NSString * newLn = @"\r";
        [questionAnswers addObject:newLn];

        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:questionAnswers];
        
        [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
    }
    
}


@end
