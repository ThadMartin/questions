//
//  engagementViewController.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementViewController.h"
#import "engagementAppDelegate.h"
#import "questionSelector.h"


@implementation engagementViewController {
    NSFileManager *filemgr;
    NSTimer * timer;
    DBRestClient * restClient;
    NSString * docPath;
    int uploadCount;
    int didUpload;
    BOOL uploading;
    BOOL downloading;
    int downloadCount;
    int toDownload;
    NSArray * filelist;
    engagementAppDelegate * appDelegate;
    NSMutableArray * onlyQns;
    int numInfiles;
    NSString * qListPath; 
    BOOL shouldDownload;
    NSMutableArray * unorderedQns;
    NSString * uploadDirectory;
    NSString * downloadDirectory;
    
    
}
@synthesize downloadDirLabel;
@synthesize downloadDirTxt;
@synthesize downloadDirChange;
@synthesize uploadDirLabel;
@synthesize uploadDirText;
@synthesize uploadDirChange;
@synthesize clearMemory;
@synthesize quitButton;
@synthesize linkLabel;
@synthesize errorLabel;
@synthesize uploadButton;
@synthesize downloadButton;
@synthesize continueButton;
@synthesize linkButton;
@synthesize unlinkButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

static NSInteger Compare(NSString * string1, NSString * string2, void *context) {
    NSString * string1Last = [string1 lastPathComponent]; 
    NSString * string2Last = [string2 lastPathComponent];
    
    return ([string1Last localizedCaseInsensitiveCompare:string2Last]);    
}

- (void)updateLinkStatus:(NSTimer*)timer2{
    if ([[DBSession sharedSession] isLinked]){
        //NSLog(@"says linked");
        NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
        
        if ( URLString != NULL ) { 
            linkLabel.text = @"app is linked to dropbox";
            uploadButton.enabled = TRUE;  
            uploadButton.opaque = FALSE;
            
            downloadButton.enabled = TRUE;
            downloadButton.opaque = FALSE;
            
            linkButton.enabled = FALSE;
            linkButton.opaque = TRUE;
            
            unlinkButton.enabled = TRUE;
            unlinkButton.opaque = FALSE;
            
        }
        else {
            linkLabel.text = @"no internet connection";
            uploadButton.enabled = FALSE; 
            uploadButton.opaque = TRUE;
            
            downloadButton.enabled = FALSE;
            downloadButton.opaque = TRUE;
            
            unlinkButton.enabled = FALSE;
            unlinkButton.opaque = TRUE;
            
            linkButton.enabled = FALSE;
            linkButton.opaque = TRUE;
            
        }  //still in if is linked.
        
        if (timer)
            [timer invalidate];
    }
    else
    {
        NSLog(@"not linked");
        
        linkLabel.text = @"app not linked to dropbox";
        
        uploadButton.enabled = NO; 
        uploadButton.opaque = YES;
        
        downloadButton.enabled = NO;
        downloadButton.opaque = YES;
        
        linkButton.enabled = TRUE;
        linkButton.opaque = FALSE;
        
        unlinkButton.enabled = FALSE;
        unlinkButton.opaque = TRUE;
        
    }
    
    if([appDelegate.allQnsAndPaths count]>0){
        continueButton.enabled = TRUE;
        continueButton.opaque = FALSE;
    }
    else{
        continueButton.enabled=NO;
        continueButton.opaque=YES;
    }
    
    quitButton.enabled = TRUE;
    quitButton.opaque = FALSE;
    
    if([appDelegate.allQnsAndPaths count] >0){
        clearMemory.enabled = TRUE;
        clearMemory.opaque = FALSE;
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.allQnsAndPaths = [[NSMutableArray alloc] init];	
    filemgr = [NSFileManager defaultManager];
    
    errorLabel.text=@"";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    qListPath = [paths objectAtIndex:0];
    
    NSError * error;
    
    filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:&error];
    
    if (error)
        errorLabel.text = error.localizedDescription;
    
    
    // to just show .ord files, modify the line below.  ***********************
    NSArray *extensions = [NSArray arrayWithObjects:@"txt", @"ord", nil];
    
    onlyQns = [[NSMutableArray alloc ] initWithArray:[filelist filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]]];
    
    numInfiles = [onlyQns count];
   
    NSMutableArray * onlyQnsPath = [[NSMutableArray alloc] init];
    
    for (NSString * thing in onlyQns)
        [onlyQnsPath addObject:[qListPath stringByAppendingPathComponent:thing]];
    
    [appDelegate.allQnsAndPaths addObjectsFromArray:onlyQnsPath];
    
    numInfiles = [onlyQnsPath count];
    
    NSLog(@"numInFiles: %i",numInfiles);
    
    NSString * initFileDownload = [qListPath stringByAppendingPathComponent:@"downloadDirectory"];
    NSString * initFileUpload = [qListPath stringByAppendingPathComponent:@"uploadDirectory"];
    
    NSData *downloadDirData = [NSData dataWithContentsOfFile:initFileDownload];
    NSData *uploadDirData = [NSData dataWithContentsOfFile:initFileUpload];
    
    downloadDirectory = [[NSString alloc] initWithData:downloadDirData encoding:NSUTF8StringEncoding];
    uploadDirectory = [[NSString alloc] initWithData:uploadDirData encoding:NSUTF8StringEncoding];
    
    NSString * uploadText = [NSString stringWithFormat: @"upload directory: %@",uploadDirectory];    
    uploadDirLabel.text = uploadText;

    NSString * downloadText = [NSString stringWithFormat: @"download directory: %@",downloadDirectory];    
    downloadDirLabel.text = downloadText;

    [self updateLinkStatus:timer];
    
    NSLog (@"updated link status");

}

- (void)viewDidUnload
{
    [self setLinkButton:nil];
    [self setUnlinkButton:nil];
    [self setContinueButton:nil];
    [self setLinkLabel:nil];
    [self setUploadButton:nil];
    [self setQuitButton:nil];
    [self setClearMemory:nil];
    [self setDownloadButton:nil];
    [self setErrorLabel:nil];
    [self setDownloadDirLabel:nil];
    [self setDownloadDirTxt:nil];
    [self setDownloadDirChange:nil];
    [self setUploadDirLabel:nil];
    [self setUploadDirText:nil];
    [self setUploadDirChange:nil];
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
    }
    
    linkLabel.text = @"";
    int timerTimeNumber = 3;
    timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(updateLinkStatus:) userInfo:nil repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    
    //[self updateLinkStatus:timer];  // This runs when the timer fires.
    
}


- (IBAction)unlinkButtonPressed:(id)sender {
    
    if ([[DBSession sharedSession] isLinked]) 
        [[DBSession sharedSession] unlinkAll];
    
    // Maybe here would be a good place to set restclient = nil?
    
    [NSThread sleepForTimeInterval:1]; 
    
    if (![[DBSession sharedSession] isLinked]){
        linkLabel.text = @"app not linked to dropbox";
    }
    [self updateLinkStatus:timer];
    
}


- (IBAction)continueButtonPressed:(id)sender {
    [timer invalidate];
    
    [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
}


- (IBAction)uploadButtonPressed:(id)sender {
    
    uploading = TRUE;
    downloading = FALSE;
    
    linkLabel.text = @"starting upload";
    
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    //uploadDirectory = @"/uploadNumberStims/";
    
    [restClient  loadMetadata:uploadDirectory];
    
    uploadButton.enabled = FALSE; 
    uploadButton.opaque = TRUE;
    
    continueButton.enabled = FALSE;
    continueButton.opaque = TRUE;
    
    downloadButton.enabled = FALSE;
    downloadButton.opaque = TRUE;
    
    unlinkButton.enabled = FALSE;
    unlinkButton.opaque = TRUE;
    
    [uploadButton setTitle:@"uploading" forState:UIControlStateNormal];
    
}


- (IBAction)quitPressed:(id)sender {
    
    // Delete the output file that doesn't have anything in it yet.
    
    NSError * error;
    engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
    docPath = delegate.docPath;
    
    [filemgr removeItemAtPath:docPath error:&error];
    if(error)
        NSLog(@"error: %@",error);
    
    exit(0);
}


- (IBAction)clearMemoryPressed:(id)sender {
    
    NSError * error;
    
    // Not removing the .ans files from here.
    NSArray *extensions = [NSArray arrayWithObjects:@"txt", @"ord", @"jpg", @"png", nil];
    
    NSArray * dirContents2 = [filemgr contentsOfDirectoryAtPath:qListPath error:nil];
    
    NSArray * onlyInputFiles = [dirContents2 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]];
    
    for ( NSString * thingPath in onlyInputFiles){
        NSString * fullThingPath = [qListPath stringByAppendingPathComponent:thingPath];
        [filemgr removeItemAtPath:fullThingPath error:&error];
        if(error){
            NSLog(@"error: %@",error);
            errorLabel.text = error.localizedDescription;
    }
    }
    
    [appDelegate.allQnsAndPaths removeAllObjects];
    
    [clearMemory setTitle:@"cleared" forState:UIControlStateNormal];
    downloadButton.enabled = TRUE;
    downloadButton.opaque = FALSE;
    
    continueButton.enabled = FALSE;
    continueButton.opaque = TRUE;
    
    [downloadButton setTitle:@"download questions" forState:UIControlStateNormal];
    
}


- (IBAction)downloadButtonPressed:(id)sender {
    
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    linkLabel.text = @"starting download";
    
    uploading = FALSE;
    downloading = TRUE;
    
    uploadButton.enabled = FALSE;
    uploadButton.opaque = TRUE;
    
    downloadButton.enabled = FALSE;
    downloadButton.opaque = TRUE;
    
    unlinkButton.enabled = FALSE;
    unlinkButton.opaque = TRUE;
    
    continueButton.enabled = FALSE;
    continueButton.opaque = TRUE;
    
    clearMemory.enabled = FALSE;
    clearMemory.opaque = TRUE;
    
    [downloadButton setTitle:@"downloading" forState:UIControlStateNormal];
    
    //downloadDirectory = @"/downloadNumberStims/";

    unorderedQns = [[NSMutableArray alloc] init];
        
    [restClient loadMetadata:downloadDirectory];
    
    //NSLog(@"I told it to download");    
    
}

- (IBAction)uploadDirChangePressed:(id)sender {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    uploadDirectory = @"/";
    uploadDirectory = [uploadDirectory stringByAppendingString: uploadDirText.text];
    
    NSString * uploadText = [NSString stringWithFormat: @"upload directory: %@",uploadDirectory];    
    uploadDirLabel.text = uploadText;
    
    [restClient createFolder:uploadDirectory];
    
    NSError * error;
    
    NSString * uploadDirPath = [qListPath stringByAppendingPathComponent:@"uploadDirectory"];
    
    [uploadDirectory writeToFile:uploadDirPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"error: %@",error);

    
}

- (IBAction)downloadDirChangePressed:(id)sender {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
//    NSMutableArray* newDownloadPath = [NSMutableArray new];
//    
//    for (DBMetadata* child in metadata.contents) {
//        
//        [newPhotoPaths addObject:child.path];
//        
//    }
    
    downloadDirectory = [NSString stringWithFormat:@"/%@",downloadDirTxt.text];
    //downloadDirectory = downloadDirTxt.text;
    NSString * downloadText = [NSString stringWithFormat: @"download directory: %@",downloadDirectory];    
    downloadDirLabel.text = downloadText;
    
    NSError * error;
    
    NSString * downloadDirPath = [qListPath stringByAppendingPathComponent:@"downloadDirectory"];
    
    [downloadDirectory writeToFile:downloadDirPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"error: %@",error);

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return (YES);
}


- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    
    NSLog(@"loaded metadata");
    
    if (uploading){
        uploadCount = 0;
        didUpload = 0;
        
        //NSString * directory = @"/upload/";  //Well, it should be.
        
        NSArray *extensions = [NSArray arrayWithObjects:@"ans",nil];
        
        NSMutableArray * answerFiles = [[NSMutableArray alloc]initWithArray:[filelist filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]]]; 
                
        NSLog(@"answerFiles %@",answerFiles);
        NSLog(@"metadata contents %@",metadata.contents);
        
        if ([answerFiles count]>0){
            
            for(NSString *existing in answerFiles){  
                bool shouldUpload = true;
                
                for (DBMetadata *file in metadata.contents) {
                    if([existing isEqualToString:file.filename]){  //Don't upload anything that's already there.
                        shouldUpload = false;
                        // NSLog(@"don't upload this one");
                        break;
                    }
                    
                }  // end of step through metadata contents
                
                if(shouldUpload){
                    uploadCount++;
                    NSString * filePathName = [qListPath stringByAppendingPathComponent:existing];
                    
                    [restClient uploadFile:existing toPath:uploadDirectory withParentRev:nil  fromPath:filePathName];
                }  // end of if should upload
                
                if (uploadCount ==0){
                    [uploadButton setTitle:@"done preparing uploads" forState:UIControlStateNormal];
                    
                    [self updateLinkStatus:timer];
                    
                }
            }  // end of step through 
        }
        else{
            [uploadButton setTitle:@"nothing to upload" forState:UIControlStateNormal];
            [self updateLinkStatus:timer];   
        }
    }// end of if uploading.
    
    if (downloading){
        NSLog(@"downloading...");
        
        linkLabel.text = @"downloading";
        
        //NSString * directory = @"/download/";  //again, it should be.
        
        NSError * error;
        
        filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:&error];
        
        if (error)
            errorLabel.text = error.localizedDescription;
        
        downloadCount = 0;
        //newQuestions = [[NSMutableArray alloc] init];
        if (metadata.isDirectory) {
            for (DBMetadata *file in metadata.contents) {
                shouldDownload = TRUE;
                for(NSString *existing in filelist){
                    if([existing isEqualToString:file.filename]){
                        shouldDownload = FALSE;       // Don't re-download files already on iPad.
                        break;
                    }
                    if(file.isDirectory){  // Don't download directories.
                        shouldDownload = FALSE;
                        break;
                    }
                }
                
                if(shouldDownload){
                    
                    linkLabel.text = @"should download";
                    
                    downloadCount++;
                    
                    //NSString * dropboxPath = [downloadDirectory stringByAppendingString:@"/"];
                    
                    NSString * dropboxPath = [downloadDirectory stringByAppendingPathComponent:file.filename];
                    
                    NSString * localPath = [qListPath stringByAppendingPathComponent:file.filename];
                    // NSLog(@"local path: %@",localPath);
                    
                    NSLog(@"should download: %d",shouldDownload);
                    NSLog(@"filename %@",file.filename);
                    
                    
                    [restClient loadFile:dropboxPath intoPath:localPath];
                }
            }// download all infiles that aren't already on the iPad.
        }//if not a directory, in wrong place.
        
        toDownload = downloadCount;
        
        if(downloadCount == 0){
            
            [downloadButton setTitle:@"done downloading" forState:UIControlStateNormal];
            [clearMemory setTitle:@"clear downloads" forState:UIControlStateNormal];
            
            NSArray * sortedArray = [unorderedQns sortedArrayUsingFunction:Compare context:nil];
            [appDelegate.allQnsAndPaths addObjectsFromArray:sortedArray];
            
            [clearMemory setTitle:@"clear downloads" forState:UIControlStateNormal];
            
            [self updateLinkStatus:timer];
            
        }
    }//end of if downloading.
}



- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
    
    errorLabel.text = error.localizedDescription;
    
    //[[DBSession sharedSession] unlinkAll]; 
    
    [NSThread sleepForTimeInterval:1];   //Try again. Maybe it would be better to unlink and relink.
    
    [restClient loadMetadata:downloadDirectory];  
}


- (void)restClient:(DBRestClient*)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath {
    //NSLog(@"Uploaded from %@",srcPath);
    didUpload ++;
    
    linkLabel.text = @"uploaded a file";
    
    NSError * error;
    
    [filemgr removeItemAtPath:srcPath error:&error];
    
    if(error){
        NSLog(@"error: %@",error);
        errorLabel.text = error.localizedDescription;
    }
    
    NSString * buttonText = [NSString stringWithFormat:@"uploaded %i of %i",didUpload,uploadCount];
    
    [uploadButton setTitle:buttonText forState:UIControlStateNormal];
    
    if (didUpload >= uploadCount){
        
        [uploadButton setTitle:@"done uploading" forState:UIControlStateNormal];
        [self updateLinkStatus:timer];
        
    }
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError *)error{
    NSLog(@"Upload error - %@", error);
    
    linkLabel.text = @"retrying";
    
    if (didUpload >= uploadCount)
        [uploadButton setTitle:@"upload complete" forState:UIControlStateNormal];
    
    NSLog(@"from %@",error.userInfo.description);
    
    NSString * reloadSourcePath;
    NSString * reloadDestinationPath;
    //NSString * destDir = @"/uploadNumberStims/";
    
    for (id key in error.userInfo){
        NSLog(@"key, %@",key);
        NSLog(@"object, %@",[error.userInfo objectForKey:key]);
        if ([key isEqualToString:@"sourcePath"])
            reloadSourcePath = [error.userInfo objectForKey:key];
        
        if ([key isEqualToString:@"destinationPath"])
            reloadDestinationPath = [error.userInfo objectForKey:key];
    }
    
    if ([reloadSourcePath length]>1 && [reloadDestinationPath length] > 1){
        [restClient uploadFile:[reloadSourcePath lastPathComponent] toPath:uploadDirectory withParentRev:nil  fromPath:reloadSourcePath];
        NSLog(@"re-upload trying");
    }
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath {
    //downloaded...
    //NSLog(@"File loaded into path: %@", localPath);
    
    linkLabel.text = @"downloaded a file";
    
    NSString * buttonText = [NSString stringWithFormat:@"downloaded %i of %i",(toDownload - (downloadCount+1)),toDownload];
    
    [downloadButton setTitle:buttonText forState:UIControlStateNormal];
    
    NSString *filename = [localPath lastPathComponent];
    NSString * filenamePath = [qListPath stringByAppendingPathComponent:filename];
    NSArray *components = [filename componentsSeparatedByString:@"."];
    //NSLog(@"file extension, %@", [components objectAtIndex:1]);
    
    if ([[components objectAtIndex:1] isEqualToString:@"txt"]||[[components objectAtIndex:1] isEqualToString:@"ord"]) {
        [unorderedQns addObject:filenamePath];
    }
    
    //NSLog(@"%@",unorderedQns);
    
    downloadCount--;
    if(downloadCount == 0){
        
        [downloadButton setTitle:@"done downloading" forState:UIControlStateNormal];
        
        
        
        NSArray * sortedArray = [unorderedQns sortedArrayUsingFunction:Compare context:nil];
        [appDelegate.allQnsAndPaths addObjectsFromArray:sortedArray];
        
        [clearMemory setTitle:@"clear downloaded questions" forState:UIControlStateNormal];
        
        [self updateLinkStatus:timer];
        
        downloadButton.enabled = FALSE;
        downloadButton.opaque = TRUE;
        
        clearMemory.enabled = TRUE;
        clearMemory.opaque = FALSE;
        
        unlinkButton.enabled = TRUE;
        unlinkButton.opaque = FALSE;
        
        uploadButton.enabled = TRUE;
        uploadButton.opaque = FALSE;
        
        if([appDelegate.allQnsAndPaths count]>0){
            continueButton.enabled = TRUE;
            continueButton.opaque = FALSE;
        }
    }
}


- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    NSLog(@"There was an error loading the file - %@", error);    
    NSLog(@"from %@",error.userInfo.description);
    
    NSString * reloadPath;
    NSString * reloadDestinationPath;
    
    linkLabel.text = @"retrying";
    
    for (id key in error.userInfo){
        NSLog(@"key, %@",key);
        NSLog(@"object, %@",[error.userInfo objectForKey:key]);
        if ([key isEqualToString:@"path"]){
            reloadPath = [error.userInfo objectForKey:key];
        }
        if ([key isEqualToString:@"destinationPath"])
            reloadDestinationPath = [error.userInfo objectForKey:key];        
    }
    
    
    if ([reloadPath length]>1 && [reloadDestinationPath length] > 1){
        [restClient loadFile:reloadDestinationPath intoPath:reloadPath];
        NSLog(@"re-download trying");
    }
}


- (void)restClient:(DBRestClient*)client createdFolder:(DBMetadata*)folder{
    NSLog(@"Created Folder Path %@",folder.path);
    NSLog(@"Created Folder name %@",folder.filename);
}
// [error userInfo] contains the root and path
- (void)restClient:(DBRestClient*)client createFolderFailedWithError:(NSError*)error{
    NSLog(@"%@",error);
}



@end

