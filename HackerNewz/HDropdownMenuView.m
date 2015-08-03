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
        [self configureCellsSpacers];
        [self configureCellTitles];
        
        _isAnimating = NO;
    }
    return self;
}

#pragma mark - Cell Spacers
- (void)configureCellsSpacers {
    for (int i = 1; i < _cellCount; i++) {
        [self addSubview:[self spacerAtY:[self cellHeight] * i]];
    }
}

- (UIView*)spacerAtY:(CGFloat)yOrigin {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, self.width, 1)];
    line.backgroundColor = [UIColor whiteColor];
    return line;
}

#pragma mark - Cell Titles
- (void)configureCellTitles {
    CGFloat heightOffset = (self.height/_cellCount) / 2;
    for (int i = 0; i < _cellCount; i++) {
        [self addSubview:[self titleLabelAtY: heightOffset + ([self cellHeight] * i)]];
    }
}

- (UILabel*)titleLabelAtY:(CGFloat)yOrigin {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/self.cellCount)];
    title.text = @"Title";
    title.textColor = [UIColor whiteColor];
    [title sizeToFit];
    title.center = CGPointMake(self.width/2, yOrigin);
    return title;
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

#pragma mark - Convenience
- (CGFloat)cellHeight {
    return self.frame.size.height/self.cellCount;
}

@end
