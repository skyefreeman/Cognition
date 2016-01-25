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

@property (nonatomic, weak) id <CTableViewCellButtonDelegate> storyCellDelegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;

- (void)configureWithTitleText:(NSString*)titleText
                 infoLabelText:(NSString*)infoText
                 urlLabelText:(NSString*)urlText
            commentButtonTitle:(NSString*)commentTitleText;

- (void)deactivateCommentButton;
@end
