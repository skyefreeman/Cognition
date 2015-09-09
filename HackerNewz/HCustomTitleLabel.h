//
//  HNavigationBarTitleLabel.h
//  HackerNewz
//
//  Created by Skye on 9/8/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCustomTitleLabelDelegate <NSObject>
- (void)customTitleLabelTouched;
@end

@interface HCustomTitleLabel : UILabel
@property (nonatomic, weak) id <HCustomTitleLabelDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
@end
