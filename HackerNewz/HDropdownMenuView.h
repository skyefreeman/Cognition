//
//  HDropdownMenuView.h
//  HackerNewz
//
//  Created by Skye on 7/25/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SlideDirection) {
    SlideDirectionOut = 0,
    SlideDirectionIn = 1,
};

@protocol HDropdownMenuViewDelegate
- (void)didSelectItemAtRow:(NSInteger)row;
@end

@interface HDropdownMenuView : UIView

@property (nonatomic, weak) id <HDropdownMenuViewDelegate> delegate;
@property (nonatomic, getter=isActive) BOOL menuActive;
@property (nonatomic) CGPoint startPoint;

+ (instancetype)menuWithItems:(NSArray*)items;
- (instancetype)initWithMenuItems:(NSArray*)items;

- (void)toggleSlide;

@end
