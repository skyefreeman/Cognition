//
//  CTableViewController.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewController.h"
#import <SFAdditions.h>
#import "CAdditions.h"
#import "CArrayDataSource.h"
#import "CCustomTitleLabel.h"
#import "CTableViewRefreshDelegate.h"

@interface CTableViewController() <CCustomTitleLabelDelegate>
@property (nonatomic, strong) UILabel *backgroundLabel;
@property (nonatomic) CCustomTitleLabel *titleLabel;
@end

@implementation CTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureNavigationBar];
    [self configureTableView];
    [self.tableView reloadData];
}

- (void)configureTableView {
    self.clearsSelectionOnViewWillAppear = YES;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *backgroundView = [UIView backgroundViewWithFrame:CGRectMake(0, 0, self.view.width, self.view.height + [self statusBarHeight])];
    [self.tableView setBackgroundView:backgroundView];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.layer.zPosition = 1;
    self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.height);
}

- (void)configureNavigationBar {
    self.titleLabel = [[CCustomTitleLabel alloc] initWithFrame:self.navigationController.navigationBar.frame title:@""];
    self.titleLabel.delegate = self;
    [self.navigationItem setTitleView:self.titleLabel];
    
    // Weird hack to allow scroll to top
    for (UITextView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            view.scrollsToTop = NO;
        }
    }
}

#pragma mark - Public
- (void)scrollToTop {
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)setTitleText:(NSString*)titleText {
    [self.titleLabel setText:titleText];
    [self.titleLabel sizeToFit];
}

- (void)reloadTableWithItems:(NSArray *)items {
    if (items) {
        self.dataSource.items = items;
    }
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    [self scrollToTop];
}

#pragma mark - CCustomTitleLabelDelegate
- (void)customTitleLabelTouched:(id)sender {
    [self scrollToTop];
}


#pragma mark - Refresh Control actions
- (void)refreshValueChanged:(id)sender {
    if (self.refreshDelegate) [self.refreshDelegate tableView:self.tableView refreshControlTriggered:sender];
}

@end
