//
//  CTableViewCell.m
//  Cognition
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CStoryTableViewCell.h"
#import "HNAdditions.h"

#import "TTTTimeIntervalFormatter.h"
#import "HCommentBubble.h"
#import "HCommentBubblePointer.h"

CGFloat const kStoryCellHeight = 50;
CGFloat const kEdgePadding = 8;

@interface CStoryTableViewCell()
@end

@implementation CStoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.commentButton addTarget:self action:@selector(commentButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureWithTitleText:(NSString*)titleText
                 infoLabelText:(NSString*)infoText
            commentButtonTitle:(NSString*)commentTitleText
{
    self.titleLabel.text = titleText;
    self.infoLabel.text = infoText;
    [self.commentButton setTitle:commentTitleText forState:UIControlStateNormal];
    self.commentButton.tintColor = [UIColor HNOrange];
    
    [self layoutIfNeeded];
}

- (void)commentButtonTapped {
    if (self.delegate) [self.delegate commentButtonTapped:self];
}

@end
