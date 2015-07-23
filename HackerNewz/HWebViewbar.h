//
//  HWebViewbar.h
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWebViewBarDelegate <NSObject>
- (void)webBarCancelButtonTapped;
@end

typedef NS_ENUM(NSInteger, BarType) {
    BarTypeBottom = 0,
    BarTypeTop,
};

@interface HWebViewbar : UIView

+ (instancetype)barWithType:(BarType)barType;
- (instancetype)initWithBarType:(BarType)barType;

- (void)fadeOut;
- (void)fadeIn;

- (void)fadeOutWithDuration:(CGFloat)duration;
- (void)fadeInWithDuration:(CGFloat)duration;

@property (nonatomic, weak) id <HWebViewBarDelegate> delegate;
@property (nonatomic, readonly) BarType barType;

@property (nonatomic) BOOL hasBlur;
@property (nonatomic) UIColor *barColor;
@end
