//
//  goodbye.m
//  engagement
//
//  Created by Thad Martin on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "goodbye.h"
#import <DropboxSDK/DropboxSDK.h>
#import "engagementAppDelegate.h"


@implementation goodbye
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
//    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
//    
//    NSString * theDocPath = delegate.docPath;
    
    
    
   // [NSThread sleepForTimeInterval:1];
    
//    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
//    [thisQuestionData uploadToDropBox:theDocPath];
    NSLog(@"this is where we upload");
    [NSThread sleepForTimeInterval:1]; 
    exit (0);
    

}


- (void) uploadToDropBox: (NSString *) filePath{
    
    //- (IBAction)linkButtonPressed:(id)sender {
    //    
    //    
    //    //if (![[DBSession sharedSession] isLinked]) {
    //    [[DBSession sharedSession] linkFromController:self];
    //    //} 
    //    //else 
    //    //    [[DBSession sharedSession] unlinkAll];
    //    NSLog(@"is linked.");
    //}
    //
   
//    
//    NSString *filename = [filePath lastPathComponent];
//    NSLog(@"filename,%@", filename);
//    NSLog(@"docPath %@", filePath);
//    
//    NSString *destDir = @"/";
//    
//   restClient =
//    [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    
    // restClient.delegate = newSlider ;
    
    
//    [restClient uploadFile:filename toPath:destDir
//             withParentRev:nil  fromPath:filePath];
    
    //[NSThread sleepForTimeInterval:6];
}

//- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
//              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
//    
//    NSLog(@"File uploaded successfully to path: %@", metadata.path);
//    //exit(0);
//}
//
//- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
//    NSLog(@"File upload failed with error - %@", error);
//}
//



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setExitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)leave:(id)sender {
    exit(0);
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath
              from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    //exit(0);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    NSLog(@"File upload failed with error - %@", error);
}


- (IBAction)uploadDropboxNow:(id)sender {
}


@end
