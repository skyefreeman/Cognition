//
//  HTableView.m
//  HackerNewz
//
//  Created by Skye on 7/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HTableView.h"

@implementation HTableView

- (instancetype)initWithFrame:(CGRect)frame estimatedRowHeight:(CGFloat)estHeight {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = estHeight;
    }
    return self;
}

@end
