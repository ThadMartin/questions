//
//  engagementViewController.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementViewController.h"
#import "engagementAppDelegate.h"


@implementation engagementViewController {
    NSFileManager *filemgr;
    NSTimer * timer;
    DBRestClient * restClient;
    NSString * docPath;
    int uploadCount;
    int didUpload;
    
}
@synthesize quitButton;

@synthesize linkLabel;
@synthesize uploadButton;
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
        NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
        
        if ( URLString != NULL )      
            linkLabel.text = @"app is linked to dropbox";
        else{
            linkLabel.text = @"no internet connection";
            uploadButton.enabled = NO;  
            uploadButton.opaque = YES;
        }            
    }
    else{
        linkLabel.text = @"app not linked to dropbox";
        uploadButton.enabled = NO;
        uploadButton.opaque = YES;
    }
}

- (void)viewDidUnload
{
    [self setLinkButton:nil];
    [self setUnlinkButton:nil];
    [self setContinueButton:nil];
    [self setLinkLabel:nil];
    [self setUploadButton:nil];
    [self setQuitButton:nil];
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
    
    //  if ([[DBSession sharedSession] isLinked])
    //      [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)updateLinkStatus:(NSTimer*)timer2{
    if ([[DBSession sharedSession] isLinked]){
        linkLabel.text = @"app linked to dropbox";
        uploadButton.enabled = YES;  
        uploadButton.opaque = NO;
        [timer invalidate];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return NO;   
    else
        return YES;
}


- (IBAction)linkButtonPressed:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
        
        //[NSThread sleepForTimeInterval:1]; 
        
        linkLabel.text = @"";
        int timerTimeNumber = 3;
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(updateLinkStatus:) userInfo:nil repeats:YES];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
    else {
        linkLabel.text = @"app is linked to dropbox";
        uploadButton.enabled = YES; 
        uploadButton.opaque = NO;

    }
}


- (IBAction)unlinkButtonPressed:(id)sender {
    if ([[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] unlinkAll];
        
        [NSThread sleepForTimeInterval:1]; 
        
        if (![[DBSession sharedSession] isLinked]){
            linkLabel.text = @"app not linked to dropbox";
            uploadButton.enabled = NO; 
            uploadButton.opaque = YES;

        }
    }
    
}

- (IBAction)continueButtonPressed:(id)sender {
    [timer invalidate];
    [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
}


- (IBAction)uploadButtonPressed:(id)sender {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    [ restClient loadMetadata:@"/upload/"];
    
    
}

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    uploadCount = 0;
    didUpload = 0;
    
    filemgr = [NSFileManager defaultManager];
    
    
    NSString *destDir = @"/upload/";
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * qListPath2 = [paths objectAtIndex:0];
    
    NSArray * filelist2= [filemgr contentsOfDirectoryAtPath:qListPath2 error:nil];
    
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.ans'"];
    
    NSMutableArray * answerFiles = [[NSMutableArray alloc] initWithArray:[filelist2 filteredArrayUsingPredicate:fltr]];
    
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    
    docPath = delegate.docPath;
    
    NSString * currentDoc = [docPath lastPathComponent];
    
    for(NSString *existing in answerFiles){
        
        bool shouldUpload = true;
        for (DBMetadata *file in metadata.contents) {
            // NSLog(@" existing, file.filename: %@ , %@",existing,file.filename);
            if([existing isEqualToString:file.filename]||[existing isEqualToString:currentDoc]){
                shouldUpload = false;
                NSLog(@"don't upload this one");
                break;
            }
            
        }  // end of step through metadata contents
        
        if(shouldUpload){
            uploadCount++;
            NSString * filePathName = [qListPath2 stringByAppendingPathComponent:existing];
            
            [restClient uploadFile:existing toPath:destDir withParentRev:nil  fromPath:filePathName];
        }  // end of if should upload
        
    }  // end of step through 
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath {
    //NSLog(@"Uploaded from %@",srcPath);
    didUpload ++;
    
    NSError * error;
    
    [filemgr removeItemAtPath:srcPath error:&error];
    
    if(error)
        NSLog(@"error: %@",error);
    
    if (didUpload >= uploadCount)
        [uploadButton setTitle:@"upload complete" forState:UIControlStateNormal];
    

    
}

- (IBAction)quitPressed:(id)sender {
    
    NSError * error;
    
    [filemgr removeItemAtPath:docPath error:&error];
    
    if(error)
        NSLog(@"error: %@",error);
    
    exit(0);
}
@end



