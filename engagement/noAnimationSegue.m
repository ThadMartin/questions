//
//  noAnimationSegue.m
//  engagement
//
//  Created by Thad Martin on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "noAnimationSegue.h"

@implementation noAnimationSegue

-(void) perform{
      [self.sourceViewController presentModalViewController:self.destinationViewController animated:NO];
}

@end
