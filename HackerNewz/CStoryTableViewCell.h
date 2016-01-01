//
//  CTableViewCell.h
//  Cognition
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewCell.h"

extern CGFloat const kStoryCellHeight;

@protocol CStoryTableViewCellDelegate
- (void)commentButtonTapped:(id)sender;
@end

@interface CStoryTableViewCell : CTableViewCell

@property (nonatomic, weak) id <CStoryTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

- (void)configureWithTitleText:(NSString*)titleText
                 infoLabelText:(NSString*)infoText
            commentButtonTitle:(NSString*)commentTitleText;
@end
