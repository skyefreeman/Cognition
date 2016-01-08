//
//  CCommentTableViewCell.h
//  Cognition
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewCell.h"

extern CGFloat const kCommentCellHeight;

@interface CCommentTableViewCell : CTableViewCell
- (void)configureWithAuthor:(NSString*)author
                       time:(NSString*)timeString
                    comment:(NSString*)commentString;
@end
