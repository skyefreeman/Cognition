//
//  SWTableViewCellBuilder.m
//  Cognition
//
//  Created by Skye on 1/24/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "SWTableViewCellBuilder.h"
#import <SWTableViewCell.h>
#import "CConstants.h"
#import <SFAdditions.h>
#import "CAdditions.h"

@implementation SWTableViewCellBuilder
+ (NSArray*)storyRightUtilityButtons:(NSString*)title {
    NSMutableArray *rightButtons = [NSMutableArray new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setContentEdgeInsets:UIEdgeInsetsMake(8, 0, 0, 4)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [button.layer setCornerRadius:kEdgePadding];
    [rightButtons addObject:button];
    
    return rightButtons;
}
@end
