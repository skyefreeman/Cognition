//
//  HCommentBubble.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CNumberBubbleView.h"
#import "CAdditions.h"

@interface CNumberBubbleView ()
@property (nonatomic) UILabel *textLabel;
@end

@implementation CNumberBubbleView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    if (self) {
        self.layer.borderColor = [UIColor COrange].CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = self.frame.size.height/2;
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [self.textLabel.font fontWithSize:11];
        self.textLabel.textColor = [UIColor COrange];
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.numberOfLines = 1;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
    }
    
    return self;
}

- (void)setText:(NSString*)text {
    [self.textLabel setText:text];
    [self.textLabel setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

@end
