//
//  engagementViewController.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementViewController.h"
#import "QuestionData.h"
#import "lastName.h"
#import <DropboxSDK/DropboxSDK.h>

@interface engagementViewController ()


@end


@implementation engagementViewController //id <DBRestClientDelegate>

@synthesize textField;
@synthesize buttonOne;
@synthesize linkButton;


//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if ((self = [super initWithCoder:aDecoder])) {
//        self.title = @"Link Account";
//    }
//    return self;
//}


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
    [buttonOne setEnabled:NO];
    if ([[DBSession sharedSession] isLinked])
        [linkButton setTitle:@"is linked" forState:UIControlStateNormal];
    else
        [linkButton setTitle:@"is unLinked" forState:UIControlStateNormal];
    
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setButtonOne:nil];
   // [self setLinkButton:nil];
    [self setLinkButton:nil];
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
    NSString * docPath = [thisQuestionData createDataPath:sendName];

    if ([[segue identifier] isEqualToString:@"firstNameToLast"])
    {
        // Get reference to the destination view controller
         lastName * svc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        svc.filePath = docPath;   
    }

    
	
}



- (IBAction)linkButtonPressed:(id)sender {
    
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    } 
    else 
     [[DBSession sharedSession] unlinkAll];
    
}




@end
