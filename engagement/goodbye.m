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


@implementation goodbye{
    DBRestClient * restClient;
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
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    NSString * theDocPath = delegate.docPath;
    NSLog(@"uploading...");
    [self uploadToDropbox:theDocPath];
    
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
    [NSThread sleepForTimeInterval:3]; //give dropbox a sec to upload.
    exit(0);
}

-(void)uploadToDropbox:(NSString *)docPath {
    
    if ([[DBSession sharedSession] isLinked]) {
        
        NSLog(@"Still linked.");
        NSString *destDir = @"/upload/";
        
        if (!restClient) {
            
            restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        }
        
        NSString * filename = [docPath lastPathComponent]; 
        
        restClient.delegate = self;
        
        [restClient uploadFile:filename toPath:destDir withParentRev:nil  fromPath:docPath];
        
    }
    else{
        NSLog(@"Perhaps not linked.");
    }
    
}    


- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    NSLog(@"File upload failed with error - %@", error);
}



@end
