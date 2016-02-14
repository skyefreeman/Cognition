//
//  UIViewController+SFAdditions.h
//
//  Created by Skye on 4/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SFAdditions)

// Alerts
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray*)allActions;
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message;
- (void)showErrorAlertWithMessage:(NSString*)string;

// Text Field
- (void)setTextFieldDelegates;
- (void)resignTextFieldFirstResponders;

// Buttons
- (void)roundButtonCorners:(CGFloat)radius;

// Activity indicator
- (void)displayActivityIndicator:(CGPoint)position style:(UIActivityIndicatorViewStyle)style;
- (void)removeActivityIndicator;
- (BOOL)hasActivityIndicator;

// Gesture
- (void)removeAllGestureRecognizers;

// Navigation Bar
- (CGFloat)navigationBarHeight;

// Status bar
- (CGFloat)statusBarHeight;
@end
