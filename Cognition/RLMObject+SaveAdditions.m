//
//  RLMObject+SaveAdditions.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "RLMObject+SaveAdditions.h"

typedef void(^RealmBlock)();

@implementation RLMObject (CAdditions)
- (void)saveObject {
    [self _updateRealmObject:^{
        [self.defaultRealm addObject:self];
    }];
}

- (void)deleteObject {
    [self _updateRealmObject:^{
        [self.defaultRealm deleteObject:self];
    }];
}

- (void)_updateRealmObject:(RealmBlock)block {
    [self.defaultRealm beginWriteTransaction];
    block();
    [self.defaultRealm commitWriteTransaction];
}

- (RLMRealm*)defaultRealm {
    return [RLMRealm defaultRealm];
}

@end