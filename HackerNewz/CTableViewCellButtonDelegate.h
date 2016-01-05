//
//  Header.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

@protocol CTableViewCellButtonDelegate <NSObject>
- (void)button:(UIButton*)aButton selectedWithCell:(UITableViewCell*)cell;
@end
