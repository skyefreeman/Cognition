//
//  CStoryViewController.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CStoryViewController.h"

// Libaries
#import <SFAdditions.h>
#import <HackerNewsKit.h>

// Data Sources
#import "HArrayDataSource.h"

// Views
#import "CStoryTableViewCell.h"

// View Models
#import "CStoryViewModel.h"

@interface CStoryViewController() <UITableViewDelegate, HNManagerDelegate>
@property (nonatomic, strong, readwrite) HNManager *requestManager;
@end

@implementation CStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestManager = [[HNManager alloc] init];
    [self.requestManager setDelegate:self];
    [self.requestManager fetchTopStories];
}

- (void)configureTableView {
    [super configureTableView];
    
    self.dataSource = [[HArrayDataSource alloc] initWithItems:@[] cellIdentifier:[CStoryTableViewCell reuseIdentifier] configureCellBlock:^(CStoryTableViewCell *cell, HNItem *item) {
        CStoryViewModel *viewModel = [[CStoryViewModel alloc] initWithHNItem:item];
        [cell configureWithTitleText:viewModel.originalItem.title infoLabelText:viewModel.storyInfoString commentButtonTitle:viewModel.commentCountString];
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerNib:[CStoryTableViewCell nib] forCellReuseIdentifier:[CStoryTableViewCell reuseIdentifier]];
}

- (void)configureNavigationBar {
    [super configureNavigationBar];
    
    [self setTitleText:@"Top Stories"];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage upImage] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched:)]];
    
//    // Dropdown menu
//    self.dropdownMenu = [HDropdownMenuView menuWithItems:@[@"Top Stories",@"New Stories",@"Ask Stories", @"Show Stories", @"Job Stories"]];
//    self.dropdownMenu.delegate = self;
//    [self.view addSubview:self.dropdownMenu];
}

#pragma mark - Menu
- (void)menuButtonTouched:(id)sender {
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

- (void)didReceiveItemComments:(NSArray *)commentItems {
//    [self pushToCommentViewController:commentItems];
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    [self handleError:error];
    NSLog(@"%@", error);
}

- (void)_hackerNewsRequestEndedWithStories:(NSArray*)stories {
    self.dataSource.items = stories;
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
    [super scrollToTop];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error {
    [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"Problem retrieving stories. Check your internet connection."]];
}

@end
