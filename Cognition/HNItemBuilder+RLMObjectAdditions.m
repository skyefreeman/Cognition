//
//  HNItemBuilder+RLMObjectAdditions.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder+RLMObjectAdditions.h"
#import "CItem.h"
#import <HNItem.h>

@implementation HNItemBuilder (RLMObjectAdditions)

+ (HNItem*)itemFromCItem:(CItem*)oldItem {
    HNItem *newItem = [[HNItem alloc] initWithIdentifier:oldItem.identifier];
    
    newItem.identifier = oldItem.identifier;
    newItem.type = [oldItem.type copy];
    newItem.by = [oldItem.by copy];
    newItem.url = [oldItem.url copy];
    newItem.title = [oldItem.title copy];
    
    newItem.time = oldItem.time;
    newItem.parent = oldItem.parent;
    newItem.descendants = oldItem.descendants;
    newItem.score = oldItem.score;
    
    newItem.kids = [HNItemBuilder arrayFromRLMArray:oldItem.kids];
    newItem.parts = [HNItemBuilder arrayFromRLMArray:oldItem.parts];
    
    return newItem;
}

#pragma mark - Private
+ (NSArray*)arrayFromRLMArray:(RLMArray*)oldArray {
    NSMutableArray *newArray = [NSMutableArray new];
    for (CItemKid *kid in oldArray) {
        NSNumber *identifier = [NSNumber numberWithInteger:kid.identifier];
        [newArray addObject:identifier];
    }
    return newArray;
}

@end
