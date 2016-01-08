//
//  CStoryViewController.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CStoryViewController.h"
#import "CCommentViewController.h"
#import <SafariServices/SafariServices.h>

// Libaries
#import <SFAdditions.h>
#import <HackerNewsKit.h>

// Views
#import "CStoryTableViewCell.h"

// View Models
#import "CStoryViewModel.h"

// Protocols
#import "CTableViewCellButtonDelegate.h"

@interface CStoryViewController() <UITableViewDelegate, HNManagerDelegate, CTableViewCellButtonDelegate, CTableViewRefreshDelegate>
@property (nonatomic, strong, readwrite) HNManager *requestManager;
@end

@implementation CStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configureTableView];
    [self _configureNavigationBar];
    
    NSLog(@"Fetch Type: %lu", [self.requestManager getFetchType]);
    
    self.requestManager = [[HNManager alloc] init];
    [self.requestManager setDelegate:self];
    [self.requestManager fetchTopStories];
    
    NSLog(@"Fetch Type: %lu", [self.requestManager getFetchType]);
}

- (void)_configureTableView {
    self.dataSource = [[CArrayDataSource alloc] initWithItems:@[] cellIdentifier:[CStoryTableViewCell reuseIdentifier] configureCellBlock:^(CStoryTableViewCell *cell, HNItem *item) {
        CStoryViewModel *viewModel = [[CStoryViewModel alloc] initWithHNItem:item];
        [cell configureWithTitleText:viewModel.originalItem.title infoLabelText:viewModel.storyInfoString commentButtonTitle:viewModel.commentCountString];
        cell.delegate = self;
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerNib:[CStoryTableViewCell nib] forCellReuseIdentifier:[CStoryTableViewCell reuseIdentifier]];
    
    self.refreshDelegate = self;
}

- (void)_configureNavigationBar {
    [self setTitleText:@"Top Stories"];
//        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage upImage] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched:)]];
    
//    // Dropdown menu
//    self.dropdownMenu = [HDropdownMenuView menuWithItems:@[@"Top Stories",@"New Stories",@"Ask Stories", @"Show Stories", @"Job Stories"]];
//    self.dropdownMenu.delegate = self;
//    [self.view addSubview:self.dropdownMenu];
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNItem *item = [self.dataSource itemAtIndexPath:indexPath];
    [self _pushToSafariViewControllerWithUrl:[NSURL URLWithString:item.url]];
}

#pragma mark - HNManagerDelegate 
- (void)didReceiveTopStories:(NSArray*)topStories {
    [self _hackerNewsRequestEndedWithStories:topStories];
}

- (void)didReceiveNewStories:(NSArray*)newStories {
    [self _hackerNewsRequestEndedWithStories:newStories];
}

- (void)didReceiveAskStories:(NSArray*)askStories {
    [self _hackerNewsRequestEndedWithStories:askStories];
}

- (void)didReceiveShowStories:(NSArray*)showStories {
    [self _hackerNewsRequestEndedWithStories:showStories];
}

- (void)didReceiveJobStories:(NSArray*)jobStories {
    [self _hackerNewsRequestEndedWithStories:jobStories];
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    [self errorAlert_checkInternetConnection];
    [self.refreshControl endRefreshing];
    NSLog(@"%@", error);
}

#pragma mark - HNManager Helpers
- (void)_hackerNewsRequestEndedWithStories:(NSArray*)stories {
    self.dataSource.items = stories;

    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
    [super scrollToTop];
}

#pragma mark - CStoryTableViewCellDelegate methods
- (void)button:(UIButton *)aButton selectedWithCell:(UITableViewCell *)cell {
    HNItem *item = [self.dataSource itemAtIndexPath:[self.tableView indexPathForCell:cell]];
    [self _pushToCommentViewControllerWithItem:item];
}

#pragma mark - UIRefreshControl
- (void)tableView:(UITableView *)tableView refreshControlTriggered:(UIRefreshControl *)refreshControl {
    [self.requestManager refreshLastStories];
}

#pragma mark - View Controller Transitions
- (void)_pushToSafariViewControllerWithUrl:(NSURL*)aURL {
    if (!aURL) return;
    
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:aURL];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)_pushToCommentViewControllerWithItem:(HNItem*)item {
    CCommentViewController *vc = [[CCommentViewController alloc] initWithItem:item style:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
