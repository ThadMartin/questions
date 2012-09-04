//
//  numberFill.m
//  engagement
//
//  Created by Thad Martin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "numberFill.h"
#import "questionParser.h"
#import "QuestionData.h"

@implementation numberFill{
    NSTimer * timer;
}

@synthesize numberFillText;
@synthesize numberLabel;
@synthesize numbersPlease;
@synthesize fields;
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
    self.numberLabel.text = [fields objectAtIndex:5];
    NSString * timerTime = [fields objectAtIndex:4];
    //NSLog(@"fields: %@",fields);
    float timerTimeNumber = [timerTime floatValue];
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
}

-(void) timeIsUp:(NSTimer*)timer{
    NSString * numberFillAnswer2 = self.numberFillText.text;
    NSString * numberFillAnswer;
    
    numberFillAnswer = [@"time ran out. " stringByAppendingString:numberFillAnswer2];    
    
        
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
        
        [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];

}


- (void)viewDidUnload
{
    [self setSubmitButton:nil];
    [self setNumberFillText:nil];
    [self setNumberLabel:nil];
    [self setNumbersPlease:nil];
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


- (IBAction)submitButtonPressed:(id)sender {
    [timer invalidate]; 
    NSString * numberFillAnswer = self.numberFillText.text;
    
    if (numberFillAnswer.length > 0) {
        
        //        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        //        if ([numberFillAnswer rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        
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
        
        [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
        //            
        //        }//numbers only, saved.
        //        
        //        else{
        //            numbersPlease.text = @"Numbers only, please.";
        //            self.numberFillText.text = @"";
        //        }
        
    }//nothing submitted
    
}
@end

