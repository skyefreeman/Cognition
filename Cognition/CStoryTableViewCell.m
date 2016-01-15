//
//  CTableViewCell.m
//  Cognition
//
//  Created by Skye on 7/7/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CStoryTableViewCell.h"

#import "CConstants.h"
#import "CAdditions.h"

CGFloat const kStoryCellHeight = 50;

@interface CStoryTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *background;
@end

@implementation CStoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.background.layer.cornerRadius = kCornerRadius;

    self.commentButton.titleLabel.font = [UIFont CFont:16];
    self.commentButton.layer.cornerRadius = self.commentButton.frame.size.width/2;
    self.commentButton.layer.borderWidth = 1;
    self.commentButton.layer.borderColor = [UIColor CBlue].CGColor;
    [self.commentButton addTarget:self action:@selector(_commentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Overridden Methods
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) self.background.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.600];
    else self.background.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Public Methods
- (void)configureWithTitleText:(NSString*)titleText
                 infoLabelText:(NSString*)infoText
                  urlLabelText:(NSString *)urlText
            commentButtonTitle:(NSString*)commentTitleText
{
    self.titleLabel.text = titleText;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.urlLabel.text = urlText;
    self.infoLabel.text = infoText;
    
    [self.commentButton setTitle:commentTitleText forState:UIControlStateNormal];
    [self _activateCommentButton];
    
    [self layoutIfNeeded];
}

- (void)deactivateCommentButton {
    [self.commentButton setUserInteractionEnabled:NO];
    self.commentButton.layer.borderColor = [UIColor CLightGray].CGColor;
    self.commentButton.tintColor = [UIColor CLightGray];
}

#pragma mark - Private Methods
- (void)_commentButtonTapped:(id)sender {
    if (self.delegate) [self.delegate button:sender selectedWithCell:self];
}

- (void)_activateCommentButton {
    [self.commentButton setUserInteractionEnabled:YES];
    self.commentButton.layer.borderColor = [UIColor CBlue].CGColor;
    self.commentButton.tintColor = [UIColor CBlue];
}

@end
