//
//  UITableViewController+Animation.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "UITableViewController+Animation.h"

// Libraries
#import <ObjectiveSugar.h>
#import <SFAdditions.h>
#import <JHChainableAnimations.h>

CGFloat const kAnimationOffsetDuration = 0.05;
CGFloat const kAnimationDuration = 0.5;

typedef void (^AnimationBlock)();

@implementation UITableViewController (Animation)

- (void)animateTableViewCellsIn {
    [self animateCellWithStartX:self.view.width endX:0];
}

- (void)animateTableViewCellsOut {
    [self animateCellWithStartX:0 endX:-self.view.width];
}

- (CGFloat)reloadAnimationTime {
    NSInteger cellCount = self.tableView.visibleCells.count - 1;
    return (kAnimationOffsetDuration * cellCount) + kAnimationDuration;
}

#pragma mark - Private
- (void)animateCellWithStartX:(CGFloat)startX endX:(CGFloat)endX {
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        [cell setFrame:CGRectMake(startX, cell.y, cell.width, cell.height)];
        cell.wait(kAnimationOffsetDuration*idx).makeOrigin(endX,cell.y).easeOutBack.animate(kAnimationDuration);
    }];
}

@end
