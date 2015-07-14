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
#import "HCommentBubblePointer.h"
#import <SFAdditions.h>

NSString * const kNewsItemReuseIdentifier = @"TopStoryReuseIdentifier";
CGFloat const kTopStoryCellHeight = 50;
CGFloat const kEdgePadding = 4;

@interface HHackerNewsItemCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) HCommentBubble *commentBubble;
@property (strong, nonatomic) HCommentBubblePointer *commentBubblePointer;
@end

@implementation HHackerNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentBubble = [[HCommentBubble alloc] init];
    self.commentBubble.center = CGPointMake(self.width - self.commentBubble.width/2 - kEdgePadding, self.commentBubble.height/2 + kEdgePadding);
    [self addSubview:self.commentBubble];
    
    self.commentBubblePointer = [[HCommentBubblePointer alloc] init];
    [self.commentBubblePointer setPosition:CGPointMake(self.commentBubble.center.x - self.commentBubblePointer.width/2, self.commentBubble.height + self.commentBubblePointer.height - 1)];
    [self addSubview:self.commentBubblePointer];
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
    [self.commentBubble setText:[NSString integerToString:comments]];

}

@end
