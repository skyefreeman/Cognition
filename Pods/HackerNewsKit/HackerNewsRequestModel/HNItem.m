//
//  HNItem.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItem.h"

@implementation HNItem

- (instancetype)init {
    return nil;
}

- (instancetype)initWithIdentifier:(NSInteger)identifier {
    self = [super init];
    if (!self || !identifier) return nil;
    
    self.identifier = identifier;
    
    return self;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) return nil;
    
    self.identifier = [aDecoder decodeIntegerForKey:@"identifier"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.by = [aDecoder decodeObjectForKey:@"by"];
    self.text = [aDecoder decodeObjectForKey:@"text"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.time = [aDecoder decodeIntegerForKey:@"time"];
    self.parent = [aDecoder decodeIntegerForKey:@"parent"];
    self.descendants = [aDecoder decodeIntegerForKey:@"descendants"];
    self.score = [aDecoder decodeIntegerForKey:@"score"];
    self.kids = [aDecoder decodeObjectForKey:@"kids"];
    self.parts = [aDecoder decodeObjectForKey:@"parts"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.by forKey:@"by"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.time forKey:@"time"];
    [aCoder encodeInteger:self.parent forKey:@"parent"];
    [aCoder encodeInteger:self.descendants forKey:@"descendants"];
    [aCoder encodeInteger:self.score forKey:@"score"];
    [aCoder encodeObject:self.kids forKey:@"kids"];
    [aCoder encodeObject:self.parts forKey:@"parts"];
}

@end
