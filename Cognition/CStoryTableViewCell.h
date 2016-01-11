//
//  CTableViewCell.h
//  Cognition
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewCell.h"
#import "CTableViewCellButtonDelegate.h"

extern CGFloat const kStoryCellHeight;

@interface CStoryTableViewCell : CTableViewCell

@property (nonatomic, weak) id <CTableViewCellButtonDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

- (void)configureWithTitleText:(NSString*)titleText
                 infoLabelText:(NSString*)infoText
            commentButtonTitle:(NSString*)commentTitleText;

- (void)deactivateCommentButton;
@end
