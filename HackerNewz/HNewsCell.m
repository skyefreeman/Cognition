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
CGFloat const kDefaultCellHeight = 100;

// Tags
typedef NS_ENUM(NSInteger, CellTag) {
    CellTagTitle = 1,
    CellTagCount,
};

// Padding
CGFloat const kViewPadding = 8.0;

@interface HNewsCell()
@property (nonatomic) UIView *background;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *countLabel;
@end

@implementation HNewsCell {
    CGSize _cellSize;
    CGRect _titleFrame;
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHNewsCellReuseID];
    if (self) {
        _cellSize = self.frame.size;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0.934 green:0.908 blue:0.782 alpha:1.000];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(kViewPadding, kViewPadding, 20, 15)];
        self.countLabel.font = [UIFont fontWithName:@"GillSans" size:15];
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.alpha = 0.4;
        self.countLabel.tag = CellTagCount;
        [self.contentView addSubview:self.countLabel];
        
        CGFloat countLabelRightEdge = [self rightEdgeOfView:self.countLabel];
        _titleFrame = CGRectMake(countLabelRightEdge + kViewPadding,
                                 kViewPadding,
                                 _cellSize.width - countLabelRightEdge - kViewPadding,
                                 kDefaultCellHeight - kViewPadding*2);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:_titleFrame];
        self.titleLabel.font = [UIFont fontWithName:@"GillSans" size:14];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.tag = CellTagTitle;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configureWithTitle:(NSString*)title count:(NSInteger)count {
    self.titleLabel.frame = _titleFrame;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    NSString *textString = [NSString stringWithFormat:@"%lu",count];
    self.countLabel.text = [textString stringByAppendingString:@"."];
}

#pragma mark - Convenience
- (CGFloat)rightEdgeOfView:(UIView*)view {
    return (view.frame.origin.x + view.frame.size.width);
}

@end
