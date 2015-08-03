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

@interface HDropdownMenuView()
@property (nonatomic) NSInteger cellCount;
@end

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
        
        self.cellCount = 3;
        [self configureCells];
        
        _isAnimating = NO;
    }
    return self;
}

#pragma mark - Private Functions

- (void)configureCells {
    CGRect viewFrame = self.frame;
    NSInteger cellCount = self.cellCount;
    CGFloat cellHeight = viewFrame.size.height/self.cellCount;
    
    for (int i = 1; i < cellCount; i++) {
        [self addSubview:[self spacerWithY:cellHeight * i]];
    }

    
//    |-----
//    | CELL
//    |-----
//    | CELL
//    |-----
//    | CELL
//    |-----
}

- (UIView*)spacerWithY:(CGFloat)yOrigin {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, self.width, 1)];
    NSLog(@"%@",line);
    line.backgroundColor = [UIColor whiteColor];
    return line;
}

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
