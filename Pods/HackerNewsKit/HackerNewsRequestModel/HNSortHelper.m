//
//  HNSortHelper.m
//  HackerNewsKit
//
//  Created by Skye on 2/6/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "HNSortHelper.h"
#import "HNItem.h"

@implementation HNSortHelper

+ (NSArray*)sortHNItems:(NSArray*)items toMatchIdentifiers:(NSArray*)identifiers {
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    for (HNItem *item in items) {
        for (int i = 0; i < identifiers.count; i++) {
            NSInteger identifier = [identifiers[i] integerValue];
            if (item.identifier == identifier) {
                [tempDict setObject:item forKey:@(i)];
            }
        }
    }
    
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSNumber *key in tempDict) {
        [tempArray addObject:tempDict[key]];
    }

    return tempArray;
}

+ (NSArray*)sortHNItems:(NSArray *)items {
    return [items sortedArrayUsingComparator:^NSComparisonResult(HNItem *obj1, HNItem *obj2) {
        return [@(obj2.identifier) compare:@(obj1.identifier)];
    }];
}
@end
