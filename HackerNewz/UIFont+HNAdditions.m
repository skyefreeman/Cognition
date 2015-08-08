//
//  UIFont+HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 8/8/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIFont+HNAdditions.h"

@implementation UIFont (HNAdditions)
+ (UIFont*)hnFont:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

@end
