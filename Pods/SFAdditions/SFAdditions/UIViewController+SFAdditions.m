//
//  UIViewController+SFAdditions.m
//
//  Created by Skye on 4/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIViewController+SFAdditions.h"

@implementation UIViewController (SFAdditions)

#pragma mark - Alerts convenience
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray*)allActions {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (UIAlertAction *action in allActions) {
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [self showAlertWithTitle:title message:message actions:[NSArray arrayWithObject:action]];
}

- (void)showErrorAlertWithMessage:(NSString*)string {
    [self showAlertWithTitle:@"Error" message:string];
}

#pragma mark - Text field convenience
- (void)setTextFieldDelegates {
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            ((UITextField*)subview).delegate = (id) self;
        }
    }
}

- (void)resignTextFieldFirstResponders {
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [((UITextField*)subview) resignFirstResponder];
        }
    }
}

#pragma mark - Button convenience
- (void)roundButtonCorners:(CGFloat)radius {
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [((UIButton*)subview).layer setCornerRadius:radius];
        }
    }
}

#pragma mark - Activity indicator convenience
- (void)displayActivityIndicator:(CGPoint)position style:(UIActivityIndicatorViewStyle)style {
    if ([self hasActivityIndicator]) return;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    [indicator setCenter:position];
    [self.view addSubview:indicator];
    
    [indicator startAnimating];
}

- (void)removeActivityIndicator {
    for (UIView* subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIActivityIndicatorView class]]) {
            UIActivityIndicatorView *indicator = (UIActivityIndicatorView*)subview;
            [indicator stopAnimating];
            [indicator removeFromSuperview];
        }
    }
}

- (BOOL)hasActivityIndicator {
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[UIActivityIndicatorView class]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Gesture Recognizer conveneince
- (void)removeAllGestureRecognizers {
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
}

#pragma mark - Navigation bar convenience
- (CGFloat)navigationBarHeight {
    if (self.navigationController.navigationBar) {
        return self.navigationController.navigationBar.frame.size.height;
    }
    return 0;
}

#pragma mark - Status bar convenience 
- (CGFloat)statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
@end
