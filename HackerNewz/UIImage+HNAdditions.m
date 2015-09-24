//
//  UIImage+HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 7/25/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIImage+HNAdditions.h"

@implementation UIImage (HNAdditions)

+ (UIImage*)upImage {
    return [UIImage imageNamed:@"upIcon"];
}

+ (UIImage*)downImage {
    return [UIImage imageNamed:@"downIcon"];
}

+ (UIImage*)cancelImage {
    return [UIImage imageNamed:@"cancelIcon"];
}

+ (UIImage*)leftImage {
    return [UIImage imageNamed:@"leftIcon"];
}

+ (UIImage*)rightImage {
    return [UIImage imageNamed:@"rightIcon"];
}

+ (UIImage*)uploadImage {
    return [UIImage imageNamed:@"uploadIcon"];
}

@end
