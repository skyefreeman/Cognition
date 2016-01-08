//
//  HArrayDataSource.m
//  HackerNewz
//
//  Created by Skye on 12/6/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CArrayDataSource.h"

@interface CArrayDataSource()
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureBlock;

@end

@implementation CArrayDataSource

- (instancetype)init {
    return nil;
}

- (instancetype)initWithItems:(NSArray*)theItems cellIdentifier:(NSString*)aCellID configureCellBlock:(TableViewCellConfigureBlock)aConfigureBlock {
    self = [super init];
    if (!self) return nil;
    
    self.reuseIdentifier = aCellID;
    self.configureBlock = [aConfigureBlock copy];
    self.items = theItems;
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

#pragma mark - UITableView Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureBlock(cell, item);
    return cell;
}


@end
