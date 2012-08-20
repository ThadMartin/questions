//
//  goodbye.h
//  engagement
//
//  Created by Thad Martin on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface goodbye : UIViewController 

- (IBAction)leave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

//-(void)uploadToDropbox:(NSString *)docPath;

@end
