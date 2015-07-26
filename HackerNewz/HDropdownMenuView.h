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

@interface HDropdownMenuView : UIView
@property (nonatomic, getter=isActive) BOOL menuActive;
@property (nonatomic) CGPoint startPoint;

- (void)slide:(SlideDirection)direction;
@end
