//
//  CCreditView.m
//  Cognition
//
//  Created by Skye on 1/14/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CCreditView.h"
#import "CAdditions.h"
#import "CConstants.h"

@interface CCreditView()
@property (nonatomic, strong) UIView *frameView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *githubButton;
@property (nonatomic, strong) UIButton *twitterButton;
@property (nonatomic, strong) UIButton *websiteButton;
@end

@implementation CCreditView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    CGFloat framePadding = self.frame.size.width/10;
    
    self.frameView = [[UIView alloc] initWithFrame:CGRectMake(kEdgePadding, kEdgePadding, self.frame.size.width - kEdgePadding * 2, self.frame.size.height - kEdgePadding * 2)];
    self.frameView.backgroundColor = [UIColor clearColor];
    self.frameView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.frameView.layer.borderWidth = 1;
    self.frameView.layer.cornerRadius = kCornerRadius*2;
    [self addSubview:self.frameView];
    
    CGSize labelSize = CGSizeMake(_frameView.frame.size.width - framePadding*2, _frameView.frame.size.height/4);
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_frameView.frame.origin.x + framePadding,
                                                               _frameView.frame.origin.y + framePadding,
                                                               labelSize.width,
                                                               labelSize.height)];
    self.nameLabel.font = [UIFont CFont:14];
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.minimumScaleFactor = 0.6;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"Skye Freeman";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    CGFloat buttonWidth = self.frameView.frame.size.width/4;

    self.githubButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.githubButton setImage:[UIImage imageNamed:@"octocat_image"] forState:UIControlStateNormal];
//    CGSize githubSize = [self _scaledSizeForImageView:self.githubButton width:buttonWidth];
//    self.githubButton.frame = CGRectMake(0, 0, githubSize.width, githubSize.height);
//    self.githubButton.center = CGPointMake(self.center.x - self.githubButton.frame.size.width, self.center.y);
//    self.githubButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.githubButton];
    NSLog(@"%@",self.githubButton);
    
    self.twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.twitterButton setImage:[UIImage imageNamed:@"twitter_image"] forState:UIControlStateNormal];
//    CGSize twitterSize = [self _scaledSizeForImageView:self.twitterButton width:buttonWidth];
//    self.twitterButton.frame = CGRectMake(0, 0, twitterSize.width, twitterSize.height);
//    self.twitterButton.center = CGPointMake(self.center.x + self.twitterButton.frame.size.width, self.center.y);
    [self addSubview:self.twitterButton];
    NSLog(@"%@",self.twitterButton);
    
    self.websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.websiteButton.frame = CGRectMake(_frameView.frame.origin.x + framePadding,
                                          _frameView.frame.origin.y + _frameView.frame.size.height/4 * 3 - labelSize.height/2,
                                          labelSize.width,
                                          labelSize.height);
    self.websiteButton.backgroundColor = [UIColor clearColor];
    self.websiteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.websiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.websiteButton setTitleColor:[UIColor colorWithWhite:1.000 alpha:0.600] forState:UIControlStateHighlighted];
    [self.websiteButton setTitle:@"skyefreeman.io" forState:UIControlStateNormal];
    [self addSubview:self.websiteButton];
    
    return self;
}

#pragma mark - Private methods
- (CGSize)_scaledSizeForImageView:(UIButton*)button width:(CGFloat)newWidth {
    CGFloat dimensionDiff = button.frame.size.width/newWidth;
    return CGSizeMake(newWidth, button.frame.size.height/dimensionDiff);
}

@end
