//
//  badInFile.m
//  engagement
//
//  Created by Thad Martin on 8/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "badInFile.h"
#import "engagementAppDelegate.h"

@implementation badInFile

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
-(void)viewDidAppear:(BOOL)animated {
    
    NSError * error;
    
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    
    // we don't want to save data for this one.
    
    NSString * docPath = delegate.docPath;
    
    NSFileManager * filemgr = [NSFileManager defaultManager];

    [filemgr removeItemAtPath:docPath error:&error];
    
    if(error)
        NSLog(@"error: %@",error);

        [NSThread sleepForTimeInterval:3]; //give user time to read.
         [self performSegueWithIdentifier: @"toGoodbye" sender: self];
}


- (void)viewDidUnload
{
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

@end
