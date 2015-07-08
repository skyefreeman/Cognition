//
//  NSObject+HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "NSObject+HNAdditions.h"

@implementation NSObject (HNAdditions)
+(NSString*)standardReuseIdentifier {
    return NSStringFromClass(self);
}

@end
