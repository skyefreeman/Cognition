//
//  UIView+SFAdditions.m
//  SFAdditions
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIView+SFAdditions.h"

@implementation UIView (SFAdditions)

#pragma mark - self.frame.origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

#pragma mark - self.frame.origin.x
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

#pragma mark - self.frame.origin.y
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

#pragma mark - self.frame.size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

#pragma mark - self.frame.size.width
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

#pragma mark - self.frame.size.height
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

#pragma mark - Top Edge
- (CGFloat)topEdge {
    return self.y;
}

- (void)setTopEdge:(CGFloat)topEdge {
    self.y = topEdge;
}

#pragma mark - Bottom Edge
- (CGFloat)bottomEdge {
    return self.y + self.height;
}

- (void)setBottomEdge:(CGFloat)bottomEdge {
    self.y = bottomEdge - self.height;
}

#pragma mark - Right Edge
- (CGFloat)rightEdge {
    return self.x + self.width;
}

- (void)setRightEdge:(CGFloat)rightEdge {
    self.x = rightEdge - self.width;
}

#pragma mark - Left Edge
- (CGFloat)leftEdge {
    return self.x;
}

- (void)setLeftEdge:(CGFloat)leftEdge {
    self.x = leftEdge;
}

#pragma mark - Top Left Point
- (CGPoint)topLeftPoint {
    return self.origin;
}

- (void)setTopLeftPoint:(CGPoint)topLeftPoint {
    self.origin = topLeftPoint;
}

#pragma mark - Top Right Point
- (CGPoint)topRightPoint {
    return CGPointMake(self.x + self.width, self.y);
}

- (void)setTopRightPoint:(CGPoint)topRightPoint {
    self.origin = CGPointMake(topRightPoint.x - self.width, topRightPoint.y);
}

#pragma mark - Bottom Right Point
- (CGPoint)bottomRightPoint {
    return CGPointMake(self.x + self.width, self.y + self.height);
}

- (void)setBottomRightPoint:(CGPoint)bottomRightPoint {
    self.origin = CGPointMake(bottomRightPoint.x - self.width, bottomRightPoint.y - self.height);
}

#pragma mark - Bottom Left Point
- (CGPoint)bottomLeftPoint {
    return CGPointMake(self.x, self.y + self.height);
}

- (void)setBottomLeftPoint:(CGPoint)bottomLeftPoint {
    self.origin = CGPointMake(bottomLeftPoint.x, self.bottomLeftPoint.y - self.height);
}

@end

@implementation UIView (DrawHelpers)

#pragma mark - UIView Drawing Helpers
+ (UIView*)circleWithinRect:(CGRect)rect fillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor {
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *shapelayer = [[CAShapeLayer alloc] init];
    shapelayer.fillColor = fillColor.CGColor;
    shapelayer.strokeColor = strokeColor.CGColor;
    shapelayer.path = circle.CGPath;
    
    UIView *circleView = [[UIView alloc] initWithFrame:rect];
    [circleView.layer addSublayer:shapelayer];
    return circleView;
}

+ (void)roundCorners:(UIRectCorner)corners forView:(UIView*)view withRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    maskLayer = nil;
}

@end