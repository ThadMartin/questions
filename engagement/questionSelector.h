//
//  questionSelector.h
//  engagement
//
//  Created by Thad Martin on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface questionSelector : UITableViewController <UITableViewDelegate,UITableViewDataSource, DBRestClientDelegate>{
    NSString * infile;
}

@property (nonatomic, retain) DBRestClient *restClient;

- (void)insertNewTableRows:(NSArray *)newFiles;
- (void)addNewQuestionsToTable;


@end
