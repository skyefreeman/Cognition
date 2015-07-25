//
//  HTableView.h
//  HackerNewz
//
//  Created by Skye on 7/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTableView : UITableView
+ (instancetype)tableViewWithEstimatedRowHeight:(CGFloat)estHeight;
- (instancetype)initWithEstimatedRowHeight:(CGFloat)estHeight;
@end