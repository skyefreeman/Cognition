//
//  HCommentBubble.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCommentBubble.h"
#import "UIColor+HNAdditions.h"

@interface HCommentBubble ()
@property (nonatomic) UILabel *textLabel;
@end

@implementation HCommentBubble

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    if (self) {
        self.backgroundColor = [UIColor HNOrange];
        self.layer.cornerRadius = self.frame.size.width/2;
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
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
