//
//  CCustomTitleLabel.m
//  Cognition
//
//  Created by Skye on 9/8/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CCustomTitleLabel.h"
#import "HNAdditions.h"

@implementation CCustomTitleLabel
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.text = title;
    [self sizeToFit];
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setFont:[UIFont hnFont:20.0f]];
    [self setTextColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTouched:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapRecognizer];
    
    return self;
}

- (void)titleLabelTouched:(id)sender {
    if (self.delegate) [self.delegate customTitleLabelTouched:sender];
}

@end
