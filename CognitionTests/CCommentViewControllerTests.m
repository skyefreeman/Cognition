//
//  CCommentViewControllerTests.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "XCTestCase+MockAdditions.h"
#import "CCommentViewController.h"
#import <HackerNewsKit.h>

@interface CCommentViewControllerTests : XCTestCase
@end

@implementation CCommentViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCommentsInitializedWithAnIterm {
    CCommentViewController *vc = [[CCommentViewController alloc] initWithItem:[[HNItem alloc] initWithIdentifier:123] style:UITableViewStylePlain];
    XCTAssertNotNil(vc.originalItem, @"HNItem is not stored at init");
}

@end
