//
//  HHackerNewsItem.m
//  HackerNewz
//
//  Created by Skye on 6/28/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsItem.h"

NSString * const kIDKey = @"id";
NSString * const kTitleKey = @"title";
NSString * const kTypeKey = @"type";
NSString * const kURLKey = @"url";
NSString * const kTextKey = @"text";
NSString * const kDescendantsKey = @"descendants";
NSString * const kKidsKey = @"kids";
NSString * const kScoreKey = @"score";
NSString * const kTimeKey = @"time";

@implementation HHackerNewsItem

- (instancetype)initWithHNDictionary:(id)dictionary {
    self = [super init];
    if (self) {
        self.ID = [[dictionary objectForKey:kIDKey] integerValue];
        self.title = [dictionary objectForKey:kTitleKey];
        self.type = [dictionary objectForKey:kTypeKey];
        self.url = [dictionary objectForKey:kURLKey];
        self.text = [dictionary objectForKey:kTextKey];
        self.commentCount = [[dictionary objectForKey:kDescendantsKey] integerValue];
        self.comments = [dictionary objectForKey:kKidsKey];
        self.score = [[dictionary objectForKey:kScoreKey] integerValue];
        self.time = [[dictionary objectForKey:kTimeKey] integerValue];
    }
    return self;
}

+ (instancetype)itemWithHNDictionary:(id)dictionary {
    return [[self alloc] initWithHNDictionary:dictionary];
}

@end
