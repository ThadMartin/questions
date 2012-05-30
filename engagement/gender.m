//
//  gender.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "gender.h"
#import "QuestionData.h"
#import "questionsViewController.h"

@implementation gender

@synthesize filePath;
@synthesize girlButton;
@synthesize boyButton;
//@synthesize buttonThree;
//@synthesize buttonFour;
@synthesize buttonOne;
@synthesize genderLabel;

NSString * sendString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [buttonOne setEnabled:NO];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)isGirl:(id)sender {
    [buttonOne setEnabled:YES];
    [girlButton setSelected:YES];
    [girlButton setHighlighted:YES];
    [boyButton setSelected:NO];
    [boyButton setHighlighted:NO];
    sendString = @"girl";
    genderLabel.text = @"girl";
    
}
- (IBAction)isBoy:(id)sender {
    [buttonOne setEnabled:YES];
    [girlButton setSelected:NO];
    [girlButton setHighlighted:NO];
    [boyButton setSelected:YES];
    [boyButton setHighlighted:YES];
    sendString = @"boy";
    genderLabel.text = @"boy";


    
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


- (void)viewDidUnload
{
//    [self setButtonThree:nil];
//    [self setButtonFour:nil];
    [self setButtonOne:nil];
    [self setGirlButton:nil];
    [self setBoyButton:nil];
    [self setGenderLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (YES);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSString *sendString;
	if ([segue.identifier isEqualToString:@"genderToQuestions"]){
        
//        if ([buttonThree isHighlighted ]){ 
//            sendString = @"Boy";
//        }
//        else {
//            sendString = @"Girl";
//        }
        
        NSMutableArray * sendName = [[NSMutableArray alloc] init];
        
        [sendName addObject:sendString];
        
        int numOf = 1;
        
        QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
        [thisQuestionData saveData:sendName:numOf:filePath];
        
        questionsViewController * svc = [segue destinationViewController];
        svc.filePath = filePath; 
    } 
 	
}



@end
