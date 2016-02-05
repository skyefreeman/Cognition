//
//  CRealmObjectBuilder.m
//  Cognition
//
//  Created by Skye on 2/1/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CRealmObjectBuilder.h"
#import "CItem.h"
#import <HNItem.h>
#import <ObjectiveSugar.h>

@implementation CRealmObjectBuilder
+ (CItem*)buildItemWithHNItem:(HNItem*)oldItem {
    CItem *newItem = [[CItem alloc] init];
    
    newItem.identifier = oldItem.identifier;
    newItem.type = [oldItem.type copy];
    newItem.by = [oldItem.by copy];
    newItem.url = [oldItem.url copy];
    newItem.title = [oldItem.title copy];
    
    newItem.time = oldItem.time;
    newItem.parent = oldItem.parent;
    newItem.descendants = oldItem.descendants;
    newItem.score = oldItem.score;
    
    [CRealmObjectBuilder addIdentifiersToRealmArray:newItem.kids fromNSArray:oldItem.kids];
    [CRealmObjectBuilder addIdentifiersToRealmArray:newItem.parts fromNSArray:oldItem.parts];
    
    return newItem;
}

+ (NSArray*)buildItemsWithHNItems:(NSArray*)oldItems {
    NSMutableArray *newItems = [NSMutableArray new];
    for (HNItem *item in oldItems) {
        NSAssert([item isKindOfClass:[HNItem class]], @"Only HNItem's are to be passed to builder.");
        [newItems addObject:[CRealmObjectBuilder buildItemWithHNItem:item]];
    }
    return newItems;
}

#pragma mark - Private
+ (void)addIdentifiersToRealmArray:(RLMArray*)realmArray fromNSArray:(NSArray*)nsArray {
    for (NSNumber *identifier in nsArray) {
        CItemKid *kid = [[CItemKid alloc] initWithIdentifier:identifier.integerValue];
        [realmArray addObject:kid];
    }
}

@end
