//
//  engagementAppDelegate.m
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "engagementAppDelegate.h"
#import "engagementViewController.h"
#import <DropboxSDK/DropboxSDK.h>
//You need to add QuartzCore.framework, for dropbox.
#import "QuestionData.h"
#include <time.h>
#include <stdlib.h>
#import "questionParser.h"


@implementation engagementAppDelegate{
    NSString * docPath;
   // NSMutableArray allQnsAndPaths;
   // BOOL inRandom;
    
}

@synthesize window;
@synthesize docPath;
@synthesize allQnsAndPaths;
@synthesize navController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString * initFile = [documentsDirectory stringByAppendingPathComponent:@"initFile.txt"];
//    
//    NSData *data = [NSData dataWithContentsOfFile:initFile];
//    NSString * stringOfFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\n" withString:@"\r"];
//    stringOfFile = [stringOfFile stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\r"];
//    stringOfFile = [stringOfFile stringByAppendingString:@"\r"];
//    NSArray * linesOfFile = [stringOfFile componentsSeparatedByString:@"\r"];
//

     DBSession* dbSession =
    [[DBSession alloc]
    //initWithAppKey:@"rghajjw49l47ms7"     //thad dropbox
    //appSecret:@"fuul8iopy31k3bu"
      initWithAppKey:@"cuorzhksvg6cucn"     //atr dropbox
      appSecret:@"nt6md08yfwu0gwp"
    root:kDBRootAppFolder]; // either kDBRootAppFolder or kDBRootDropbox    
    [DBSession setSharedSession:dbSession];
    
   QuestionData * thisQuestionData = [[QuestionData alloc] init];     
   docPath = [thisQuestionData createDataPath];  //includes full path.
    
   NSLog(@"docPath is: %@",docPath);
    
    allQnsAndPaths = [[NSMutableArray alloc] init];
    
    srand(time(NULL));
    
    // dismissing modal view controllers without a navigation controller is tricky.
    UIViewController *rootView = [[engagementViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:rootView];

    return YES;
     
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

//from dropbox
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {   
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}

@end
