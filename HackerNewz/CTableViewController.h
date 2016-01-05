//
//  CTableViewController.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ErrorAdditions.h"
#import "HArrayDataSource.h"
#import "CTableViewRefreshDelegate.h"

@interface CTableViewController : UITableViewController

/** @brief A custom data source for arrays. */
@property (nonatomic, strong) HArrayDataSource *dataSource;

/** @brief Refresh delegate */
@property (nonatomic, weak) id <CTableViewRefreshDelegate> refreshDelegate;

/** @brief Animates scrolling to the top of the table view. */
- (void)scrollToTop;

/** @brief Set the custom title label of the navigation bar. */
- (void)setTitleText:(NSString*)titleText;


@end
