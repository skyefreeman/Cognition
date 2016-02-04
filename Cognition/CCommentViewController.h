//
//  CCommentViewController.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CTableViewController.h"
@class CItem;

@interface CCommentViewController : CTableViewController
- (instancetype)initWithItem:(CItem*)item style:(UITableViewStyle)style;
@property (nonatomic, strong) CItem *originalItem;
@end
