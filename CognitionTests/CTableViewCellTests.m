//
//  CTableViewCellTests.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CTableViewCell.h"

@interface CTableViewCellTests : XCTestCase
{
    CTableViewCell *cell;
}

@end

@implementation CTableViewCellTests

- (void)setUp {
    [super setUp];
    cell = [[CTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseID"];
}

- (void)tearDown {
    cell = nil;
    [super tearDown];
}

- (void)testNibClassMethodReturnsANib {
    XCTAssertNotNil([CTableViewCell nib],@"Nib needs to exist");
}

- (void)testReuseIdentifierIsClassName {
    XCTAssertTrue([[CTableViewCell reuseIdentifier] isEqualToString:@"CTableViewCell"],@"reuseIdentifier is not equivelent to class string");
}
@end
