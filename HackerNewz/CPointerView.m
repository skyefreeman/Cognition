//
//  HCommentBubblePointer.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CPointerView.h"
#import "CAdditions.h"

@implementation CPointerView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 8, 5)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(context, rect);
    
    CGContextSaveGState(context);
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor COrange].CGColor);
        CGContextFillPath(context);
    }
    CGContextRestoreGState(context);
}

@end
