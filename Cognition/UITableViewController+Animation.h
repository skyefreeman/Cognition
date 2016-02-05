//
//  UITableViewController+Animation.h
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewController (Animation)
@property (nonatomic, readonly) CGFloat reloadAnimationTime;
- (void)animateTableViewCellsIn;
- (void)animateTableViewCellsOut;
@end
