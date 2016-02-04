//
//  CRealmTests.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RLMObject+SaveAdditions.h"
#import "CItem.h"

@interface CRealmTests : XCTestCase
@end

@implementation CRealmTests
- (void)testRealmSaveAdditionsSave {
    CItem *item = [CItem new];
    item.identifier = 123;
    [item saveObject];
    
    CItem *savedItem = [self _testObjects].firstObject;
    XCTAssertTrue(savedItem.identifier == 123, @"RLMObject did not save");
}

- (void)testRealmSaveAdditionsDelete {
    RLMResults *results = [CItem objectsWhere:@"identifier == 123"];
    for (CItem *item in results) {
        [item deleteObject];
    }
    XCTAssertTrue([self _testObjects].count == 0);
}

// Helpers
- (RLMResults*)_testObjects {
    return [CItem objectsWhere:@"identifier == 123"];
}

@end