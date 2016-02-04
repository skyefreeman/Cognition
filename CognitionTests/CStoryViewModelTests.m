//
//  CStoryViewModelTests.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CStoryViewModel.h"
#import "CItem.h"

@interface CStoryViewModelTests : XCTestCase
{
    CStoryViewModel *viewModel;
    CItem *item;
}
@end

@implementation CStoryViewModelTests

- (void)setUp {
    [super setUp];
    
    item = [CItem new];
    item.identifier = 123;
    item.by = @"testAuthor";
    item.time = NSTimeIntervalSince1970;
    item.descendants = 1;
    item.score = 2;
    
    viewModel = [[CStoryViewModel alloc] initWithCItem:item];
}

- (void)tearDown {
    viewModel = nil;
    item = nil;
    [super tearDown];
}

- (void)testInitNotAllowed {
    XCTAssertNil([[CStoryViewModel alloc] init], @"Cannot use standard init");
}

- (void)testStoredOriginalItem {
    XCTAssertEqualObjects(item, viewModel.originalItem, @"Original item not stored during init");
}

- (void)testCommentCountStringCreatedCorrectly {
    XCTAssertTrue([viewModel.commentCountString isEqualToString:@"1"],@"Comment string not formatted correctly");

    item.descendants = 0;
    viewModel = [[CStoryViewModel alloc] initWithCItem:item];
    XCTAssertTrue([viewModel.commentCountString isEqualToString:@"0"],@"Comment string not formatted correctly");

    item.descendants = 2;
    viewModel = [[CStoryViewModel alloc] initWithCItem:item];
    XCTAssertTrue([viewModel.commentCountString isEqualToString:@"2"],@"Comment string not formatted correctly");
}

@end
