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
    NSMutableArray * onlyQns;
    int numInfiles;
    NSMutableArray * onlyQnsNoTxt;
    NSMutableArray * newQuestions;
    NSMutableArray * allQnsAndPaths;
    NSString * qListPath; 
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    qListPath = [[NSBundle mainBundle] bundlePath];
    NSArray *filelist= [filemgr contentsOfDirectoryAtPath:qListPath error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.txt'"];
    //In that directory, there weren't any other .txt files.
    
    onlyQns = [[NSMutableArray alloc] initWithArray:[filelist filteredArrayUsingPredicate:fltr]];
    
    numInfiles = [onlyQns count];
    
    onlyQnsNoTxt = [[NSMutableArray alloc] init];
    allQnsAndPaths = [[NSMutableArray alloc] init];
    
    
    for (int noTxt = 0; noTxt < numInfiles; noTxt++){
        NSString * firstName = [onlyQns objectAtIndex:noTxt];
        int nLength = [firstName length];
        
        NSString * firstName2 = [firstName substringToIndex:(nLength -4)];
        [onlyQnsNoTxt addObject:firstName2];
        NSString * fullQuestion = [qListPath stringByAppendingPathComponent:firstName];
        [allQnsAndPaths addObject:fullQuestion];
        
    }
    
    
    NSLog (@"NumberOfFiles is %i",numInfiles);
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    footer.backgroundColor = [UIColor clearColor];
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
    [self.restClient loadMetadata:@"/download/"];
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
    return numInfiles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[onlyQnsNoTxt objectAtIndex:indexPath.row]];
    
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
    
    //infile = [onlyQns objectAtIndex:indexPath.row];
    //infile = [qListPath stringByAppendingPathComponent:infile];
    
    infile = [allQnsAndPaths objectAtIndex:indexPath.row];
    
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

// overide getter
- (DBRestClient *)restClient {
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    downloadCount = 0;
    newQuestions = [[NSMutableArray alloc] init];
    if (metadata.isDirectory) {
        for (DBMetadata *file in metadata.contents) {
            bool shouldDownload = true;
            for(NSString *existing in onlyQns){
                if([existing isEqualToString:file.filename]){
                    shouldDownload = false;
                    break;
                }
            }
            if(shouldDownload){
                downloadCount++;
                NSString * dropboxPath = [@"/download/" stringByAppendingString:file.filename];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];

                
                NSString * localPath = [documentsDirectory stringByAppendingPathComponent:file.filename];
                [self.restClient loadFile:dropboxPath intoPath:localPath];
            }
        }
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    NSLog(@"Error loading metadata: %@", error);
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath {
    NSLog(@"File loaded into path: %@", localPath);
            [allQnsAndPaths addObject:localPath];
    
    
    
    
    
    
    NSString *filename = [localPath lastPathComponent];
    NSArray *components = [filename componentsSeparatedByString:@"."];
    NSLog(@"file extension, %@", [components objectAtIndex:1]);
    
    //if the extension is ok add it to the new files array to be added to the table later
    NSLog(@" %@ = txt",[components objectAtIndex:1] );
    if ([[components objectAtIndex:1] isEqualToString:@"txt"]) {
        [newQuestions addObject:filename];
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
        NSArray *components = [filename componentsSeparatedByString:@"."];
        [onlyQns addObject:filename];
        [onlyQnsNoTxt addObject:[components objectAtIndex:0]];
        [indexPaths addObject:[NSIndexPath indexPathForRow:numInfiles inSection:0]];
        numInfiles++;
    }
    [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    [table endUpdates];
}

@end