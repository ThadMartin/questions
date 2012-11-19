//
//  goodbye.m
//  engagement
//
//  Created by Thad Martin on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// A screen that says goodbye to the user.  This used to upload to dropbox, but now that is done by engagementViewController.

#import "goodbye.h"
#import "engagementAppDelegate.h"


@implementation goodbye{
}

@synthesize exitButton;


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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)viewDidUnload
{
    [self setExitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return NO;   
    else
        return YES;
}

- (IBAction)leave:(id)sender {
    //[NSThread sleepForTimeInterval:3]; //give dropbox a sec to upload.
    exit(0);
}


@end
