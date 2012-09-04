//
//  questionSelector.m
//  engagement
//
//  Created by Thad Martin on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//  selects the questionnaire to use.

#import "questionSelector.h"
#import "questionParser.h"
#import "engagementAppDelegate.h"


@implementation questionSelector{
    engagementAppDelegate * appDelegate;
    NSMutableArray * onlyQns;
    NSMutableArray * onlyQns2;
    int numInfiles;
    int numInfiles2;
    NSMutableArray * newQuestions;
    NSString * qListPath; 
    NSString * qListPath2;
    DBRestClient * restClient;
    int downloadCount;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.allQnsAndPaths = [[NSMutableArray alloc] init];	
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    qListPath = [[NSBundle mainBundle] bundlePath];
    NSArray *filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.txt'"];

    onlyQns = [[NSMutableArray alloc] initWithArray:[filelist filteredArrayUsingPredicate:fltr]];

    filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:nil];
    
    numInfiles = [onlyQns count];
        
    //it used to strip of the .txt entension in this loop.
    for (int noTxt = 0; noTxt < numInfiles; noTxt++){               
        NSString * firstName = [onlyQns objectAtIndex:noTxt];
        NSLog(@"firstName %@",firstName);
        NSString * fullQuestion = [qListPath stringByAppendingPathComponent:firstName];
        [appDelegate.allQnsAndPaths addObject:fullQuestion];
        
    }
    
    //          previously downloaded files, things ending with a 2.
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    qListPath2 = [paths objectAtIndex:0];
     
    NSLog(@"qlsitpath2: %@",qListPath2);
    
    NSArray * filelist2= [filemgr contentsOfDirectoryAtPath:qListPath2 error:nil];
    onlyQns2 = [[NSMutableArray alloc] initWithArray:[filelist2 filteredArrayUsingPredicate:fltr]];
    numInfiles2 = [onlyQns2 count];
    
    NSLog(@"numInFiles2: %i",numInfiles2);
    
    for (int noTxt = numInfiles; noTxt < (numInfiles + numInfiles2); noTxt++){
        NSString * firstName = [onlyQns2 objectAtIndex:noTxt-numInfiles];
        NSString * fullQuestion = [qListPath2 stringByAppendingPathComponent:firstName];
        [appDelegate.allQnsAndPaths addObject:fullQuestion];
        [onlyQns addObject: [onlyQns2 objectAtIndex:noTxt-numInfiles]];
        
    }
    
    NSLog (@"NumberOfFiles is %i",numInfiles);
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)]; 
    footer.backgroundColor = [UIColor clearColor];   //footer makes table stop when it should.
    [self.tableView setTableFooterView:footer];
    
}

- (void)viewDidUnload
{
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
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
   
    NSString * directory = @"/download/";
    
    [restClient loadMetadata:directory];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([onlyQns count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[onlyQns objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    infile = [appDelegate.allQnsAndPaths objectAtIndex:indexPath.row];
    
    NSLog(@"Selected for input:%@",infile);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [self performSegueWithIdentifier: @"toQuestionParser" sender: self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"toQuestionParser"]){
        questionParser * svc = [segue destinationViewController];
        svc.infile = infile; 
    } 
}

- (void)insertNewTableRows:(NSArray *)newFiles{
    
}

#pragma mark - Dropbox methods


- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata{
    downloadCount = 0;
    newQuestions = [[NSMutableArray alloc] init];
    if (metadata.isDirectory) {
        for (DBMetadata *file in metadata.contents) {
            bool shouldDownload = true;
            for(NSString *existing in onlyQns){
                if([existing isEqualToString:file.filename]){
                    shouldDownload = true;       // changed to true, so if you modify a file, you can get the new version.
                    break;
                }
            }
            if(shouldDownload){
                downloadCount++;
                NSString * dropboxPath = [@"/download/" stringByAppendingString:file.filename];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];

                NSString * localPath = [documentsDirectory stringByAppendingPathComponent:file.filename];
               // NSLog(@"local path: %@",localPath);
                [restClient loadFile:dropboxPath intoPath:localPath];
            }
        }// download all infiles that aren't already on the iPad.
    }//if not a directory, in wrong place.
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath {
    NSLog(@"File loaded into path: %@", localPath);
    
    NSString *filename = [localPath lastPathComponent];
    NSArray *components = [filename componentsSeparatedByString:@"."];
    NSLog(@"file extension, %@", [components objectAtIndex:1]);
    
    //if the extension is ok add it to the new files array to be added to the table later
    NSLog(@" %@ = txt",[components objectAtIndex:1] );
    if ([[components objectAtIndex:1] isEqualToString:@"txt"]) {
        [newQuestions addObject:filename];
        [appDelegate.allQnsAndPaths addObject:localPath];
    }
    downloadCount--;
    if(downloadCount == 0){
        [self addNewQuestionsToTable];
    }
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    NSLog(@"There was an error loading the file - %@", error);
    downloadCount--;
    if(downloadCount == 0){
        [self addNewQuestionsToTable];
    }
}

- (void)addNewQuestionsToTable{
    UITableView *table = (UITableView *) self.view;
    [table beginUpdates];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for(NSString *filename in newQuestions){
        [onlyQns addObject:filename];
        [indexPaths addObject:[NSIndexPath indexPathForRow:numInfiles inSection:0]];
        numInfiles++;
    }
    [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    [table endUpdates];
    //[table reloadRowsAtIndexPaths:[table indexPathsForVisibleRows] 
    //                 withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}

@end