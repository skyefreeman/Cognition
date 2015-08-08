//
//  UILabel+HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UILabel+HNAdditions.h"

@implementation UILabel (HNAdditions)
- (void)setSubstituteFont:(UIFont*)font {
    self.font = [self.font fontWithSize:self.font.pointSize];
}

@end
