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

@implementation SWTableViewCellBuilder
+ (NSArray*)storyRightUtilityButtons {
    NSMutableArray *rightButtons = [NSMutableArray new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"Save" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [button.layer setCornerRadius:kEdgePadding];
    [rightButtons addObject:button];
    
    return rightButtons;
}
@end
