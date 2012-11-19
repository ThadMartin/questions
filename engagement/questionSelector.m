//
//  questionSelector.m
//  engagement
//
//  Created by Thad Martin on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// This file used to download questions.  Code that did that should be removed...

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
    int downloadCount;
    NSArray *filelist;
    NSMutableArray * filelist3;
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
    
    onlyQns = [[NSMutableArray alloc ] init];
    NSString * endQuestionName;
    
    for(NSString * questionName in appDelegate.allQnsAndPaths){
        endQuestionName = [questionName lastPathComponent];
        [onlyQns addObject:endQuestionName];
    }
    
    //NSLog(@"only questions: %@", onlyQns);
    
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
    //[self.tableView sort];
    [self.tableView reloadData];
}

@end