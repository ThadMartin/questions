//
//  engagementViewController.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementViewController.h"


@implementation engagementViewController 

@synthesize linkLabel;
@synthesize continueButton;
@synthesize linkButton;
@synthesize unlinkButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (([[DBSession sharedSession] isLinked])){
       linkLabel.text = @"app is linked to dropbox";
    }
    else
        linkLabel.text = @"app not linked to dropbox";
}

- (void)viewDidUnload
{
    [self setLinkButton:nil];
    [self setUnlinkButton:nil];
    [self setContinueButton:nil];
    [self setLinkLabel:nil];
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
    
    //comment the lines below to show the screen to unlink from a dropbox account.
    
    // if ([[DBSession sharedSession] isLinked])
     //    [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
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
 
        return YES;
}


- (IBAction)linkButtonPressed:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        
        [NSThread sleepForTimeInterval:1]; 
        
        linkLabel.text = @"";
    }
    else 
        linkLabel.text = @"app is linked to dropbox";
}


- (IBAction)unlinkButtonPressed:(id)sender {
    if ([[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] unlinkAll];
        
        [NSThread sleepForTimeInterval:1]; 
        
        if (![[DBSession sharedSession] isLinked])
            linkLabel.text = @"app not linked to dropbox";
    }
 
}

- (IBAction)continueButtonPressed:(id)sender {
   [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
}
@end



