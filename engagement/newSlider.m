//
//  newSlider.m
//  engagement
//
//  Created by Thad Martin on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newSlider.h"
#import "QuestionData.h"
#import "questionSelector.h"
#import "engagementAppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>
#import "engagementAppDelegate.h"

@implementation newSlider  // <DBRestClientDelegate>


@synthesize linkButton;
@synthesize questionLabel;
@synthesize moveBox;
@synthesize qSlider;
@synthesize lowLabel;
@synthesize sliderSubmit;
//@synthesize linkButton;
@synthesize highLabel;
@synthesize infile;
//@synthesize answerIndex;
//@synthesize questionList;
//@synthesize questionAnswers;
//@synthesize numQuestions;

NSMutableArray * questionAnswers;
int currentAnswer;
NSArray * questionList;
int answerIndex;
int numQuestions;
//NSString * infile;



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
    
    
    [sliderSubmit setEnabled:NO];   //disable submit until there is input.
    [sliderSubmit setTitle: @"touch slider" forState:UIControlStateNormal];
    
     NSLog(@"This is infile %@",infile);
    
    
    questionAnswers = [[NSMutableArray alloc] init ];  //numbers from slider.  Need init here?
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    questionList = [thisQuestionData getQuestions:infile];
    
    //[NSThread sleepForTimeInterval:.5];
    
    self.lowLabel.text = [questionList objectAtIndex:1];
    self.highLabel.text = [questionList objectAtIndex:2];
    answerIndex = 3;
    
    
    numQuestions = ([questionList count]);
    
    while (questionList.count <1 ) {
        NSLog(@"well, that didn't work...");
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData getQuestions:infile];
        
    }
        
    if ([[DBSession sharedSession] isLinked])
            [linkButton setTitle:@"is linked" forState:UIControlStateNormal];
    else
            [linkButton setTitle:@"is unLinked" forState:UIControlStateNormal];
        


        
    //NSString * lastLine = [questionList objectAtIndex:numQuestions-1];
    
    //if ([[questionList objectAtIndex:numQuestions-1] length] < 4)
        numQuestions --;   //assume one blank line at the end.
    NSLog(@"numQuestions%i",numQuestions);
    
    self.questionLabel.text = [questionList objectAtIndex:answerIndex];
    answerIndex ++;
    
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
    [self setLinkButton:nil];
    [self setLinkButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
        
        currentAnswer = (int)touchPoint.x/moveBox.bounds.size.width*100;
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
            currentAnswer = (int)touchPoint.x/moveBox.bounds.size.width*100;
        }
        //  [buttonTap setEnabled:NO];
    }
}


- (IBAction)sliderSubmitPressed:(id)sender {
   // int answer = (int) touchPoint.x/moveBox.bounds.size.width*100; //  0 to 100
    
    //    NSNumber *answerObj = [NSNumber numberWithInt:_answer]; 
    NSString *answerObj = [NSString stringWithFormat:@"%d \n",currentAnswer];  //NSArray likes objects.
    
    [questionAnswers addObject: answerObj];
    
    if (answerIndex == numQuestions){
        
        engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
        
        NSString * theDocPath = delegate.docPath;

        
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:questionAnswers: (numQuestions-3):theDocPath];
        
        [NSThread sleepForTimeInterval:1];
        
        [thisQuestionData uploadToDropBox:theDocPath];
        
        //[NSThread sleepForTimeInterval:15];
        
        //exit(0);     //if the end is in, file doesn't get uploaded.  uploads but doesn't end otherwise.  Try segue to "that's all, floks" screen?
        //[prepareForSegue];
        
        //[NSThread sleepForTimeInterval:2];
        
        
        [self performSegueWithIdentifier: @"newSliderToEnd" 
                                  sender: self];
        
        NSLog(@"This is where we're supposed to end...");
    }
    else{
        NSLog(@"%i",answerIndex);
        //NSLog(@"%@",questionList);
        self.questionLabel.text = [questionList objectAtIndex:answerIndex];
        //self.questionLabel.text = @"number 2";
        [sliderSubmit setEnabled:NO];
        qSlider.hidden = YES;
        [sliderSubmit setTitle: @"touch slider" forState:UIControlStateNormal];
        answerIndex ++;
    }
    
  
    
    
}
- (IBAction)linkButtonPressed:(id)sender {
  
        
        if (![[DBSession sharedSession] isLinked]) {
            [[DBSession sharedSession] linkFromController:self];
        } 
        else 
            [[DBSession sharedSession] unlinkAll];
  
}



- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    //exit(0);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    NSLog(@"File upload failed with error - %@", error);
}





@end
