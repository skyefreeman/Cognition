//
//  HNewsCell.m
//  HackerNewz
//
//  Created by Skye on 6/28/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HNewsCell.h"

// Externs
NSString * const kHNewsCellReuseID = @"newsCellReuseID";
CGFloat const kDefaultCellHeight = 60;

// Tags
NSInteger const kHNewsLabelTag = 1;

// Padding
CGFloat const kViewPadding = 15.0;

@interface HNewsCell()
@property (nonatomic) UILabel *titleLabel;
@end

@implementation HNewsCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHNewsCellReuseID];
    if (self) {
        CGSize cellSize = self.frame.size;
        

        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kViewPadding,
                                                                    kViewPadding,
                                                                    cellSize.width - kViewPadding*2,
                                                                    kDefaultCellHeight - kViewPadding*2)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.tag = kHNewsLabelTag;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configureWithTitle:(NSString*)title {
    self.titleLabel.text = title;
}

@end
