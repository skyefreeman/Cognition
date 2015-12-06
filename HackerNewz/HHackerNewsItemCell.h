//
//  HTopStoryCell.h
//  HackerNewz
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kNewsItemReuseIdentifier;
extern CGFloat const kTopStoryCellHeight;

@protocol HHackerNewsItemCellDelegate
- (void)commentButtonTapped:(id)sender;
@end

@interface HHackerNewsItemCell : UITableViewCell

@property (nonatomic, weak) id <HHackerNewsItemCellDelegate> delegate;

- (void)configureWithTitle:(NSString*)title
                    points:(NSInteger)points
                    author:(NSString*)author
                      time:(NSInteger)time
                  comments:(NSInteger)comments;

+ (UINib*)nib;
@end
