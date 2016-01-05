//
//  CCommentViewModelTests.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "XCTestCase+MockAdditions.h"
#import <HackerNewsKit.h>
#import "CCommentViewModel.h"

@interface CCommentViewModelTests : XCTestCase
{
    CCommentViewModel *viewModel;
}
@end

@implementation CCommentViewModelTests

- (void)setUp {
    [super setUp];
    
    HNItem *item = [[HNItem alloc] initWithIdentifier:123];
    item.by = @"author";
    item.text = @"formatted text";
    item.time = [[NSDate date] timeIntervalSince1970];
    viewModel = [[CCommentViewModel alloc] initWithItem:item];
}

- (void)tearDown {
    viewModel = nil;
    [super tearDown];
}

- (void)testInitCannotBeCalled {
    XCTAssertNil([[CCommentViewModel alloc] init], @"Must use custom init");
}

- (void)testInitializesCorrectly {
    XCTAssertNotNil(viewModel, @"Needs to be initialized");
}

- (void)testStoresItemInInit {
    XCTAssertNotNil(viewModel.item, @"HNIterm not stored in init");
}

- (void)testAuthorFormattedCorrectly {
    BOOL equalStrings = [viewModel.authorString isEqualToString:@"by author"];
    XCTAssertTrue(equalStrings, @"Author string not formatted correctly");
}

- (void)testCommentFormattedCorrectly {
    BOOL equalStrings = [viewModel.formattedComment isEqualToAttributedString:[[NSAttributedString alloc] initWithString:@"formatted text"]];
    XCTAssertTrue(equalStrings, @"Comment string not formatted correctly");
}

- (void)testTimeFormattedCorrectly {
    BOOL equalStrings = [viewModel.timeString isEqualToString:@"just now"];
    XCTAssertTrue(equalStrings, @"Time string not formatted correctly");
}
@end
