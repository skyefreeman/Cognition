//
//  HTopStoryCell.m
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItemCell.h"

NSString * const kNewsItemReuseIdentifier = @"TopStoryReuseIdentifier";
CGFloat const kTopStoryCellHeight = 50;

@interface HHackerNewsItemCell()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation HHackerNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWithTitle:(NSString*)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

@end
