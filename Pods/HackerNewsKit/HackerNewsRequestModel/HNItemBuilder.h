//
//  HNItemBuilder.h
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HNItem;

extern NSString * ItemBuilderErrorDomain;

typedef NS_ENUM(NSInteger, ItemBuilderError) {
    ItemBuilderErrorInvalidJSON,
    ItemBuilderErrorInvalidArray,
    ItemBuilderErrorMissingData,
};

@interface HNItemBuilder : NSObject
- (NSArray*)itemsFromJSONArray:(NSArray*)itemArray error:(NSError **)error;
- (HNItem*)itemFromJSON:(NSString*)objectNotation error:(NSError **)error;
@end

@interface NSDictionary (HNItemBuilderAdditions)
- (BOOL)boolForKey:(NSString*)key;
- (NSInteger)integerForKey:(NSString*)key;
@end