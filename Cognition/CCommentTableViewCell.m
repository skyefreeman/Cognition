//
//  CCommentTableViewCell.m
//  Cognition
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CCommentTableViewCell.h"
#import "CConstants.h"

CGFloat const kCommentCellHeight = 100.0;

@interface CCommentTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *background;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@end

@implementation CCommentTableViewCell

- (void)awakeFromNib {
    self.background.layer.cornerRadius = kCornerRadius;
}

- (void)configureWithAuthor:(NSString*)author time:(NSString*)timeString comment:(NSString*)commentString {
    self.authorLabel.text = author;
    self.timeAgoLabel.text = timeString;
    self.commentTextView.text = commentString;
}

@end
