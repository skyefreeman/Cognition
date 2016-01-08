//
//  CTableViewCell.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTableViewCell : UITableViewCell
+ (UINib*)nib;
+ (NSString*)reuseIdentifier;
@end
