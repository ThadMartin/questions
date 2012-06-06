//
//  questionParser.h
//  engagement
//
//  Created by Thad Martin on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>


@interface questionParser : UIViewController <DBRestClientDelegate>

@property (nonatomic, retain) NSString *infile;
@property (assign) NSArray * questionLine;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
- (IBAction)linkButtonPressed:(id)sender;

@end
