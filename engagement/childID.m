//
//  childID.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "childID.h"
#import "QuestionData.h"
#import "GroupID.h"

@implementation childID

@synthesize buttonOne;
@synthesize textField;
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
    [self setButtonOne:nil];
    [self setTextField:nil];
    [self setTextField:nil];
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
    NSString * childIDString = self.textField.text;
    if (childIDString.length > 0)  //should be at least 2 letters?
        [buttonOne setEnabled:YES];
    return (YES);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"childIDtoGroupID"]){
    
    NSString * sendString = self.textField.text;
    
    NSMutableArray * sendName = [[NSMutableArray alloc] init];
    
    [sendName addObject:sendString];
    
    int numOf = 1;
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    [thisQuestionData saveData:sendName:numOf:filePath];
        
    GroupID * svc = [segue destinationViewController];
    svc.filePath = filePath; 
    } 
 	
}



@end
