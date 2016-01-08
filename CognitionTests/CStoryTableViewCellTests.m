//
//  CStoryTableViewCellTests.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CStoryTableViewCell.h"
#import "CTableViewCellButtonDelegate.h"

@interface CStoryTableViewCellTests : XCTestCase <CTableViewCellButtonDelegate>
{
    CStoryTableViewCell *cell;
    BOOL commentButtonTapped;
}
@end

@implementation CStoryTableViewCellTests

- (void)setUp {
    [super setUp];
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerNib:[CStoryTableViewCell nib] forCellReuseIdentifier:[CStoryTableViewCell reuseIdentifier]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:[CStoryTableViewCell reuseIdentifier]];
    cell.delegate = self;
}

- (void)tearDown {
    cell = nil;
    
    [super tearDown];
}

- (void)testCellIsConfigured {
    [cell configureWithTitleText:@"title" infoLabelText:@"info" commentButtonTitle:@"commentTitle"];
    
    XCTAssertTrue([cell.titleLabel.text isEqualToString:@"title"], @"titleLabel not set");
    XCTAssertTrue([cell.infoLabel.text isEqualToString:@"info"], @"infoLabel not set");
    XCTAssertTrue([cell.commentButton.titleLabel.text isEqualToString:@"commentTitle"], @"commentButton.title not set");
}

- (void)testCommentButtonCallsDelegateWhenClicked {
    [cell.commentButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertTrue(commentButtonTapped, @"Comment button delegate method not called");
}

#pragma mark - CTableViewCellButtonDelegate
- (void)button:(UIButton *)aButton selectedWithCell:(UITableViewCell *)cell {
    commentButtonTapped = YES;
}

@end
