//
//  HNItemBuilder+RLMObjectAdditions.h
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder.h"
@class CItem;

@interface HNItemBuilder (RLMObjectAdditions)
+ (HNItem*)itemFromCItem:(CItem*)oldItem;
@end
