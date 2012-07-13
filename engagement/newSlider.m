//
//  newSlider.m
//  engagement
//
//  Created by Thad Martin on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newSlider.h"
#import "QuestionData.h"
#import <DropboxSDK/DropboxSDK.h>
#import "questionParser.h"

@implementation newSlider  {
    NSTimer * timer;
}

@synthesize questionLabel;
@synthesize moveBox;
@synthesize qSlider;
@synthesize lowLabel;
@synthesize sliderSubmit;
@synthesize highLabel;
@synthesize infile;
@synthesize fields;


float currentAnswer = -1;
NSArray * questionList;
int answerIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"toNewSliderWorked");
    
    [sliderSubmit setEnabled:NO];   //disable submit until there is input.
    [sliderSubmit setTitle: @"touch slider" forState:UIControlStateNormal];    
    
    self.lowLabel.text = [fields objectAtIndex:5];
    self.highLabel.text = [fields objectAtIndex:6];   
    self.questionLabel.text = [fields objectAtIndex:4];
    
    NSString * timerTime = [fields objectAtIndex:3];
    int timerTimeNumber = [timerTime intValue];
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }

    
}

-(void) timeIsUp:(NSTimer*)timer{
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    NSString *answerObj = [NSString stringWithFormat:@"Time ran out.  %f",currentAnswer];
    
    [questionAnswers2 addObject:answerObj];
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH_mm_ss"];
    NSString * timeNow = [df stringFromDate:myDate];
    
    [questionAnswers2 addObject:timeNow];
    
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

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [self setMoveBox:nil];
    [self setQSlider:nil];
    [self setSliderSubmit:nil];
    [self setQuestionLabel:nil];
    [self setLowLabel:nil];
    [self setHighLabel:nil];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	// We only support single touches, so anyObject retrieves just that touch from touches;
	UITouch *touch = [touches anyObject];
    
    NSLog(@"touched");
    
    qSlider.bounds = CGRectMake(0,0,4,100);
    
    if (touch.view == moveBox){
        // Animate the first touch
        
        NSLog(@"in box");
        CGPoint touchPoint = [touch locationInView:moveBox];
        touchPoint.y = moveBox.bounds.size.height/2;
        qSlider.center = touchPoint;
        qSlider.hidden = NO;
        sliderSubmit.enabled = YES;
        [sliderSubmit setTitle: @"submit" forState:UIControlStateNormal];
        NSLog(@"point %f",touchPoint.x/moveBox.bounds.size.width*100);
        
        currentAnswer = touchPoint.x/moveBox.bounds.size.width*100;
    }
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	// Animate the first touch
    if (touch.view == moveBox){
        CGPoint touchPoint = [touch locationInView:moveBox];
        if(touchPoint.x > 0 && touchPoint.x < moveBox.bounds.size.width){
            touchPoint.y = moveBox.bounds.size.height/2;
            qSlider.center = touchPoint;
            NSLog(@"%f", (touchPoint.x/moveBox.bounds.size.width)*100);
            currentAnswer = touchPoint.x/moveBox.bounds.size.width*100;
        }
    }
}


- (IBAction)sliderSubmitPressed:(id)sender {
    
        [timer invalidate];
    
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    NSString *answerObj = [NSString stringWithFormat:@"%f",currentAnswer];
    
    [questionAnswers2 addObject:answerObj];
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH_mm_ss"];
    NSString * timeNow = [df stringFromDate:myDate];
    
    [questionAnswers2 addObject:timeNow];
    
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
