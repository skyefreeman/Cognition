//
//  HTopStoryCell.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItemCell.h"
#import "UIColor+HNAdditions.h"
#import "UIFont+HNAdditions.h"

#import <TTTTimeIntervalFormatter.h>
#import "HCommentBubble.h"
#import "HCommentBubblePointer.h"
#import <SFAdditions.h>

CGFloat const kTopStoryCellHeight = 50;
CGFloat const kEdgePadding = 8;

@interface HHackerNewsItemCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) HCommentBubble *commentBubble;
@end

@implementation HHackerNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _commentBubble = [[HCommentBubble alloc] init];
    _commentBubble.center = CGPointMake(self.width - _commentBubble.width/2 - kEdgePadding, _commentBubble.height/2 + kEdgePadding);
    [self addSubview:_commentBubble];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] init];
    [_activityIndicator setColor:[UIColor HNOrange]];
    [_activityIndicator setCenter:_commentBubble.center];
    [_activityIndicator setAlpha:0];
    [self addSubview:_activityIndicator];
}

- (void)configureWithTitle:(NSString*)title points:(NSInteger)points author:(NSString*)author time:(NSInteger)time comments:(NSInteger)comments {
    [self toggleCommentBubbleHidden:NO];
    
    NSString *pointsString = (points > 1) ? [NSString stringWithFormat:@"%lu points ",(long)points] : @"";
    NSString *authorString = [NSString stringWithFormat:@"by %@",author];
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeString = [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@%@ %@",pointsString,authorString,timeString];
    self.titleLabel.font = [UIFont hnFont:16.0f];
    self.titleLabel.text = title;
    
    if (comments > 0) {
        [_commentBubble setText:[NSString integerToString:comments]];
    } else {
        [self toggleCommentBubbleHidden:YES];
    }
}

- (void)toggleCommentBubbleHidden:(BOOL)isHidden {
    [_commentBubble setHidden:isHidden];
}

#pragma mark - Touch Input
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (CGRectContainsPoint(_commentBubble.frame, point) && ![_commentBubble isHidden]) {
        [self commentLoadingViewVisible:YES];
        [self.delegate commentBubbleTapped:self];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}

#pragma mark - Comment Bubble
- (void)commentLoadingViewVisible:(BOOL)isVisible {
    [self activityIndicatorVisible:(isVisible) ? YES : NO];
    [self commentBubbleVisible:(isVisible) ? NO : YES];
}

- (void)activityIndicatorVisible:(BOOL)isVisible {
    _activityIndicator.alpha = isVisible;
    
    if (isVisible) {
        [_activityIndicator startAnimating];
    } else {
        [_activityIndicator stopAnimating];
    }
}

- (void)commentBubbleVisible:(BOOL)isVisible {
    _commentBubble.alpha = isVisible;
}

@end
