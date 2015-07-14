//
//  HTopStoryCell.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItemCell.h"
#import <TTTTimeIntervalFormatter.h>
#import "HCommentBubble.h"
#import <SFAdditions.h>

NSString * const kNewsItemReuseIdentifier = @"TopStoryReuseIdentifier";
CGFloat const kTopStoryCellHeight = 50;

@interface HHackerNewsItemCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) HCommentBubble *commentCountBubble;
@end

@implementation HHackerNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentCountBubble = [[HCommentBubble alloc] init];
    self.commentCountBubble.center = CGPointMake(self.frame.size.width - self.commentCountBubble.frame.size.width/2 - 8, self.center.y);
    [self addSubview:self.commentCountBubble];
}

- (void)configureWithTitle:(NSString*)title points:(NSInteger)points author:(NSString*)author time:(NSInteger)time comments:(NSInteger)comments {
    NSString *pointsString = [NSString stringWithFormat:@"%lu points",(long)points];
    NSString *authorString = [NSString stringWithFormat:@"by %@",author];
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeString = [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];

    NSString *commentsString = [NSString stringWithFormat:@"%lu comments",(long)comments];
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@ | %@",pointsString,authorString,timeString,commentsString];
    
    self.titleLabel.text = title;
    [self.commentCountBubble setText:[NSString integerToString:comments]];
}

@end
