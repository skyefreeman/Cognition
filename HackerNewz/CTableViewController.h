//
//  CTableViewController.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HArrayDataSource;

@interface CTableViewController : UITableViewController

/** @brief A custom data source for arrays. */
@property (nonatomic, strong) HArrayDataSource *dataSource;

/**
 * @brief Configures the navigation bar.  Called during viewDidLoad.
 * @warning Subclasses must caller [super configureNavigationBar] if overriding.
 */
- (void)configureNavigationBar;

/**
 * @brief Configures the tableView.  Called during viewDidLoad.
 * @warning Subclasses must caller [super configureTableView] if overriding.
 */
- (void)configureTableView;

/** @brief Animates scrolling to the top of the table view. */
- (void)scrollToTop;

/** @brief Set the custom title label of the navigation bar. */
- (void)setTitleText:(NSString*)titleText;

@end
