//
//  UIView+SFAdditions.h
//  SFAdditions
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameConvenience)

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat topEdge;
@property (nonatomic) CGFloat bottomEdge;
@property (nonatomic) CGFloat rightEdge;
@property (nonatomic) CGFloat leftEdge;

@property (nonatomic) CGPoint topRightPoint;
@property (nonatomic) CGPoint topLeftPoint;
@property (nonatomic) CGPoint bottomRightPoint;
@property (nonatomic) CGPoint bottomLeftPoint;

@end

@interface UIView (DrawHelpers)

+ (void)roundCorners:(UIRectCorner)corners forView:(UIView*)view withRadius:(CGFloat)radius;
+ (UIView*)circleWithinRect:(CGRect)rect fillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor;

@end