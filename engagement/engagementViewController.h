//
//  engagementViewController.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class DBRestClient;

@interface engagementViewController : UIViewController <UITextFieldDelegate>{
	//DBRestClient* restClient;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
- (IBAction)linkButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *linkButton;

@end
