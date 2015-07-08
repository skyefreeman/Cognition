//
//  HTopStoryCell.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HTopStoryCell.h"

NSString * const kTopStoryReuseIdentifier = @"TopStoryReuseIdentifier";

@interface HTopStoryCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *storyCountLabel;
@end

@implementation HTopStoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWithTitle:(NSString*)title count:(NSInteger)count {
//    self.titleLabel.frame = self.titleLabel.frame;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    NSString *textString = [NSString stringWithFormat:@"%lu",count];
    self.storyCountLabel.text = [textString stringByAppendingString:@"."];
}

@end
