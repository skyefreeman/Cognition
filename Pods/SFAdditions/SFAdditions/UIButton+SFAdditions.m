//
//  UIButton+SFAdditions.m
//  SFAdditions
//
//  Created by Skye on 8/10/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIButton+SFAdditions.h"

@implementation UIButton (SFAdditions)
+ (UIButton*)buttonWithTitle:(NSString*)theTitle image:(UIImage*)theImage verticalSpacing:(CGFloat)spacing {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customButton setImage:[theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    if (theTitle) {
        [customButton setTitle:theTitle forState:UIControlStateNormal];
    }
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    CGSize imageSize = customButton.imageView.image.size;
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    CGSize titleSize = [customButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: customButton.titleLabel.font}];
    customButton.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    return customButton;
}

@end
