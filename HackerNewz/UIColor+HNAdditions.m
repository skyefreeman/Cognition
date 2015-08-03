//
//  UIColor+HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIColor+HNAdditions.h"

@implementation UIColor (HNAdditions)
+ (UIColor*)HNOrange {
    return [UIColor colorWithRed:1.000 green:103/255.0 blue:96/255.0 alpha:1];
}

+ (UIColor*)HNDarkGray {
    return [UIColor colorWithWhite:0.168 alpha:1.000];
}


+ (UIColor*)HNSystemBlue {
    return [UIColor colorWithRed:0.000 green:0.479 blue:1.000 alpha:1.000];
}

+ (UIColor*)HNLightGray {
    return [UIColor colorWithWhite:0.871 alpha:1.000];
}

@end
