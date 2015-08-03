//
//  HDropdownMenuView.m
//  HackerNewz
//
//  Created by Skye on 7/25/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HDropdownMenuView.h"

#import <SFAdditions.h>
#import "UIColor+HNAdditions.h"

@implementation HDropdownMenuView {
    BOOL _isAnimating;
}

+ (instancetype)menuWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor HNDarkGray];
        self.startPoint = self.position;
        self.menuActive = NO;
        
        _isAnimating = NO;
    }
    return self;
}

#pragma mark - Private Functions

#pragma mark - Public Functions
- (void)slide:(SlideDirection)direction {
    if (_isAnimating) return;
    
    CGFloat endpoint;
    switch (direction) {
        case SlideDirectionOut: {
            endpoint = self.startPoint.y;
            break;
        }
        case SlideDirectionIn: {
            endpoint = self.startPoint.y + self.height;
            break;
        }
    }
    
    _isAnimating = YES;
    [UIView animateWithDuration:.5 animations:^{
        [self setPosition:CGPointMake(0, endpoint)];
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        self.menuActive = direction;
    }];
}


@end
