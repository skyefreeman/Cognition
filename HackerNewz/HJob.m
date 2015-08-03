//
//  HJob.m
//  HackerNewz
//
//  Created by Skye on 8/3/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HJob.h"
#import "HConstants.h"

@implementation HJob

- (instancetype)initWithHNDictionary:(id)dictionary {
    self = [super init];
    if (self) {
        self.type = [dictionary objectForKey:kTypeKey];
        self.itemID = [[dictionary objectForKey:kIDKey] integerValue];
        self.url = [dictionary objectForKey:kURLKey];
        self.title = [dictionary objectForKey:kTitleKey];
        self.author = [dictionary objectForKey:kByKey];
        self.text = [dictionary objectForKey:kTextKey];
        self.score = [[dictionary objectForKey:kScoreKey] integerValue];
        self.time = [[dictionary objectForKey:kTimeKey] integerValue];
    }
    return self;
}

@end
