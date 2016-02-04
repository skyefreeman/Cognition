//
//  RLMResults+ConvenienceAdditions.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "RLMResults+Convenience.h"
#import "CItem.h"

@implementation RLMResults (Convenience)
+ (NSArray*)allCItems {
    RLMResults *results = [CItem allObjects];
    NSMutableArray *temp = [NSMutableArray new];
    for (CItem *item in results) {
        [temp addObject:item];
    }
    return temp;
}
@end
