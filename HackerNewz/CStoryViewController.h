//
//  CStoryViewController.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewController.h"
@class HNManager;

@interface CStoryViewController : CTableViewController
@property (nonatomic, strong, readonly) HNManager *requestManager;
@end
