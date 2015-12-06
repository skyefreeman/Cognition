//
//  HTopStoryCell.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItemCell.h"
#import "HNAdditions.h"

#import <TTTTimeIntervalFormatter.h>
#import "HCommentBubble.h"
#import "HCommentBubblePointer.h"
#import "SFAdditions.h"

CGFloat const kTopStoryCellHeight = 50;
CGFloat const kEdgePadding = 8;

@interface HHackerNewsItemCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation HHackerNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.commentButton addTarget:self action:@selector(commentButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureWithTitle:(NSString*)title points:(NSInteger)points author:(NSString*)author time:(NSInteger)time comments:(NSInteger)comments {
    
    NSString *pointsString = (points > 1) ? [NSString stringWithFormat:@"%lu points ",(long)points] : @"";
    NSString *authorString = [NSString stringWithFormat:@"by %@",author];
    NSString *commentString;
    if (comments > 0) {
        commentString = [NSString stringWithFormat:@"%lu comments",(long)comments];
        [self.commentButton setTintColor:[UIColor HNOrange]];
    } else {
        commentString = [NSString stringWithFormat:@"No comments"];
        self.commentButton.userInteractionEnabled = NO;
        [self.commentButton setTintColor:[UIColor HNLightGray]];
    }
    [self.commentButton setTitle:commentString forState:UIControlStateNormal];
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeString = [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@%@ %@",pointsString,authorString,timeString];
    self.titleLabel.font = [UIFont hnFont:16.0f];
    self.titleLabel.text = title;
    
    [self layoutIfNeeded];
}

- (void)commentButtonTapped {
    [self.delegate commentButtonTapped:self];
}

+ (UINib*)nib {
    return [UINib nibWithNibName:NSStringFromClass([HHackerNewsItemCell class]) bundle:nil];
}

@end
