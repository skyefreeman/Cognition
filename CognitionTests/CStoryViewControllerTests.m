//
//  CStoryViewControllerTests.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "XCTestCase+MockAdditions.h"
#import <SafariServices/SafariServices.h>

#import "CStoryViewController.h"

#import "CArrayDataSource.h"
#import <HackerNewsKit.h>


@interface CStoryViewControllerTests : XCTestCase <UITableViewDelegate>

@end

@implementation CStoryViewControllerTests {
    CStoryViewController *viewController;
}

- (void)setUp {
    [super setUp];
    viewController = [[CStoryViewController alloc] init];
    [viewController viewDidLoad];
}

- (void)tearDown {
    viewController = nil;
    [super tearDown];
}

- (void)testDataSourceIsCreatedAfterViewDidLoad {
    XCTAssertNotNil(viewController.dataSource, @"Data source should be created after viewDidLoad");
}

- (void)testTableDelegateAndDataSourceAreSetAfterViewDidLoad {
    XCTAssertNotNil(viewController.tableView.delegate, @"Delegate should be set after viewDidLoad");
    XCTAssertNotNil(viewController.tableView.dataSource, @"Data source should be set after viewDidLoad");
}

- (void)testDataSourceItemsAreEmptyAfterViewDidLoad {
    XCTAssertTrue(viewController.dataSource.items.count == 0, @"Data source is not empty after viewDidLoad");
}

- (void)testRequestManagerSetInViewDidLoad {
    XCTAssertNotNil(viewController.requestManager, @"Request manager not set in viewDidLoad");
}

- (void)testRequestManagerSetItsDelegate {
    XCTAssertNotNil(viewController.requestManager.delegate, @"the request manager's delegate isnt set");
}

@end