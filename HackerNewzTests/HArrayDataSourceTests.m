//
//  HArrayDataSourceTests.m
//  HackerNewz
//
//  Created by Skye on 12/6/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HArrayDataSource.h"

@interface HArrayDataSourceTests : XCTestCase
@end

@implementation HArrayDataSourceTests
{
    HArrayDataSource *dataSource;
}

- (void)setUp {
    [super setUp];
    
    __block UITableViewCell *testCell;
    __block NSString *testItem;
    TableViewCellConfigureBlock block = ^(UITableViewCell *cell, NSString *item){
        testCell = cell;
        testItem = item;
    };
    dataSource = [[HArrayDataSource alloc] initWithItems:@[@"a",@"b"] cellIdentifier:@"cellID" configureCellBlock:block];
}

- (void)tearDown {
    dataSource = nil;
    [super tearDown];
}

- (void)testInitializing {
    XCTAssertNil([[HArrayDataSource alloc] init], @"Should not be allowed");
    XCTAssertNotNil(dataSource);
}

- (void)testItemAtIndexPath {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    XCTAssertTrue([[dataSource itemAtIndexPath:indexPath] isEqualToString:@"a"], @"Should map correctly passed in array");
}
@end
