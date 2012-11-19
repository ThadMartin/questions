//
//  picture.m
//  engagement
//
//  Created by Thad Martin on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "picture.h"
#import "instruction.h"
#import "QuestionData.h"
#import "engagementAppDelegate.h"
#import "questionParser.h"


@implementation picture{
    NSTimer * timer;
}


@synthesize continueButton;
@synthesize fields;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    

}
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * timerTime = [fields objectAtIndex:4];
    NSString * picName = [fields objectAtIndex:5];
    //float timerTimeNumber = [timerTime floatValue];
    float timerTimeNumber = 0.5;  //for debugging, when tired of timeouts.
    if (timerTimeNumber > 0){
        timer = [NSTimer scheduledTimerWithTimeInterval:timerTimeNumber target:self selector:@selector(timeIsUp:) userInfo:nil repeats:NO];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
    
    NSString * picPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:picName];  //no enpty newline at end? 
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:picPath];
    
    if (fileExists == 0){
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        picPath = [paths objectAtIndex:0];
        picPath = [picPath stringByAppendingPathComponent:picName];
    }

    
    NSLog(@"\n %@ \n",picPath);
    
    NSData *imageData = [NSData dataWithContentsOfFile:picPath];
    UIImage *image = [UIImage imageWithData:imageData] ;
    
    imgView.contentMode = UIViewContentModeCenter;
    
    //shrink it if it's too big.
    if((image.size.width > 728)||(image.size.height > 853))
        imgView.contentMode = UIViewContentModeScaleAspectFit;
               
    [imgView setImage:image];
    
    NSString * showButton =[fields objectAtIndex:6];
    BOOL showButtonBool = [showButton boolValue];
    if (!showButtonBool)
        [continueButton setHidden:true];
}


-(void) timeIsUp:(NSTimer*)timer{
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    NSString *answerObj = [NSString stringWithFormat:@"time ran out."];
    
    [questionAnswers2 addObject:answerObj];
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH_mm_ss.SSS"];
    NSString * timeNow2 = [df stringFromDate:myDate];
    
    [questionAnswers2 addObject:timeNow2];
    
    NSMutableArray * questionAnswers = [[NSMutableArray alloc] init]; 
    
    int retab = [questionAnswers2 count];
    
    for (int retabCounter = 0;retabCounter<retab;retabCounter++){
        NSString * retabWhatever = [questionAnswers2 objectAtIndex:retabCounter];
        retabWhatever = [retabWhatever stringByAppendingString:@"\t"];
        [questionAnswers addObject:retabWhatever];
    }
    
    NSString * newLn = @"\r";
    [questionAnswers addObject:newLn];
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    [thisQuestionData saveData:questionAnswers];
    
    [self dismissModalViewControllerAnimated:NO];
}




- (void)viewDidUnload
{
    [self setContinueButton:nil];
    imgView = nil;
    imgView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
        return NO;   
    else
        return YES;
}

- (IBAction)continueButtonPressed:(id)sender {
    [timer invalidate];
    
    NSMutableArray * questionAnswers2 = [[NSMutableArray alloc] initWithArray:fields]; 
    
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"HH_mm_ss.SSS"];
    NSString * timeNow2 = [df stringFromDate:myDate];
    
    [questionAnswers2 addObject:timeNow2];
    
    NSMutableArray * questionAnswers = [[NSMutableArray alloc] init]; 
    
    int retab = [questionAnswers2 count];
    
    for (int retabCounter = 0;retabCounter<retab;retabCounter++){
        NSString * retabWhatever = [questionAnswers2 objectAtIndex:retabCounter];
        retabWhatever = [retabWhatever stringByAppendingString:@"\t"];
        [questionAnswers addObject:retabWhatever];
    }
    
    NSString * newLn = @"\r";
    [questionAnswers addObject:newLn];
    
    QuestionData * thisQuestionData = [[QuestionData alloc] init]; 
    [thisQuestionData saveData:questionAnswers];
    
    //NSLog(@"going back to questionParser");
    
    [self dismissModalViewControllerAnimated:NO];

}
@end
