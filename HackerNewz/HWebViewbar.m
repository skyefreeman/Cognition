//
//  HWebViewbar.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebViewbar.h"

CGFloat const kBarHeight = 40.0;

typedef NS_ENUM(NSInteger, BarLayer) {
    BarLayerBackground = 0,
    BarLayerBlur,
    BarLayerButton,
};

@interface HWebViewbar()
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic, readwrite) BarType barType;
@property (nonatomic) UIVisualEffectView *blurView;
@end

@implementation HWebViewbar {
    BOOL _isAnimating;
}

- (instancetype)initWithBarType:(BarType)barType {
    self = [super init];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        if (barType == BarTypeBottom) {
            self.barType = BarTypeBottom;
            self.frame = CGRectMake(0, screenRect.size.height - kBarHeight, screenRect.size.width, kBarHeight);
        } else {
            self.barType = BarTypeTop;
            self.frame = CGRectMake(0, 0, screenRect.size.width, kBarHeight);
        }
        
        self.barColor = [UIColor whiteColor];
        self.hasBlur = NO;
        
        CGSize buttonSize = CGSizeMake(20, 20);
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
        self.cancelButton.center = CGPointMake(buttonSize.width, self.frame.size.height/2);
        [self.cancelButton setImage:[UIImage imageNamed:@"cancelIcon"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:self.cancelButton atIndex:BarLayerButton];
    }
    return self;
}

+ (instancetype)barWithType:(BarType)barType {
    return [[self alloc] initWithBarType:barType];
}

#pragma mark - Animations
- (void)fadeOutWithDuration:(CGFloat)duration {
    if (_isAnimating || self.alpha == 0) return;
    
    _isAnimating = YES;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
    }];
}

- (void)fadeInWithDuration:(CGFloat)duration {
    if (_isAnimating || self.alpha == 1) return;
    
    _isAnimating = YES;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        self.userInteractionEnabled = YES;
        self.alpha = 1;
    }];
}

#pragma mark - Setter Overrides
- (void)setHasBlur:(BOOL)hasBlur {
    if (hasBlur && !self.blurView) {
        self.barColor = [UIColor clearColor];
        
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [self.blurView setFrame:self.bounds];
        [self insertSubview:self.blurView atIndex:BarLayerBlur];
    }
    else if (!hasBlur && self.blurView){
        [self.blurView removeFromSuperview];
    }
}

- (void)setBarColor:(UIColor *)barColor {
    self.backgroundColor = barColor;
}

#pragma mark - HWebViewBar delegate methods
- (void)cancelButtonTapped {
    [self.delegate webBarCancelButtonTapped];
}

@end
