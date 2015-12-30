//
//  HCommentViewController.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCommentViewController.h"

// Libraries
#import "HackerNewsKit.h"
#import "HNAdditions.h"

// Views
#import "HTableView.h"
#import "HCommentCell.h"

@interface HCommentViewController() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) HTableView *tableView;
@end

@implementation HCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kCommentCellHeight];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    
    [self registerNibs];
    [self.tableView reloadData];
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HCommentCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:[HCommentCell standardReuseIdentifier]];
}

#pragma mark - UITableView Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allComments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNItem *item = [self.allComments objectAtIndex:indexPath.row];
    
    id cell = [self.tableView dequeueReusableCellWithIdentifier:[HCommentCell standardReuseIdentifier]];
    [cell configureWithAuthor:item.by time:item.time text:item.text];
    return nil;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
