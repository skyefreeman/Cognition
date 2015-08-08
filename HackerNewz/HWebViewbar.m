//
//  HWebViewbar.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebViewbar.h"
#import "UIColor+HNAdditions.h"

CGFloat const kPadding = 10;
CGFloat const kBarHeight = 40.0;
CGFloat const kDefaultFadeTime = 0.25;

typedef NS_ENUM(NSInteger, BarLayer) {
    BarLayerBackground = 0,
    BarLayerBlur,
    BarLayerButton,
};

@interface HWebViewbar()
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *backButton;
@property (nonatomic) UIButton *forwardButton;

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
        
        // Spacer
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        spacerView.backgroundColor = [UIColor blackColor];
        [self addSubview:spacerView];
        
        // Buttons
        CGSize buttonSize = CGSizeMake(20, 20);
        
        // Back Button
        self.backButton = [self barButtonAtCenter:CGPointMake(buttonSize.width/2 + kPadding, self.frame.size.height/2) imageNamed:@"leftIcon"];
        [self.backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:self.backButton atIndex:BarLayerButton];
        
        // Forward Button
        self.forwardButton = [self barButtonAtCenter:CGPointMake(self.backButton.frame.origin.x + buttonSize.width + kPadding*4, self.frame.size.height/2) imageNamed:@"rightIcon"];
        [self.forwardButton addTarget:self action:@selector(forwardButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:self.forwardButton atIndex:BarLayerButton];
        
        // Cancel Button
        self.cancelButton = [self barButtonAtCenter:CGPointMake(self.frame.size.width - buttonSize.width - kPadding, self.frame.size.height/2) imageNamed:@"cancelIcon"];
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

- (void)fadeOut {
    [self fadeOutWithDuration:kDefaultFadeTime];
}

- (void)fadeIn {
    [self fadeInWithDuration:kDefaultFadeTime];
}

#pragma mark - Setter Overrides
- (void)setHasBlur:(BOOL)hasBlur {
    if (hasBlur && !self.blurView) {
        self.barColor = [UIColor clearColor];
        
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        [self.blurView setFrame:self.bounds];
        [self insertSubview:self.blurView atIndex:BarLayerBlur];
        
        [self.cancelButton removeFromSuperview];
        [self.blurView.contentView addSubview:self.cancelButton];
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
    [self.delegate cancelButtonTapped];
}

- (void)backButtonTapped {
    [self.delegate backButtonTapped];
}

- (void)forwardButtonTapped {
    [self.delegate forwardButtonTapped];
}

#pragma mark - Convenience
- (UIButton*)barButtonAtCenter:(CGPoint)centerPoint imageNamed:(NSString*)imageName {
    UIImage *backButtonImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    CGSize buttonSize = CGSizeMake(20, 20);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
    button.center = centerPoint;
    [button setImage:backButtonImage forState:UIControlStateNormal];
    [button setTintColor:[UIColor HNOrange]];
    return button;
}

@end
