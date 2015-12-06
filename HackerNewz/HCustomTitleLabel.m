//
//  HNavigationBarTitleLabel.m
//  HackerNewz
//
//  Created by Skye on 9/8/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCustomTitleLabel.h"
#import "HNAdditions.h"

@implementation HCustomTitleLabel
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.text = title;
    [self sizeToFit];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont hnFont:20.0f]];
    [self setTextColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTouched)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

- (void)titleLabelTouched {
    [self.delegate customTitleLabelTouched];
}

@end
