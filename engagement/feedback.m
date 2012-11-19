//
//  feedback.m
//  engagement
//
//  Created by Thad Martin on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "feedback.h"
#import "QuestionData.h"

@implementation feedback{
    NSTimer * timer;
    int numOfChoices;
}

@synthesize fields;
@synthesize instructionLabel;
@synthesize continueButton;
@synthesize previousAnswer;

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

    //NSLog(@"fields:  %@",fields);
    //self.instructionLabel.text = [fields objectAtIndex:5];
    //self.instructionLabel.text = [self.instructionLabel.text stringByAppendingString:previousAnswer];
    
    numOfChoices = 0;
    
    for (int choiceCounter = 5;choiceCounter < [fields count];choiceCounter+=2){
        NSString * theChoice = [fields objectAtIndex:choiceCounter];
        if([theChoice length] >0)
            numOfChoices ++;
    }
    
    switch (numOfChoices) {
        case 1:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            break;
            
        case 2:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            break;
            
        case 3:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            break;
            
        case 4:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            break;
            
        case 5:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            break;
            
        case 6:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
             break;
            
        case 7:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            break;
            
        case 8:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            if ([[fields objectAtIndex:19] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:20];
            break;
            
        case 9:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            if ([[fields objectAtIndex:19] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:20];
            if ([[fields objectAtIndex:21] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:22];
            break;
            
        case 10:
            
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            if ([[fields objectAtIndex:19] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:20];
            if ([[fields objectAtIndex:21] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:22];
            if ([[fields objectAtIndex:23] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:24];
            break;
            
        case 11:

            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            if ([[fields objectAtIndex:19] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:20];
            if ([[fields objectAtIndex:21] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:22];
            if ([[fields objectAtIndex:23] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:24];
            if ([[fields objectAtIndex:25] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:26];
            break;
            
        case 12:
            if ([[fields objectAtIndex:5] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:6];    
            if ([[fields objectAtIndex:7] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:8];
            if ([[fields objectAtIndex:9] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:10];
            if ([[fields objectAtIndex:11] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:12];
            if ([[fields objectAtIndex:13] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:14];
            if ([[fields objectAtIndex:15] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:16];
            if ([[fields objectAtIndex:17] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:18];
            if ([[fields objectAtIndex:19] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:20];
            if ([[fields objectAtIndex:21] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:22];
            if ([[fields objectAtIndex:23] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:24];
            if ([[fields objectAtIndex:25] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:26];
            if ([[fields objectAtIndex:27] isEqualToString:previousAnswer])
                self.instructionLabel.text = [fields objectAtIndex:28];

            break;
            

        default:
            self.instructionLabel.text = @"";
    }
    
    NSString * timerTime = [fields objectAtIndex:4];
    float timerTimeNumber = [timerTime floatValue];
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
}


-(void) timeIsUp:(NSTimer*)timer{
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    NSString *answerObj = [NSString stringWithFormat:@"time ran out."];
    
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
    
    //[self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
    [self dismissModalViewControllerAnimated:NO];
}


- (void)viewDidUnload
{
    [self setInstructionLabel:nil];
    [self setContinueButton:nil];
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


- (IBAction)continueButtonPressed:(id)sender {
    
    [timer invalidate];
    
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    
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
    
    NSLog(@"going back to questionParser");
    
    [self dismissModalViewControllerAnimated:NO];
}
@end



