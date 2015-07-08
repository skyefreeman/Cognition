//
//  HTopStoryCell.h
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kTopStoryReuseIdentifier;
extern CGFloat const kTopStoryCellHeight;

@interface HTopStoryCell : UITableViewCell
- (void)configureWithTitle:(NSString*)title count:(NSInteger)count;
@end
