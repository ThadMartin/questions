//
//  instruction.m
//  engagement
//
//  Created by Thad Martin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "instruction.h"
#import "QuestionData.h"
#import "instruction2.h"
#import "engagementAppDelegate.h"

@implementation instruction{
    NSTimer * timer;
    BOOL gotoBigInstruction;
    engagementAppDelegate * appDelegate;
}

@synthesize fields;
@synthesize instructionLabel;
@synthesize continueButton;


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
    
    if ([[fields objectAtIndex:7] isEqualToString:@"yes"]){
        NSLog(@"going to big instruction");
        gotoBigInstruction = YES;
        //[self performSegueWithIdentifier: @"toBigInstruction" sender: self];
        //too soon.
    }
    else{
        
        self.instructionLabel.text = [fields objectAtIndex:5]; 
        NSString * timerTime = [fields objectAtIndex:4];
        float timerTimeNumber = [timerTime floatValue];
        NSLog(@"timerTime: %@",timerTime);
        if (timerTimeNumber > 0){
            timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
            NSRunLoop *runner = [NSRunLoop currentRunLoop];
            [runner addTimer: timer forMode: NSDefaultRunLoopMode];
        }
        
        NSString * showButton =[fields objectAtIndex:6];
        BOOL showButtonBool = [showButton boolValue];
        if (!showButtonBool)
            [continueButton setHidden:true];
    }
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
    if ([segue.identifier isEqualToString:@"toBigInstruction"]){
        instruction2 * svc = [segue destinationViewController];
        svc.fields = fields; 
    } 
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"just before segue");
    if(gotoBigInstruction){
        //[NSThread sleepForTimeInterval:0.5];
        [self performSegueWithIdentifier: @"toBigInstruction" sender: self];
        
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
    
    [self dismissModalViewControllerAnimated:NO];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setInstructionLabel:nil];
    [self setContinueButton:nil];
    
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



