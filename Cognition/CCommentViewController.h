//
//  CCommentViewController.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CTableViewController.h"
@class HNItem;

@interface CCommentViewController : CTableViewController
- (instancetype)initWithItem:(HNItem*)item style:(UITableViewStyle)style;
@property (nonatomic, strong) HNItem *originalItem;
@end
