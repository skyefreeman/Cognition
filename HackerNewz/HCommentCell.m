//
//  HCommentCell.m
//  HackerNewz
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCommentCell.h"
#import "HNAdditions.h"
#import "TTTTimeIntervalFormatter.h"
#import "TTTAttributedLabel.h"

CGFloat const kCommentCellHeight = 100.0;

@interface HCommentCell()
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (strong, nonatomic) IBOutlet TTTAttributedLabel *commentLabel;
@end

@implementation HCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWithAuthor:(NSString*)author time:(NSInteger)time text:(NSString*)text {
    if (author) self.authorLabel.text = [@"by " stringByAppendingString:author];
    
    if (text) {
        NSAttributedString *attText = [[NSAttributedString alloc] initWithString:text];
        [self.commentLabel setText:attText];
        self.commentLabel.font = [UIFont hnFont:14];
    }
    
    if (time) {
        NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
        TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
        NSString *timeString = [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];
        self.timeAgoLabel.text = timeString;
    }
}

@end
