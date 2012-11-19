//
//  branchTo.m
//  engagement
//
//  Created by Thad Martin on 11/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "branchTo.h"
#import "questionParser.h"
#import "engagementAppDelegate.h"

@implementation branchTo{
    engagementAppDelegate * appDelegate;
}

@synthesize questionParser;
@synthesize fields;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
        [super viewDidLoad];
}
*/

-(void)leaveHere{
    [self dismissModalViewControllerAnimated:NO];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSLog(@"branch to view says it appeared.");
    //this comes from code in branchOut, see that for some comments and debug.
    //line 0 is the header line. 
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
    int lengthQnsPths = [theQuestions count];
    NSString * newInputFile = [fields objectAtIndex:5];
    NSString * stringLineNumber = [fields objectAtIndex:6];
    int branchLineNumber = [stringLineNumber intValue];
    for (int stepThrough = 0; stepThrough < lengthQnsPths; stepThrough++){
        NSString * checkThis = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
        NSString * checkingString = [checkThis lastPathComponent];
        // NSLog(@"they are: %@ %@",checkThis,checkingString);
        if ([checkingString isEqualToString: newInputFile]) {
            newInputFile = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
        }
    }
    
    NSLog(@"new input file:  %@",newInputFile);
    
    BOOL inRandom = NO;
    
    if(newInputFile)
        [self.questionParser setInputFile:(newInputFile)];
    
    if(branchLineNumber)
        [self.questionParser setLineNbr:(branchLineNumber)];
    
    [self.questionParser setInRnd:(inRandom)];
    
    //NSLog(@"next question");
    
    // You can NOT call dismissModalViewController from here.  Makes for a hard to find bug.
    
    [self performSelector: @selector(leaveHere)
               withObject: nil
               afterDelay: 0];

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
