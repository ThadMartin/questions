//
//  questionsViewController.m
//  questions
//
//  Created by Thad Martin on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "questionsViewController.h"
#import "QuestionData.h"
#import "engagementAppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>

@implementation questionsViewController

@synthesize butonTwo;
@synthesize sliderOne;
@synthesize labelOne;
@synthesize filePath;

int answerIndex;
int numQuestions;

NSArray * questionList;

QuestionData * thisQuestionData; 

NSMutableArray * questionAnswers;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [butonTwo setEnabled:NO];   //disable submit until there is input.
    [butonTwo setTitle: @"touch slider" forState:UIControlStateNormal];
    
    answerIndex = 0;
    questionAnswers = [[NSMutableArray alloc] init ];  //numbers from slider.
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    questionList = [thisQuestionData getQuestions];    
    numQuestions = [questionList count];
    
    if ([[questionList objectAtIndex:numQuestions-1] length] < 1)
        numQuestions --;   //incase there is a blank line at the end.
    NSLog(@"%i",numQuestions);
    
    self.labelOne.text = [questionList objectAtIndex:answerIndex];
    answerIndex ++;
    
    sliderOne.value = 50;
    
     
}

- (void)viewDidUnload
{
    [self setSliderOne:nil];
    [self setLabelOne:nil];
    [self setButonTwo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (IBAction)sliderOneMoved:(id)sender {
    [butonTwo setEnabled:YES];
    [butonTwo setTitle: @"submit" forState:UIControlStateNormal];
}

- (IBAction)buttonTwoPressed:(id)sender {    

    int _answer = (int)sliderOne.value; //  0 to 100
    
//    NSNumber *answerObj = [NSNumber numberWithInt:_answer]; 
    NSString *answerObj = [NSString stringWithFormat:@"%d",_answer];  //NSArray likes objects.

    [questionAnswers addObject: answerObj];
    
    if (answerIndex == numQuestions){
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:questionAnswers: (numQuestions):filePath];
        
        //[NSThread sleepForTimeInterval:2];
        
        [thisQuestionData uploadToDropBox:filePath];
        
              //[NSThread sleepForTimeInterval:15];
        
         //exit(0);     //if the end is in, file doesn't get uploaded.  uploads but doesn't end otherwise.  Try seguay to "that's all, floks" screen?
        //[prepareForSegue];
        
        //[NSThread sleepForTimeInterval:2];

        
        [self performSegueWithIdentifier: @"oldSliderToNew" 
                                  sender: self];

        NSLog(@"This is where we're supposed to end...");
    }
    else{
        self.labelOne.text = [questionList objectAtIndex:answerIndex];
        [butonTwo setEnabled:NO];
        sliderOne.value = 50;
        [butonTwo setTitle: @"touch slider" forState:UIControlStateNormal];
        answerIndex ++;
    }
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//  	
//}
//
//
//


@end
