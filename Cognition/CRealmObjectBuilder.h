//
//  CRealmObjectBuilder.h
//  Cognition
//
//  Created by Skye on 2/1/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CItem;
@class HNItem;

@interface CRealmObjectBuilder : NSObject
+ (CItem*)buildItemWithHNItem:(HNItem*)oldItem;
+ (NSArray*)buildItemsWithHNItems:(NSArray*)oldItems;
@end
