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
    NSMutableArray * filelist;
    NSArray * filelist2;
    NSMutableArray * filelist3;
    NSMutableArray * newQuestions;
    engagementAppDelegate * appDelegate;
    NSMutableArray * onlyQns;
    NSMutableArray * onlyQns2;
    int numInfiles;
    int numInfiles2;
    NSString * qListPath; 
    NSString * qListPath2;
    BOOL shouldDownload;
    
    
}
@synthesize clearMemory;
@synthesize quitButton;
@synthesize linkLabel;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.allQnsAndPaths = [[NSMutableArray alloc] init];	
    filemgr = [NSFileManager defaultManager];
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
    
    
    // It is possible to include files in the bundle path, and compile them in.  
    // I'll remove that sometime.
    
    qListPath = [[NSBundle mainBundle] bundlePath];
    
    [filelist addObjectsFromArray:[filemgr contentsOfDirectoryAtPath:qListPath error:nil]];
    
    // to just show .ord files, modify the line below.  ***********************
    NSArray *extensions = [NSArray arrayWithObjects:@"txt", @"ord", nil];
    onlyQns = [[NSMutableArray alloc ] initWithArray:[filelist filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]]];
    
    
    numInfiles = [onlyQns count];
    
    //used to strip off the .txt entension in this loop.
    for (int noTxt = 0; noTxt < numInfiles; noTxt++){               
        NSString * firstName = [onlyQns objectAtIndex:noTxt];
        //NSLog(@"firstName %@",firstName);
        NSString * fullQuestion = [qListPath stringByAppendingPathComponent:firstName];
        [appDelegate.allQnsAndPaths addObject:fullQuestion];
        
    }
    
    //          previously downloaded files, things ending with a 2.
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    qListPath2 = [paths objectAtIndex:0];
    
    //NSLog(@"qlsitpath2: %@",qListPath2);
    
    filelist2= [filemgr contentsOfDirectoryAtPath:qListPath2 error:nil];
    
    NSLog(@"qlsitpath2: %@",filelist2);
    onlyQns2 = [[NSMutableArray alloc ] initWithArray:[filelist2 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]]];
    
    numInfiles2 = [onlyQns2 count];
    
    NSLog(@"numInFiles2: %i",numInfiles2);
    
    for (int noTxt = numInfiles; noTxt < (numInfiles + numInfiles2); noTxt++){
        NSString * firstName = [onlyQns2 objectAtIndex:noTxt-numInfiles];
        NSString * fullQuestion = [qListPath2 stringByAppendingPathComponent:firstName];
        [appDelegate.allQnsAndPaths addObject:fullQuestion];
        [onlyQns addObject: [onlyQns2 objectAtIndex:noTxt-numInfiles]];
        
    }
    
    NSLog (@"NumberOfFiles is %i",numInfiles);
    
    filelist3 = [[NSMutableArray alloc] initWithArray:filelist];
    
    [filelist3 addObjectsFromArray:filelist2];  // So, all the files.
    
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
        
        NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
        
        if ( URLString != NULL ) { 
           // NSLog(@"download button changed here.");
            linkLabel.text = @"app is linked to dropbox";
            uploadButton.enabled = TRUE;  
            uploadButton.opaque = FALSE;
            
            downloadButton.enabled = TRUE;
            downloadButton.opaque = FALSE;
            
        }
        else {
            linkLabel.text = @"no internet connection";
            uploadButton.enabled = FALSE; 
            uploadButton.opaque = TRUE;
            
            downloadButton.enabled = FALSE;
            downloadButton.opaque = TRUE;
        }
        
        [timer invalidate];
    }
    else
    {
        linkLabel.text = @"app not linked to dropbox";
        uploadButton.enabled = NO; 
        uploadButton.opaque = YES;
        
        downloadButton.enabled = NO;
        downloadButton.opaque = YES;
        
        
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
        uploadButton.enabled = TRUE; 
        uploadButton.opaque = FALSE;
        downloadButton.enabled = TRUE;
        downloadButton.opaque = FALSE;
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
            
            downloadButton.enabled = NO;
            downloadButton.opaque = YES;
            
        }
    }
    
}

- (IBAction)continueButtonPressed:(id)sender {
    [timer invalidate];
    [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
}


- (IBAction)uploadButtonPressed:(id)sender {
    uploading = TRUE;
    downloading = FALSE;
    
    
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    [restClient loadMetadata:@"/uploadNumberStims/"];
    
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
    
    // filemgr = [NSFileManager defaultManager];
    
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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docDir = [paths objectAtIndex:0];
    NSArray * dirContents2 = [filemgr contentsOfDirectoryAtPath:docDir error:nil];
    
    NSLog(@"docDir: %@",docDir);
    NSLog(@"dir contents: %@",dirContents2);
    NSArray * onlyTXTs = [dirContents2 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", extensions]];
    
    for ( NSString * thingPath in onlyTXTs){
        NSString * fullThingPath = [docDir stringByAppendingPathComponent:thingPath];
        [filemgr removeItemAtPath:fullThingPath error:&error];
        if(error)
            NSLog(@"error: %@",error);
    }
    
    [clearMemory setTitle:@"cleared" forState:UIControlStateNormal];
    downloadButton.enabled = TRUE;
    downloadButton.opaque = FALSE;
    
    continueButton.enabled = FALSE;
    continueButton.opaque = TRUE;
    
    [downloadButton setTitle:@"download questions" forState:UIControlStateNormal];
    
}


- (IBAction)downloadButtonPressed:(id)sender {
    
    [downloadButton setTitle:@"downloading" forState:UIControlStateNormal];
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    }
    restClient.delegate = self;
    
    [filelist addObjectsFromArray:[filemgr contentsOfDirectoryAtPath:qListPath error:nil]];
    filelist3 = [[NSMutableArray alloc] initWithArray:filelist];
    filelist2= [filemgr contentsOfDirectoryAtPath:qListPath2 error:nil];
    
    [filelist3 addObjectsFromArray:filelist2];
    
    
    uploading = FALSE;
    downloading = TRUE;
    
    uploadButton.enabled = FALSE;
    uploadButton.opaque = TRUE;
    
    unlinkButton.enabled = FALSE;
    unlinkButton.opaque = TRUE;
    
    continueButton.enabled = FALSE;
    continueButton.opaque = TRUE;
    
    NSString * directory = @"/downloadNumberStims/";
    
    [restClient loadMetadata:directory];
    
    NSLog(@"I told it to download");
    
}


- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    
    NSLog(@"loaded metadata");
    
    if (uploading){
        uploadCount = 0;
        didUpload = 0;
        
        //filemgr = [NSFileManager defaultManager];
        
        
        NSString *destDir = @"/uploadNumberStims/";
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        qListPath2 = [paths objectAtIndex:0];
        
        //NSArray * filelist2= [filemgr contentsOfDirectoryAtPath:qListPath2 error:nil];
        
        NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.ans'"];
        
        NSMutableArray * answerFiles = [[NSMutableArray alloc] initWithArray:[filelist2 filteredArrayUsingPredicate:fltr]];
        
        engagementAppDelegate *delegate = (engagementAppDelegate *) [[UIApplication sharedApplication]delegate];
        
        
        docPath = delegate.docPath;
        
        NSString * currentDoc = [docPath lastPathComponent];
        
        NSLog(@"currentDoc %@",currentDoc);
        NSLog(@"answerFiles %@",answerFiles);
        NSLog(@"metadata contents %@",metadata.contents);
        
        
        
        // for(NSString *existing in filelist2){
        for(NSString *existing in answerFiles){  
            bool shouldUpload = true;
            
            if ([existing isEqualToString:currentDoc])
                shouldUpload = false;
            
            for (DBMetadata *file in metadata.contents) {
                // NSLog(@" existing, file.filename: %@ , %@",existing,file.filename);
                if([existing isEqualToString:file.filename]){
                    shouldUpload = false;
                    // NSLog(@"don't upload this one");
                    break;
                }
                
            }  // end of step through metadata contents
            
            if(shouldUpload){
                uploadCount++;
                NSString * filePathName = [qListPath2 stringByAppendingPathComponent:existing];
                
                [restClient uploadFile:existing toPath:destDir withParentRev:nil  fromPath:filePathName];
            }  // end of if should upload
            
            if (uploadCount ==0){
                [uploadButton setTitle:@"done uploading" forState:UIControlStateNormal];
                
                [self updateLinkStatus:timer];
                
                downloadButton.enabled = TRUE;
                downloadButton.opaque = FALSE;
                
                clearMemory.enabled = TRUE;
                clearMemory.opaque = FALSE;
                
                unlinkButton.enabled = TRUE;
                unlinkButton.opaque = FALSE;
                
                uploadButton.enabled = FALSE;
                uploadButton.opaque = TRUE;
                
                if([appDelegate.allQnsAndPaths count]>0){
                    continueButton.enabled = TRUE;
                    continueButton.opaque = FALSE;
                }
             }
         }  // end of step through 
    }// end of if uploading.
    
    if (downloading){
        //download code here.
        
        NSLog(@"downloading");
        
        linkLabel.text = @"downloading";
        
        
        NSLog(@"filelist 3: %@",filelist3);
        
        downloadCount = 0;
        newQuestions = [[NSMutableArray alloc] init];
        if (metadata.isDirectory) {
            for (DBMetadata *file in metadata.contents) {
                shouldDownload = TRUE;
                for(NSString *existing in filelist3){
                    // NSLog(@"existing, file.filename %@ %@",existing,file.filename);
                    
                    if([existing isEqualToString:file.filename]){
                        shouldDownload = FALSE;       // can be changed to true, so if you modify a file, you get the new version.
                        break;
                    }
                    if(file.isDirectory){
                        shouldDownload = FALSE;
                        break;
                    }
                }
                
                if(shouldDownload){
                    
                    linkLabel.text = @"should download";
                    
                    downloadCount++;
                    NSString * dropboxPath = [@"/downloadNumberStims/" stringByAppendingString:file.filename];
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    
                    NSString * localPath = [documentsDirectory stringByAppendingPathComponent:file.filename];
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
            
        }
        
    }//end of if downloading.
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
    [[DBSession sharedSession] unlinkAll]; 
    restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    restClient.delegate = self;
}


- (void)restClient:(DBRestClient*)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath {
    //NSLog(@"Uploaded from %@",srcPath);
    didUpload ++;
    
    NSError * error;
    
    [filemgr removeItemAtPath:srcPath error:&error];
    
    if(error)
        NSLog(@"error: %@",error);
    
    NSString * buttonText = [NSString stringWithFormat:@"uploaded %i of %i",didUpload,uploadCount];
    
    [uploadButton setTitle:buttonText forState:UIControlStateNormal];
    
    if (didUpload >= uploadCount){
        
        [uploadButton setTitle:@"done uploading" forState:UIControlStateNormal];
        
        [self updateLinkStatus:timer];
        
        downloadButton.enabled = TRUE;
        downloadButton.opaque = FALSE;
        
        clearMemory.enabled = TRUE;
        clearMemory.opaque = FALSE;
        
        unlinkButton.enabled = TRUE;
        unlinkButton.opaque = FALSE;
        
        uploadButton.enabled = FALSE;
        uploadButton.opaque = TRUE;
        
        if([appDelegate.allQnsAndPaths count]>0){
            continueButton.enabled = TRUE;
            continueButton.opaque = FALSE;
        }
    }
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError *)error{
    NSLog(@"Upload error - %@", error);
    
    if (didUpload >= uploadCount)
        [uploadButton setTitle:@"upload complete" forState:UIControlStateNormal];
    
    
    NSLog(@"from %@",error.userInfo.description);
    
    NSString * reloadSourcePath;
    NSString * reloadDestinationPath;
    NSString *destDir = @"/uploadNumberStims/";
    
    for (id key in error.userInfo){
        NSLog(@"key, %@",key);
        NSLog(@"object, %@",[error.userInfo objectForKey:key]);
        if ([key isEqualToString:@"sourcePath"])
            reloadSourcePath = [error.userInfo objectForKey:key];
        
        if ([key isEqualToString:@"destinationPath"])
            reloadDestinationPath = [error.userInfo objectForKey:key];
    }
    
    
    if ([reloadSourcePath length]>1 && [reloadDestinationPath length] > 1){
        [restClient uploadFile:[reloadSourcePath lastPathComponent] toPath:destDir withParentRev:nil  fromPath:reloadSourcePath];
        NSLog(@"re-upload trying");
    }
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath {
    //downloaded...
    //NSLog(@"File loaded into path: %@", localPath);
    
    linkLabel.text = @"downloaded a file";
    
    
    NSString * buttonText = [NSString stringWithFormat:@"downloaded %i of %i",(toDownload - (downloadCount+1)),toDownload];
    
    [downloadButton setTitle:buttonText forState:UIControlStateNormal];
    
    
    //[downloadButton setTitle:@"downloaded %i of %i" forState:UIControlStateNormal];
    NSString *filename = [localPath lastPathComponent];
    NSArray *components = [filename componentsSeparatedByString:@"."];
    //NSLog(@"file extension, %@", [components objectAtIndex:1]);
    
    //if the extension is ok add it to the new files array to be added to the table later
    //NSLog(@" %@ = txt",[components objectAtIndex:1] );
    if ([[components objectAtIndex:1] isEqualToString:@"txt"]||[[components objectAtIndex:1] isEqualToString:@"ord"]) {
        [newQuestions addObject:filename];
        [appDelegate.allQnsAndPaths addObject:localPath];
    }
    downloadCount--;
    if(downloadCount == 0){
        
        [downloadButton setTitle:@"done downloading" forState:UIControlStateNormal];
        
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


@end



