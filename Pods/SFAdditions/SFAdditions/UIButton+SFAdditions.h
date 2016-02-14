//
//  UIButton+SFAdditions.h
//  SFAdditions
//
//  Created by Skye on 8/10/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SFAdditions)
+ (UIButton*)buttonWithTitle:(NSString*)theTitle image:(UIImage*)theImage verticalSpacing:(CGFloat)spacing;
@end
