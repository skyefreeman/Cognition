//
//  HArrayDataSource.h
//  HackerNewz
//
//  Created by Skye on 12/6/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface CArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray*)items
               cellIdentifier:(NSString*)aCellID
           configureCellBlock:(TableViewCellConfigureBlock)aConfigureBlock;

- (id)itemAtIndexPath:(NSIndexPath*)indexPath;

@end
