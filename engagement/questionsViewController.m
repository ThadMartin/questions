//
//  questionsViewController.m
//  questions
//
//  Created by Thad Martin on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "questionsViewController.h"
#import "QuestionData.h"

@implementation questionsViewController

@synthesize butonTwo;
@synthesize sliderOne;
@synthesize labelOne;

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
    [butonTwo setTitle: @"toutch slider" forState:UIControlStateNormal];
    
    answerIndex = 0;
    questionAnswers = [[NSMutableArray alloc] init ];  //numbers from slider.
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    questionList = [thisQuestionData getQuestions];    
    numQuestions = [questionList count];
    
    self.labelOne.text = [questionList objectAtIndex:answerIndex];
    answerIndex ++;
    
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
    
    NSNumber *answerObj = [NSNumber numberWithInt:_answer];  //NSArray likes objects.
    [questionAnswers addObject: answerObj];
    
    if (answerIndex == numQuestions){
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:questionAnswers: numQuestions];
        exit(0);
    }
    else{
        self.labelOne.text = [questionList objectAtIndex:answerIndex];
        [butonTwo setEnabled:NO];
        [butonTwo setTitle: @"touch slider" forState:UIControlStateNormal];
        answerIndex ++;
    }
    
}

@end
