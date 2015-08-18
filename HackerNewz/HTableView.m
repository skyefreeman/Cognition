//
//  HTableView.m
//  HackerNewz
//
//  Created by Skye on 7/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HTableView.h"
#import "UIColor+HNAdditions.h"

@interface HTableView()

@end

@implementation HTableView

+ (instancetype)tableViewWithEstimatedRowHeight:(CGFloat)estHeight {
    return [[self alloc] initWithEstimatedRowHeight:estHeight];
}

- (instancetype)initWithEstimatedRowHeight:(CGFloat)estHeight {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = estHeight;
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor HNLightGray];
        self.refreshControl.tintColor = [UIColor HNOrange];
        [self.refreshControl addTarget:self action:@selector(refreshControlActivated) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.refreshControl];
    }
    return self;
}

- (void)refreshControlActivated {
    [self.refreshdelegate refreshControlActivated];
}

@end
