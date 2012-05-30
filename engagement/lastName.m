//
//  lastName.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lastName.h"
#import "QuestionData.h"
#import "childID.h"


@implementation lastName
@synthesize textField;
@synthesize buttonOne;
@synthesize filePath;

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
    [buttonOne setEnabled:NO];
}


- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setButtonOne:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (YES);
}

-(BOOL)textFieldShouldReturn:(UITextField *)TheTextField{
    [TheTextField resignFirstResponder];
    NSString * firstNameString = self.textField.text;
    if (firstNameString.length > 0)  //Name should be at least 2 letters?
        [buttonOne setEnabled:YES];
    return (YES);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSString * sendString = self.textField.text;
    
    NSMutableArray * sendName = [[NSMutableArray alloc] init];
    
    [sendName addObject:sendString];
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    
    [thisQuestionData saveData: sendName:1 :filePath];
    
    if ([[segue identifier] isEqualToString:@"lastNameToChildID"])
    {
        // Get reference to the destination view controller
        childID * svc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        svc.filePath = filePath;   
    }
	
}


@end
