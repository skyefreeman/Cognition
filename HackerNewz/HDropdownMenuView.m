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

CGFloat const kDefaultCellHeight = 40.0;

@interface HDropdownMenuView()
@property (nonatomic) NSArray *items;
@property (nonatomic, getter=isAnimating) BOOL animating;
@end

@implementation HDropdownMenuView

+ (instancetype)menuWithItems:(NSArray*)items {
    return [[self alloc] initWithMenuItems:items];
}

- (instancetype)initWithMenuItems:(NSArray*)items {
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    CGFloat menuHeight = kDefaultCellHeight * items.count;
    CGRect menuFrame = CGRectMake(0, -menuHeight, screenSize.size.width, menuHeight);
    
    self = [super initWithFrame:menuFrame];
    if (self) {
        self.backgroundColor = [UIColor HNDarkGray];
        self.startPoint = self.position;
        self.menuActive = NO;
        
        self.items = items;
        [self configureCellsSpacers];
        [self configureCellTitles];
        
        self.animating = NO;
    }
    return self;
}

#pragma mark - Cell Spacers
- (void)configureCellsSpacers {
    for (int i = 1; i < self.items.count; i++) {
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
    CGFloat heightOffset = (self.height/self.items.count) / 2;
    for (int i = 0; i < self.items.count; i++) {
        [self addSubview:[self titleLabelAtY: (heightOffset + ([self cellHeight] * i)) withItem:[self itemAtIndex:i]]];
    }
}

- (UILabel*)titleLabelAtY:(CGFloat)yOrigin withItem:(NSString*)item {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/self.items.count)];
    title.text = item;
    title.textColor = [UIColor whiteColor];
    [title sizeToFit];
    title.center = CGPointMake(self.width/2, yOrigin);
    return title;
}

#pragma mark - Public Functions
- (void)slide:(SlideDirection)direction {
    if (self.isAnimating) return;
    
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
    
    self.animating = YES;
    [UIView animateWithDuration:.5 animations:^{
        [self setPosition:CGPointMake(0, endpoint)];
    } completion:^(BOOL finished) {
        self.animating = NO;
        self.menuActive = direction;
    }];
}

#pragma mark - Convenience
- (CGFloat)cellHeight {
    return self.frame.size.height/self.items.count;
}

- (NSString*)itemAtIndex:(NSInteger)index {
    return [self.items objectAtIndex:index];
}

@end
