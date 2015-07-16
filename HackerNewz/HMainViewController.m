//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"
#import "HWebLinkViewController.h"
#import "HCommentViewController.h"

#import <SFAdditions.h>
#import "NSObject+HNAdditions.h"
#import "UIColor+HNAdditions.h"

#import "HHackerNewsItemCell.h"
#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItem.h"

@interface HMainViewController () <UITableViewDataSource,UITableViewDelegate,HHackerNewsItemCellDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIRefreshControl *refreshControl;

@property (nonatomic) NSMutableArray *topStories;
@property (nonatomic) HHackerNewsRequestModel *requestModel;
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Top Stories"];
    
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = kTopStoryCellHeight;
    [self.view addSubview:self.tableView];
    
    [self registerNibs];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor HNOrange];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(requestTopStories) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

    [self requestTopStories];
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HHackerNewsItemCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:kNewsItemReuseIdentifier];
}

#pragma mark - Requests
- (void)requestTopStories {
    if (!self.requestModel) {
        self.requestModel = [[HHackerNewsRequestModel alloc] init];
    }

    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        [self.refreshControl endRefreshing];
        
        
        if (success) [self.tableView reloadData];
        else [self handleError:error];
        
    }];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error {
    [self showAlertWithTitle:@"Error" message:@"Problem getting stories. Check your internet connection."];
    NSLog(@"%@",error);
}

#pragma mark - UITableView Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.requestModel.allStories.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHackerNewsItem *item = (HHackerNewsItem*)[self.requestModel.allStories objectAtIndex:indexPath.row];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:kNewsItemReuseIdentifier];
    [cell setDelegate:self];
    [cell configureWithTitle:item.title points:item.score author:item.author time:item.time comments:item.commentCount];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHackerNewsItem *item = [self itemAtIndexPath:indexPath];
    
    if (![item.url isNotEmptyString]) {
        [self showAlertWithTitle:@"Error" message:@"No URL for item"];
        return;
    }
    
    [self pushToWebLinkViewController:[NSURL URLWithString:item.url]];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - HHackerNewsItemCell Delegate Methods
- (void)commentBubbleTapped:(id)sender {
    [self pushToCommentViewController];
    
    HHackerNewsItemCell *cell = (HHackerNewsItemCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Load comments for news item
    HHackerNewsItem *item = [self.requestModel.allStories objectAtIndex:indexPath.row];
    [self.requestModel getCommentsForItem:item completion:^(id comments, NSError *error) {
        if (comments) {
            NSLog(@"%@",comments);
        } else {
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - View Controller Navigation
- (void)pushToWebLinkViewController:(NSURL*)linkURL {
    HWebLinkViewController *webVC = [[HWebLinkViewController alloc] init];
    [webVC setLinkURL:linkURL];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)pushToCommentViewController {
    HCommentViewController *commentVC = [[HCommentViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - Convenience
- (HHackerNewsItem*)itemAtIndexPath:(NSIndexPath*)indexPath {
    return (HHackerNewsItem*)[self.requestModel.allStories objectAtIndex:indexPath.row];
}

@end
