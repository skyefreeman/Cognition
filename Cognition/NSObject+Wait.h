//
//  NSObject+Wait.h
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^WaitBlock)();

@interface NSObject (Wait)
- (void)waitFor:(CGFloat)time then:(WaitBlock)waitBlock;
@end
