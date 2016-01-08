//
//  CTableViewControllerTests.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CInspectableTableViewController.h"

@interface CTableViewControllerTests : XCTestCase
@end

@implementation CTableViewControllerTests
{
    CInspectableTableViewController *viewController;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewControllerCallsConfigureDataSource {
    viewController = [[CInspectableTableViewController alloc] init];
    [viewController viewDidLoad];
    XCTAssertTrue(viewController.configureTableViewCalled, @"The data source should be set by the end of viewDidLoad");
}


@end
