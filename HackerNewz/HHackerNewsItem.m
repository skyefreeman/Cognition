//
//  HHackerNewsItem.m
//  HackerNewz
//
//  Created by Skye on 6/28/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItem.h"
#import "HConstants.h"

@implementation HHackerNewsItem

+ (instancetype)itemWithHNDictionary:(id)dictionary {
    return [[self alloc] initWithHNDictionary:dictionary];
}

- (instancetype)initWithHNDictionary:(id)dictionary {
    self = [super init];
    if (self) {
    }
    return self;
}


@end
