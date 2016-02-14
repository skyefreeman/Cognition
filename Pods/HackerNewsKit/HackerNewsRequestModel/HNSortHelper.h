//
//  HNSortHelper.h
//  HackerNewsKit
//
//  Created by Skye on 2/6/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNSortHelper : NSObject
/** @brief Sorts items to match order of identifiers */
+ (NSArray*)sortHNItems:(NSArray*)items toMatchIdentifiers:(NSArray*)identifiers;

/** @brief Sorts items time descending */
+ (NSArray*)sortHNItems:(NSArray *)items;
@end
