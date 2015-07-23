//
//  HCommentCell.h
//  HackerNewz
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kCommentCellHeight;

@interface HCommentCell : UITableViewCell
- (void)configureWithAuthor:(NSString*)author time:(NSInteger)time text:(NSAttributedString*)text;
@end
