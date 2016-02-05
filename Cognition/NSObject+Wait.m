//
//  NSObject+Wait.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "NSObject+Wait.h"

@implementation NSObject (Wait)
- (void)waitFor:(CGFloat)time then:(WaitBlock)waitBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        waitBlock();
    });
}
@end
