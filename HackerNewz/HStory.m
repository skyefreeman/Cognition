//
//  HStory.m
//  HackerNewz
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HStory.h"
#import "HConstants.h"

@implementation HStory

- (instancetype)initWithHNDictionary:(id)dictionary {
    self = [super init];
    if (self) {
        self.type = [dictionary objectForKey:kTypeKey];
        self.itemID = [[dictionary objectForKey:kIDKey] integerValue];
        self.url = [dictionary objectForKey:kURLKey];
        self.title = [dictionary objectForKey:kTitleKey];
        self.author = [dictionary objectForKey:kByKey];
        self.type = [dictionary objectForKey:kTypeKey];
        self.text = [dictionary objectForKey:kTextKey];
        self.commentCount = [[dictionary objectForKey:kDescendantsKey] integerValue];
        self.comments = [dictionary objectForKey:kKidsKey];
        self.score = [[dictionary objectForKey:kScoreKey] integerValue];
        self.time = [[dictionary objectForKey:kTimeKey] integerValue];
    }
    return self;
}

@end
