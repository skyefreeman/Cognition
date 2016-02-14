//
//  UIImage+SFAdditions.h
//  SFAdditions
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SFAdditions)

+ (UIImage*)imageWithColor:(UIColor *)color withSize:(CGSize)size withCornerRadius:(CGFloat)radius;
+ (UIImage*)imageWithColor:(UIColor *)color withSize:(CGSize)size;

- (UIImage*)setCornerRadius:(CGFloat)radius;

@end
