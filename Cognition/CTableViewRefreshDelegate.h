//
//  CTableViewRefreshDelegate.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTableViewRefreshDelegate <NSObject>
- (void)tableView:(UITableView*)tableView refreshControlTriggered:(UIRefreshControl*)refreshControl;
@end
