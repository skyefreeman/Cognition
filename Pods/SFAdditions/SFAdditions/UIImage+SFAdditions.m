//
//  UIImage+SFAdditions.m
//  SFAdditions
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIImage+SFAdditions.h"

@implementation UIImage (SFAdditions)

+ (UIImage*)imageWithColor:(UIColor *)color withSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    UIImage *image = [UIImage imageWithColor:color withSize:size];
    [image setCornerRadius:radius];
    return image;
}

+ (UIImage*)imageWithColor:(UIColor *)color withSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)setCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
