//
//  HCommentViewController.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCommentViewController.h"

// Datasource
#import "HArrayDataSource.h"

// Libraries
#import <HackerNewsKit.h>
#import "HNAdditions.h"
#import <TTTAttributedLabel.h>

// Views
#import "HTableView.h"
#import "CCommentTableViewCell.h"

@interface HCommentViewController() <UITableViewDelegate>
@property (nonatomic) HTableView *tableView;
@property (nonatomic) HArrayDataSource *dataSource;
@end

@implementation HCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView];
}

- (void)configureTableView {
    
//    self.dataSource = [[HArrayDataSource alloc] initWithItems:self.allComments cellIdentifier:[CCommentTableViewCell standardReuseIdentifier] configureCellBlock:^(CCommentTableViewCell *cell, HNItem *item) {
//        [cell configureWithAuthor:item.by time:item.time text:item.text];
//    }];
    
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kCommentCellHeight];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:[CCommentTableViewCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:[CCommentTableViewCell standardReuseIdentifier]];
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
