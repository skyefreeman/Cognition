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
#import "CAdditions.h"

// Views
#import "CCreditView.h"
#import "CMenu.h"
#import "CStoryTableViewCell.h"

// View Models
#import "CStoryViewModel.h"

// Protocols
#import "CTableViewCellButtonDelegate.h"

@interface CStoryViewController()
<UITableViewDelegate, HNManagerDelegate, CTableViewCellButtonDelegate, CTableViewRefreshDelegate, SFSlideOutMenuDelegate>

@property (nonatomic, strong, readwrite) HNManager *requestManager;
@property (nonatomic, strong) CMenu *menu;
@end

@implementation CStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestManager = [[HNManager alloc] init];
    self.requestManager.delegate = self;

    [self _configureSubviews];

    [self.refreshControl beginRefreshing];
    [self.menu toggleTopStoryButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)_configureSubviews {
    // Table view
    self.dataSource = [[CArrayDataSource alloc] initWithItems:@[] cellIdentifier:[CStoryTableViewCell reuseIdentifier] configureCellBlock:^(CStoryTableViewCell *cell, HNItem *item) {
        CStoryViewModel *viewModel = [[CStoryViewModel alloc] initWithHNItem:item];
        [cell configureWithTitleText:viewModel.originalItem.title infoLabelText:viewModel.storyInfoString urlLabelText:viewModel.urlString commentButtonTitle:viewModel.commentCountString];
        [cell setDelegate:self];
        
        if (item.descendants == 0) [cell deactivateCommentButton];
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerNib:[CStoryTableViewCell nib] forCellReuseIdentifier:[CStoryTableViewCell reuseIdentifier]];

    self.refreshDelegate = self;
    
    // Navigation bar
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage menuImage] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched:)]];
    
    // Side Menu
    self.menu = [[CMenu alloc] initWithStyle:SFSlideOutMenuStyleRight];
    self.menu.delegate = self;
}

- (void)_registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kTwitterNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kGithubNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kWebsiteNotificationName object:nil];
}

#pragma mark - Notification Handler
- (void)handleNotification:(NSNotification*)notification {
    NSString *notificationString = notification.name;
    
    if ([notificationString isEqualToString:kTwitterNotificationName]) {
        // twitter link
    }
    else if ([notificationString isEqualToString:kGithubNotificationName]) {
        // github link
    }
    else if ([notificationString isEqualToString:kWebsiteNotificationName]) {
        // website link
    }
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNItem *item = [self.dataSource itemAtIndexPath:indexPath];
    if (item.url) {
        [self _navigateToSafariViewControllerWithItem:item];
    } else if (item.descendants > 0) {
        [self _navigateToCommentViewControllerWithItem:item];
    }
}

#pragma mark - CStoryTableViewCellDelegate
- (void)button:(UIButton *)aButton selectedWithCell:(UITableViewCell *)cell {
    HNItem *item = [self.dataSource itemAtIndexPath:[self.tableView indexPathForCell:cell]];
    [self _navigateToCommentViewControllerWithItem:item];
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

#pragma mark - SFSlideOutMenuDelegate
- (void)slideOutMenuButtonSelected:(UIButton *)button {
    [self setTitleText:button.titleLabel.text];
    [self.menu setActiveButton:button];
    
    MenuButton buttonType = button.tag;
    if (buttonType == MenuButtonTop) [self.requestManager fetchTopStories];
    else if (buttonType == MenuButtonNew) [self.requestManager fetchNewStories];
    else if (buttonType == MenuButtonAsk) [self.requestManager fetchAskStories];
    else if (buttonType == MenuButtonShow) [self.requestManager fetchShowStories];
    else if (buttonType == MenuButtonJob) [self.requestManager fetchJobStories];
    
    if (self.menu.isActive)[self.menu toggleActive];
}

#pragma mark - UIRefreshControl
- (void)tableView:(UITableView *)tableView refreshControlTriggered:(UIRefreshControl *)refreshControl {
    [self.requestManager refreshLastStories];
}

#pragma mark - Navigation Bar Actions
- (void)menuButtonTouched:(id)sender {
    [self.menu toggleActive];
}

#pragma mark - Navigation Convenience
- (void)_navigateToSafariViewControllerWithItem:(HNItem*)item {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)_navigateToCommentViewControllerWithItem:(HNItem*)item {
    CCommentViewController *vc = [[CCommentViewController alloc] initWithItem:item style:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
