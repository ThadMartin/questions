//
//  engagementViewController.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementViewController.h"
#import "QuestionData.h"
//#import "lastName.h"
#import "engagementAppDelegate.h"



@implementation engagementViewController 

@synthesize textField;
@synthesize buttonOne;

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
	// Do any additional setup after loading the view, typically from a nib.
    // [buttonOne setEnabled:NO];
   
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setButtonOne:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(BOOL)textFieldShouldReturn:(UITextField *)TheTextField{
    [TheTextField resignFirstResponder];
//    NSString * studentID = self.textField.text;
//    if (studentID.length > 0)  //some input...
           // [buttonOne setEnabled:YES];
    return (YES);
}



//

- (IBAction)submitStudentId:(id)sender {
    NSString * studentID = self.textField.text;
    if (studentID.length > 0) {
        NSString *answerObj = [NSString stringWithFormat:@"%@ \n",studentID];
        questionAnswers = [[NSMutableArray alloc] init ];
        [questionAnswers addObject: answerObj];
        engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];        
        NSString * theDocPath = delegate.docPath;
        
        
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:questionAnswers: 1:theDocPath];
        //go to next page
        [self performSegueWithIdentifier: @"toTableView2" 
                                  sender: self];
    }
            
    
}
@end
