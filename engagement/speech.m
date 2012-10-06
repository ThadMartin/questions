//
//  speech.m
//  engagement
//
//  Created by Thad Martin on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "speech.h"
#import "FliteTTS.h"
#import "QuestionData.h"


@class FliteTTS;

@implementation speech{
    NSRunLoop *runner;
    FliteTTS *fliteEngine;
    NSTimer * timer;
    NSTimer * timerBefore;
    NSTimer * timerAfter;
    float pauseBefore;
    float pauseAfter;
    int timesToRepeat;
    int timesSaid;
}

@synthesize speechLabel;
@synthesize fields;
@synthesize textField;
@synthesize submitButton;

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
    //NSLog(@"about to try to talk");
    fliteEngine = [[FliteTTS alloc] init];
    [fliteEngine setVoice:@"cmu_us_rms"];
//    [fliteEngine setVoice:@"cmu_us_kal"];
//    [fliteEngine setVoice:@"cmu_us_kal16"];
//    [fliteEngine setVoice:@"cmu_us_awb"];
//    [fliteEngine setVoice:@"cmu_us_slt"];
//    [fliteEngine setPitch:100.0 variance:50.0 speed:1.0];	// Change the voice properties

    
    self.speechLabel.text = [fields objectAtIndex:5];
    NSString * timerTime = [fields objectAtIndex:4];
    float timerTimeNumber = [timerTime floatValue];
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
    
    NSString * strPauseBefore = [fields objectAtIndex:6];
    pauseBefore = [strPauseBefore floatValue];
    NSString * strPauseAfter = [fields objectAtIndex:8];
    pauseAfter = [strPauseAfter floatValue];
    NSString * strRepeat = [fields objectAtIndex:9];
    timesToRepeat = [strRepeat intValue];
    //NSLog(@"before, %i, after, %i, repeat, %i",pauseBefore,pauseAfter,timesToRepeat);
    NSString * showButton =[fields objectAtIndex:10];
    NSString * showLabel = [fields objectAtIndex:11];
    NSString * showField = [fields objectAtIndex:12];
    BOOL showFieldBool = [showField boolValue];
    BOOL showButtonBool = [showButton boolValue];
    BOOL showLabelBool = [showLabel boolValue];
    if (!showFieldBool){
        [textField setHidden:true];
         }
    else {
        [textField setHidden:false];
         }
    if (!showButtonBool){
        [submitButton setHidden:true];
        
    }
    else {
        [submitButton setHidden:false];
         }
    if (!showLabelBool){
         [speechLabel setHidden:true];
    }
    else {
         [speechLabel setHidden:false];
        
    }

}



-(void) sayIt:(NSTimer*)timer{
//    NSLog(@"timesToRepeat:");
//    NSLog(@"timesToRepeat: %@",fields);
    [fliteEngine stopTalking];

    if (timesToRepeat > 0){ 
        NSString * textToSay = [fields objectAtIndex:7];
        NSLog(@"about to try to talk, %@",textToSay);
        [fliteEngine speakText:textToSay];	// Make it talk
        timesToRepeat --;
        if (pauseAfter >= 0){
            timerAfter = [NSTimer scheduledTimerWithTimeInterval:pauseAfter target:self selector:@selector(sayIt:) userInfo:nil repeats:NO];
            
        }
        else{
            timerAfter = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(sayIt:) userInfo:nil repeats:NO];
        }
            [runner addTimer: timerAfter forMode: NSDefaultRunLoopMode];
    }//end of sayIt
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (pauseBefore >= 0){
        timerBefore = [NSTimer scheduledTimerWithTimeInterval:pauseBefore target:self selector:@selector(sayIt:) userInfo:nil repeats:NO];
    }
    else{
        timerBefore = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(sayIt:) userInfo:nil repeats:NO]; 
    }
    [runner addTimer: timerBefore forMode: NSDefaultRunLoopMode];
    
    NSLog(@"nearly about to try to talk, ");
    
    // [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
    
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setSubmitButton:nil];
    [self setSpeechLabel:nil];
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

- (IBAction)submitButtonPressed:(id)sender {
    
    [timer invalidate]; 
    [timerAfter invalidate];
    [timerBefore invalidate];
    [fliteEngine stopTalking];
    
        NSString * numberFillAnswer = self.textField.text;
        
                   
            NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
            
            NSString *answerObj = [NSString stringWithFormat:@"%@",numberFillAnswer];
            
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
            
            NSLog(@"Going back to questionParser");
            
            [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
            
      //  }//nothing submitted
        
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)TheTextField{
    [TheTextField resignFirstResponder];
    return (YES);
}


-(void) timeIsUp:(NSTimer*)timer{
    [fliteEngine stopTalking];
    //[timer invalidate]; 
    [timerAfter invalidate];
    [timerBefore invalidate];
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



@end
