//
//  CCommentViewController.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CCommentViewController.h"

// Models
#import "CItem.h"

// Libraries
#import <HackerNewsKit.h>

// Cells
#import "CCommentTableViewCell.h"

// View Models
#import "CCommentViewModel.h"

// Builders
#import "HNItemBuilder+RLMObjectAdditions.h"

@interface CCommentViewController() <UITableViewDelegate, HNManagerDelegate>
@property (nonatomic, strong) HNManager *manager;
@end

@implementation CCommentViewController

- (instancetype)initWithItem:(CItem *)item style:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self) return nil;
    
    self.originalItem = item;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleText:@"Comments"];
    
    [self _configureTableView];
    
    self.manager = [[HNManager alloc] init];
    self.manager.delegate = self;
    [self.manager fetchCommentsForItem:[HNItemBuilder itemFromCItem:self.originalItem]];
}

- (void)_configureTableView {
    TableViewCellConfigureBlock configBlock = ^void(CCommentTableViewCell *cell, CItem *item){
        CCommentViewModel *viewModel = [[CCommentViewModel alloc] initWithItem:item];
        [cell configureWithAuthor:viewModel.authorString time:viewModel.timeString comment:viewModel.commentString];
    };
    self.dataSource = [[CArrayDataSource alloc] initWithItems:@[]
                                               cellIdentifier:[CCommentTableViewCell reuseIdentifier]
                                           configureCellBlock:configBlock];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerNib:[CCommentTableViewCell nib] forCellReuseIdentifier:[CCommentTableViewCell reuseIdentifier]];
    
    [self.refreshControl removeFromSuperview];
    self.refreshControl = nil;
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
