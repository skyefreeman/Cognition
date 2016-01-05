//
//  CCommentTableViewCell.m
//  Cognition
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CCommentTableViewCell.h"
#import "TTTAttributedLabel.h"

CGFloat const kCommentCellHeight = 100.0;

@interface CCommentTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *commentLabel;
@end

@implementation CCommentTableViewCell

- (void)configureWithAuthor:(NSString*)author time:(NSString*)timeString comment:(NSAttributedString*)comment {
    self.authorLabel.text = author;
    self.timeAgoLabel.text = timeString;
    self.commentLabel.text = comment;
}

@end
