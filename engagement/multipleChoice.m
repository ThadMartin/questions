//
//  multipleChoice.m
//  engagement
//
//  Created by Thad Martin on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "multipleChoice.h"
#import "questionParser.h"
#import "QuestionData.h"


@implementation multipleChoice{
    int numOfChoices;
    NSString * choiceSelection;
}

@synthesize choice1Label;
@synthesize choice2Label;
@synthesize choice3Label;
@synthesize choice4Label;
@synthesize choice5Label;
@synthesize choice6Label;
@synthesize choice7Label;
@synthesize choice8Label;
@synthesize choice9Label;
@synthesize choice10Label;
@synthesize choice11Label;
@synthesize choice12Label;

@synthesize choice10;
@synthesize choice11;
@synthesize choice12;
@synthesize choice7;
@synthesize choice8;
@synthesize choice9;
@synthesize choice6;
@synthesize choice5;
@synthesize choice4;
@synthesize choice3;
@synthesize choice1;
@synthesize choice2;
@synthesize fields;
@synthesize multipleChoiceQuestion;
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
    choiceSelection = nil;
    self.multipleChoiceQuestion.text = [fields objectAtIndex:3];
    
    for (int choiceCounter = 4;choiceCounter < [fields count];choiceCounter++){
        NSString * theChoice = [fields objectAtIndex:choiceCounter];
        if([theChoice length] >0)
            numOfChoices ++;
    }
    
    
    NSLog(@"numOfchoices =%i",numOfChoices);
    
    switch (numOfChoices) {
        case 1:
            self.choice1Label.text = [fields objectAtIndex:4];
            [choice2 setHidden:true];
            [choice3 setHidden:true];
            [choice4 setHidden:true];
            [choice5 setHidden:true];
            [choice6 setHidden:true];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 2:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            [choice3 setHidden:true];
            [choice4 setHidden:true];
            [choice5 setHidden:true];
            [choice6 setHidden:true];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 3:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            [choice4 setHidden:true];
            [choice5 setHidden:true];
            [choice6 setHidden:true];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 4:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            [choice5 setHidden:true];
            [choice6 setHidden:true];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 5:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            [choice6 setHidden:true];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 6:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            [choice7 setHidden:true];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 7:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            [choice8 setHidden:true];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 8:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            [choice9 setHidden:true];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 9:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            self.choice9Label.text = [fields objectAtIndex:12];
            [choice10 setHidden:true];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
        case 10:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            self.choice9Label.text = [fields objectAtIndex:12];
            self.choice10Label.text = [fields objectAtIndex:13];
            [choice11 setHidden:true];
            [choice12 setHidden:true];
            
            break;
            
            
        case 11:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            self.choice9Label.text = [fields objectAtIndex:12];
            self.choice10Label.text = [fields objectAtIndex:13];
            self.choice11Label.text = [fields objectAtIndex:14];
            [choice12 setHidden:true];
            
            break;
            
        case 12:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            self.choice9Label.text = [fields objectAtIndex:12];
            self.choice10Label.text = [fields objectAtIndex:13];
            self.choice11Label.text = [fields objectAtIndex:14];
            self.choice12Label.text = [fields objectAtIndex:15];
            
            break;
            
            
        default:
            self.choice1Label.text = [fields objectAtIndex:4];
            self.choice2Label.text = [fields objectAtIndex:5];
            self.choice3Label.text = [fields objectAtIndex:6];
            self.choice4Label.text = [fields objectAtIndex:7];
            self.choice5Label.text = [fields objectAtIndex:8];
            self.choice6Label.text = [fields objectAtIndex:9];
            self.choice7Label.text = [fields objectAtIndex:10];
            self.choice8Label.text = [fields objectAtIndex:11];
            self.choice9Label.text = [fields objectAtIndex:12];
            self.choice10Label.text = [fields objectAtIndex:13];
            self.choice11Label.text = [fields objectAtIndex:14];
            self.choice12Label.text = [fields objectAtIndex:15];
            
            break;
            
    }
    
    
}


- (void)viewDidUnload
{
    [self setMultipleChoiceQuestion:nil];
    [self setSubmitButton:nil];
    [self setChoice2:nil];
    [self setChoice3:nil];
    [self setChoice1:nil];
    [self setChoice4:nil];
    [self setChoice5:nil];
    [self setChoice6:nil];
    [self setChoice7:nil];
    [self setChoice8:nil];
    [self setChoice9:nil];
    [self setChoice1Label:nil];
    [self setChoice2Label:nil];
    [self setChoice3Label:nil];
    [self setChoice4Label:nil];
    [self setChoice5Label:nil];
    [self setChoice6Label:nil];
    [self setChoice7Label:nil];
    [self setChoice8Label:nil];
    [self setChoice9Label:nil];
    [self setChoice10:nil];
    [self setChoice11:nil];
    [self setChoice12:nil];
    [self setChoice10Label:nil];
    [self setChoice11Label:nil];
    [self setChoice12Label:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)choice1pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+1)];
    [choice1 setHighlighted:YES];
    self.choice1.selected = YES;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}


- (IBAction)choice2pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+2)];
    [choice2 setHighlighted:YES];
    self.choice1.selected = NO;
    self.choice2.selected = YES;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice3pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+3)];
    [choice3 setHighlighted:YES];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = YES;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice4pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+4)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = YES;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice5pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+5)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = YES;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice6pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+6)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = YES;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice7pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+7)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = YES;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice8pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+8)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = YES;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice9pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+9)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = YES;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}

- (IBAction)choice10pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+10)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = YES;
    self.choice11.selected = NO;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
    
}
- (IBAction)choice11pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+11)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = YES;
    self.choice12.selected = NO;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
}
- (IBAction)choice12pressed:(id)sender {
    choiceSelection = [fields objectAtIndex:(3+12)];
    self.choice1.selected = NO;
    self.choice2.selected = NO;
    self.choice3.selected = NO;
    self.choice4.selected = NO;
    self.choice5.selected = NO;
    self.choice6.selected = NO;
    self.choice7.selected = NO;
    self.choice8.selected = NO;
    self.choice9.selected = NO;
    self.choice10.selected = NO;
    self.choice11.selected = NO;
    self.choice12.selected = YES;
    [self performSelector:@selector(highlightButton) withObject:sender afterDelay:0.0];
}

- (void)highlightButton {
    if ( self.choice1.selected ) 
        self.choice1.highlighted = YES;
    else
        self.choice1.highlighted = NO;
    if ( self.choice2.selected ) 
        self.choice2.highlighted = YES;
    else
        self.choice2.highlighted = NO;
    if ( self.choice3.selected ) 
        self.choice3.highlighted = YES;
    else
        self.choice3.highlighted = NO;
    if ( self.choice4.selected ) 
        self.choice4.highlighted = YES;
    else
        self.choice4.highlighted = NO;
    if ( self.choice5.selected ) 
        self.choice5.highlighted = YES;
    else
        self.choice5.highlighted = NO;
    if ( self.choice6.selected ) 
        self.choice6.highlighted = YES;
    else
        self.choice6.highlighted = NO;
    if ( self.choice7.selected ) 
        self.choice7.highlighted = YES;
    else
        self.choice7.highlighted = NO;
    if ( self.choice8.selected ) 
        self.choice8.highlighted = YES;
    else
        self.choice8.highlighted = NO;
    if ( self.choice9.selected ) 
        self.choice9.highlighted = YES;
    else
        self.choice9.highlighted = NO;
    if ( self.choice10.selected ) 
        self.choice10.highlighted = YES;
    else
        self.choice10.highlighted = NO;
    if ( self.choice11.selected ) 
        self.choice11.highlighted = YES;
    else
        self.choice11.highlighted = NO;
    if ( self.choice12.selected ) 
        self.choice12.highlighted = YES;
    else
        self.choice12.highlighted = NO;    
}


- (IBAction)submitButtonPressed:(id)sender {
    
    if (choiceSelection.length > 0) {
        
        NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
        
       // NSString * removeNLs = [questionAnswers2 objectAtIndex:3];
        
        //removeNLs = [removeNLs stringByReplacingOccurrencesOfString:@"\n" withString:@"&NL"];
        
        //[questionAnswers2 replaceObjectAtIndex:3 withObject:removeNLs];
        
        NSString *answerObj = [NSString stringWithFormat:@"%@",choiceSelection];
        
        [questionAnswers2 addObject:answerObj];
        
        NSDate *myDate = [NSDate date];
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"HH_mm_ss"];
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
        
        NSLog(@"submitted multipleChoice");
        
        NSLog(@"going back toQuestionParser");
        
        [self performSegueWithIdentifier: @"backToQuestionParser" sender: self];
        
    }  // otherwise submit was pushed w/o selecting anything, don't do anything. 
    
}



@end
