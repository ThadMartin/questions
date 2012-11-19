//
//  titrationBranch.m
//  engagement
//
//  Created by Thad Martin on 11/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "titrationBranch.h"
#import "questionParser.h"
#import "engagementAppDelegate.h"


@implementation titrationBranch{
    engagementAppDelegate * appDelegate;
    BOOL modified;
    NSString * newInputFile;
    BOOL inRandom;
    int branchLineNumber;
}

@synthesize fields;
@synthesize titrationVerbalLevel;
@synthesize titrationSpatialLevel;
@synthesize questionParser;

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
    if(modified){
        [self.questionParser setInRnd:(inRandom)];
        [self.questionParser setLineNbr:(branchLineNumber)];
        [self.questionParser setInputFile:(newInputFile)];
    }
    
    [self dismissModalViewControllerAnimated:NO];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //NSLog(@"titrationBranch View did appear ran.");
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSMutableArray * theQuestions = appDelegate.allQnsAndPaths;
    int lengthQnsPths = [theQuestions count];
    
    int theLevel;
    NSString * stringLineNumber;
    int numOfChoices = 0;
    int checkNum;
    
    inRandom = NO;
    modified = NO;
    
    if ([[fields objectAtIndex:5] isEqualToString:@"verbal"])
        theLevel = titrationVerbalLevel;
    
    if ([[fields objectAtIndex:5] isEqualToString:@"spatial"])
        theLevel = titrationSpatialLevel;
    
    for (int choiceCounter = 6;choiceCounter < [fields count];choiceCounter+=3){
        NSString * theChoice = [fields objectAtIndex:choiceCounter];
        if([theChoice length] >0)
            numOfChoices ++;
    }
    
    NSLog(@"NumOfChoices:  %i",numOfChoices);
    
    switch (numOfChoices) {
        case 1:
            
            checkNum = [[fields objectAtIndex:6] intValue];
            
            NSLog(@"CheckNum:  %i",checkNum);
            
            
            if (checkNum == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                NSLog(@"trying to change to %@",newInputFile);
                modified = YES;
            }
            
            break;
            
        case 2:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            break;
            
        case 3:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                
                modified = YES;
            }
            break;
            
        case 4:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:15] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:16];
                stringLineNumber = [fields objectAtIndex:17];
                
                modified = YES;
            }
            break;
            
        case 5:
            if ([[fields objectAtIndex:6] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:7];
                stringLineNumber = [fields objectAtIndex:8];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:9] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:10];
                stringLineNumber = [fields objectAtIndex:11];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:12] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:13];
                stringLineNumber = [fields objectAtIndex:14];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:15] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:16];
                stringLineNumber = [fields objectAtIndex:17];
                
                modified = YES;
            }
            if ([[fields objectAtIndex:18] intValue] == theLevel){
                newInputFile = [fields objectAtIndex:19];
                stringLineNumber = [fields objectAtIndex:20];
                modified = YES;
            }
            break;
            
        default:
            
            break;
            
    }
    
    branchLineNumber = [stringLineNumber intValue];
    
    if (modified){
        NSLog (@"lineNumber, (from titration branch):%i",branchLineNumber);    
        for (int stepThrough = 0; stepThrough < lengthQnsPths; stepThrough++){
            NSString * checkThis = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
            NSString * checkingString = [checkThis lastPathComponent];
            //NSLog(@"they are: %@ %@",newInputFile,checkingString);
            if ([checkingString isEqualToString: newInputFile]) {
                NSString * newInputFile2 = [appDelegate.allQnsAndPaths objectAtIndex:stepThrough];
                newInputFile = newInputFile2;
            }
        }
        
    }
    
    //NSLog(@"Did titrationBranch");
    
    //[NSThread sleepForTimeInterval:3];
    
    // Again, you can NOT call dismissModalViewController from here. Confusing errors will result.
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
