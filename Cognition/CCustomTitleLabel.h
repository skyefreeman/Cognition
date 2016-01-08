//
//  CCustomTitleLabel.h
//  Cognition
//
//  Created by Skye on 9/8/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCustomTitleLabelDelegate <NSObject>
- (void)customTitleLabelTouched:(id)sender;
@end

@interface CCustomTitleLabel : UILabel
@property (nonatomic, weak) id <CCustomTitleLabelDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
@end
