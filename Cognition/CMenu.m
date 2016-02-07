//
//  CMenu.m
//  Cognition
//
//  Created by Skye on 1/10/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CMenu.h"
#import "CCreditView.h"
#import <SFAdditions.h>

@implementation CMenu

- (instancetype)initWithStyle:(SFSlideOutMenuStyle)style {
    self = [super initWithStyle:style];
    if (!self) return nil;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = self.container.bounds;
    [self.container addSubview:blurView];
    
    self.buttonTitles = @[@"top stories", @"new stories", @"ask stories", @"show stories", @"job stories",@"saved stories"];
    self.buttonSpacing = 5.0;
    self.buttonHeight = 40;
    self.buttonWidth = self.container.width - 10;
    self.buttonCornerRadius = self.buttonHeight/2;
    self.buttonBackgroundColor = [UIColor colorWithWhite:0.000 alpha:0.300];
    self.buttonTitleColor = [self _titleColor];
    self.buttonFont = [UIFont systemFontOfSize:15];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, 65)];
    self.headerView.backgroundColor = [UIColor clearColor];
    
    self.creditView = [[CCreditView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.width)];
    self.footerView = self.creditView;
    
    UILabel *creditLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    creditLabel.textColor = [UIColor whiteColor];
    creditLabel.textAlignment = NSTextAlignmentCenter;
    creditLabel.text = @"Designed /\n Developed By:";
    creditLabel.numberOfLines = 2;
    creditLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [creditLabel sizeToFit];
    creditLabel.center = CGPointMake(self.footerView.center.x, self.creditView.y - creditLabel.height/2);
    [self.container addSubview:creditLabel];
    
    self.animationDuration = 0.3;
    
    return self;
}

#pragma mark - Public methods
- (void)setActiveButton:(MenuButton)activeButton {
    _activeButton = activeButton;
    
    for (UIButton *button in self.container.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        [button setTitleColor:[self _titleColor] forState:UIControlStateNormal];
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    
    UIButton *aButton = [self.container viewWithTag:activeButton];
    [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [aButton.layer setBorderWidth:1];
}

- (void)toggleTopStoryButton {
    BOOL foundButton = NO;
    NSInteger subviewIndex = 0;
    while (subviewIndex < self.container.subviews.count && foundButton == NO) {
        id buttonView = self.container.subviews[subviewIndex];
        if ([buttonView isKindOfClass:[UIButton class]]) {
            [buttonView sendActionsForControlEvents:UIControlEventTouchUpInside];
            foundButton = YES;
        }
        subviewIndex++;
    }
}

#pragma mark - Private methods
- (UIColor*)_titleColor {
    return [UIColor colorWithWhite:1.000 alpha:0.700];
}

@end
