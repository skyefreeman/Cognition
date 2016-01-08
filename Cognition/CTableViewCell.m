//
//  CTableViewCell.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewCell.h"

@implementation CTableViewCell
+ (UINib*)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (NSString*)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
