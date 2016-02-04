//
//  HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 12/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CAdditions.h"

#pragma mark - NSObject Additions
@implementation NSObject (CAdditions)
+ (NSString*)standardReuseIdentifier {
    return NSStringFromClass(self);
}
@end

#pragma mark - UIColor Additions
@implementation UIColor (CAdditions)
+ (UIColor*)COrange {
    return [UIColor colorWithRed:1.000 green:0.270 blue:0.252 alpha:1.000];
}

+ (UIColor*)CDarkGray {
    return [UIColor colorWithWhite:0.168 alpha:1.000];
}

+ (UIColor*)CSystemBlue {
    return [UIColor colorWithRed:0.000 green:0.479 blue:1.000 alpha:1.000];
}

+ (UIColor*)CLightGray {
    return [UIColor colorWithWhite:0.871 alpha:1.000];
}

+ (UIColor*)CBlue {
    return [UIColor colorWithRed:0.012 green:0.122 blue:0.435 alpha:1.000];
}
@end

#pragma mark - UILabel Additions
@implementation UILabel (CAdditions)
- (void)setSubstituteFont:(UIFont*)font {
    self.font = [self.font fontWithSize:self.font.pointSize];
}
@end

#pragma mark - UIFont Additions
@implementation UIFont (CAdditions)
+ (UIFont*)CFont:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize];
}
@end

#pragma mark - UIImage Additions
@implementation UIImage (CAdditions)
+ (UIImage*)cancelImage {
    return [UIImage imageNamed:@"cancel_image"];
}

+ (UIImage*)menuImage {
    return [UIImage imageNamed:@"menu_image"];
}

+ (UIImage*)twitterImage {
    return [UIImage imageNamed:@"twitter_image"];
}

+ (UIImage*)octocatImage {
    return [UIImage imageNamed:@"octocat_image"];
}

+ (UIImage*)websiteImage {
    return [UIImage imageNamed:@"website_image"];
}

+ (UIImage*)backgroundImage {
    return [UIImage imageNamed:@"background_image"];
}

@end

@implementation UIView (CAdditions)
+ (UIView*)backgroundViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIColor *startColor = [UIColor colorWithRed:0.129 green:0.678 blue:0.702 alpha:1.000];
    UIColor *endColor = [UIColor colorWithRed:0.012 green:0.122 blue:0.435 alpha:1.000];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor,(id)endColor.CGColor, nil];

    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    
    [view.layer addSublayer:gradient];
    return view;
}
@end

