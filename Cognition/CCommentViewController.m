//
//  CCommentViewController.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CCommentViewController.h"

// Libraries
#import <HackerNewsKit.h>

// Cells
#import "CCommentTableViewCell.h"

// View Models
#import "CCommentViewModel.h"

@interface CCommentViewController() <UITableViewDelegate, HNManagerDelegate>
@property (nonatomic, strong) HNManager *manager;
@end

@implementation CCommentViewController
- (instancetype)initWithItem:(HNItem *)item style:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self) return nil;
    
    self.originalItem = item;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureTableView];
    
    self.manager = [[HNManager alloc] init];
    self.manager.delegate = self;
    [self.manager fetchCommentsForItem:self.originalItem];
}

- (void)_configureTableView {
    self.dataSource = [[CArrayDataSource alloc] initWithItems:@[] cellIdentifier:[CCommentTableViewCell reuseIdentifier] configureCellBlock:^(CCommentTableViewCell *cell, HNItem *item) {
        CCommentViewModel *viewModel = [[CCommentViewModel alloc] initWithItem:item];
        [cell configureWithAuthor:viewModel.authorString time:viewModel.timeString comment:viewModel.formattedComment];
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerNib:[CCommentTableViewCell nib] forCellReuseIdentifier:[CCommentTableViewCell reuseIdentifier]];
}

#pragma mark - HNManagerDelegate
- (void)didReceiveItemComments:(NSArray *)commentItems {
    self.dataSource.items = commentItems;
    [self.tableView reloadData];
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    [self errorAlert_checkInternetConnection];
    NSLog(@"%@",error);
}

@end
