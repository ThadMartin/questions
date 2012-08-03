//
//  ttsViewController.h
//  tts
//
//  Created by Sam Foster on 8/11/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FliteTTS;

@interface ttsViewController : UIViewController {
	IBOutlet UITextField *textField;
	FliteTTS *fliteEngine;
}

-(IBAction)textFieldDoneEditing:(id)sender;

@end

