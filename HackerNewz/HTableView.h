//
//  HTableView.h
//  HackerNewz
//
//  Created by Skye on 7/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTableViewDelegate
- (void)refreshControlActivated;
@end

@interface HTableView : UITableView
@property (nonatomic, weak) id <HTableViewDelegate> refreshdelegate;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) UILabel *backgroundLabel;

+ (instancetype)tableViewWithEstimatedRowHeight:(CGFloat)estHeight;
- (instancetype)initWithEstimatedRowHeight:(CGFloat)estHeight;

- (void)addBackgroundLabelWithText:(NSString *)text atCenter:(CGPoint)center;
- (void)reloadDataAnimated;
@end
