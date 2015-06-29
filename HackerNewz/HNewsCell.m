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
typedef NS_ENUM(NSInteger, CellTag) {
    CellTagTitle = 1,
    CellTagCount,
};

// Padding
CGFloat const kViewPadding = 10.0;

@interface HNewsCell()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *countLabel;
@end

@implementation HNewsCell

- (instancetype)initWithTitle:(NSString*)title {
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
        self.titleLabel.tag = CellTagTitle;
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
        [self.contentView addSubview:self.titleLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kViewPadding, cellSize.height - kViewPadding/4, cellSize.width/4, 20)];
        self.countLabel.font = [UIFont systemFontOfSize:10];
        self.countLabel.tag = CellTagCount;
        [self.contentView addSubview:self.countLabel];
    }
    return self;
}

- (void)configureWithTitle:(NSString*)title count:(NSInteger)count {
    self.titleLabel.text = title;
    self.countLabel.text = [NSString stringWithFormat:@"%lu",count];
}

@end
