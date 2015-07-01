//
//  HNewsCell.h
//  HackerNewz
//
//  Created by Skye on 6/28/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kHNewsCellReuseID;
extern CGFloat const kDefaultCellHeight;

@interface HNewsCell : UITableViewCell

- (void)configureWithTitle:(NSString*)title count:(NSInteger)count;

@end
