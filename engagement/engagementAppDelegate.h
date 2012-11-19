//
//  engagementAppDelegate.h
//  engagement
//
//  Created by Thad Martin on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class engagementViewController;

@interface engagementAppDelegate : NSObject <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) NSString * docPath;
@property (strong) NSMutableArray * allQnsAndPaths;
@property (strong, nonatomic) UINavigationController * navController;


@end
