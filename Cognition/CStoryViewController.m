//
//  CStoryViewController.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

// View Controllers
#import "CStoryViewController.h"
#import "CCommentViewController.h"

// Constants
#import "CConstants.h"

// Libaries
#import <SafariServices/SafariServices.h>
#import <SFAdditions.h>
#import <HackerNewsKit.h>

// Categories
#import "CAdditions.h"
#import "RLMObject+SaveAdditions.h"
#import "RLMResults+Convenience.h"

// Views
#import "CCreditView.h"
#import "CMenu.h"
#import "CStoryTableViewCell.h"
#import "SWTableViewCellBuilder.h"
#import <MBProgressHUD.h>

// Models
#import "CItem.h"

// View Models
#import "CStoryViewModel.h"

// Protocols
#import "CTableViewCellButtonDelegate.h"

// Builders
#import "CRealmObjectBuilder.h"

@interface CStoryViewController() <UITableViewDelegate,HNManagerDelegate,CTableViewCellButtonDelegate,CTableViewRefreshDelegate,SFSlideOutMenuDelegate,SWTableViewCellDelegate>
@property (nonatomic, strong, readwrite) HNManager *requestManager;
@property (nonatomic, strong) CMenu *menu;
@end

@implementation CStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestManager = [[HNManager alloc] init];
    self.requestManager.delegate = self;
    
    [self _configureSubviews];
    [self _registerNotifications];
    
    [self.menu toggleTopStoryButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)_configureSubviews {
    // Table view
    TableViewCellConfigureBlock block = ^void(CStoryTableViewCell *cell, CItem *item) {
        CStoryViewModel *viewModel = [[CStoryViewModel alloc] initWithCItem:item];
        [cell configureWithTitleText:viewModel.originalItem.title
                       infoLabelText:viewModel.storyInfoString
                        urlLabelText:viewModel.urlString
                  commentButtonTitle:viewModel.commentCountString];
        
        NSString *swipeButtonTitle = (self.menu.activeButton == MenuButtonSaved) ? @"Delete" : @"Save";
        [cell setRightUtilityButtons:[SWTableViewCellBuilder storyRightUtilityButtons:swipeButtonTitle]];
        [cell setDelegate:self];
        [cell setStoryCellDelegate:self];
        
        if (item.descendants == 0) [cell deactivateCommentButton];
    };
    
    self.dataSource = [[CArrayDataSource alloc] initWithItems:@[]
                                               cellIdentifier:[CStoryTableViewCell reuseIdentifier]
                                           configureCellBlock:block];
    
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
        [self navigateToSafariViewControllerWithURLString:kTwitterURLString];
        
    } else if ([notificationString isEqualToString:kGithubNotificationName]) {
        [self navigateToSafariViewControllerWithURLString:kGithubURLString];
        
    } else if ([notificationString isEqualToString:kWebsiteNotificationName]) {
        [self navigateToSafariViewControllerWithURLString:kWebsiteURLString];
    }
    
    [self.menu toggleActive];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CItem *item = [self.dataSource itemAtIndexPath:indexPath];
    if (item.url) {
        [self navigateToSafariViewControllerWithURLString:item.url];
    } else if (item.descendants > 0) {
        [self navigateToCommentViewControllerWithItem:item];
    }
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    CItem *item = (CItem*)[self.dataSource.items objectAtIndex:[self.tableView indexPathForCell:cell].row];
    
    if (self.menu.activeButton == MenuButtonSaved) {
        [item deleteObject];
        self.dataSource.items = [RLMResults allCItems];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } else {
        [item saveObject];
        [cell hideUtilityButtonsAnimated:YES];
    }
}

#pragma mark - CStoryTableViewCellDelegate
- (void)button:(UIButton *)aButton selectedWithCell:(UITableViewCell *)cell {
    CItem *item = [self.dataSource itemAtIndexPath:[self.tableView indexPathForCell:cell]];
    [self navigateToCommentViewControllerWithItem:item];
}

#pragma mark - HNManagerDelegate 
- (void)didReceiveTopStories:(NSArray*)stories {
    [self reloadTableWithItems:stories];
}

- (void)didReceiveNewStories:(NSArray*)stories {
    [self reloadTableWithItems:stories];
}

- (void)didReceiveAskStories:(NSArray*)stories {
    [self reloadTableWithItems:stories];
}

- (void)didReceiveShowStories:(NSArray*)stories {
    [self reloadTableWithItems:stories];
}

- (void)didReceiveJobStories:(NSArray*)stories {
    [self reloadTableWithItems:stories];
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    [self errorAlert_checkInternetConnection];
    [self.refreshControl endRefreshing];
    NSLog(@"%@", error);
}

#pragma mark - Table Reloading
- (void)reloadTableWithItems:(NSArray *)items {
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    NSArray *reloadableItems;
    if (self.menu.activeButton == MenuButtonSaved) {
        reloadableItems = items;
    } else {
        reloadableItems = [CRealmObjectBuilder buildItemsWithHNItems:items];
    }
    
    [super reloadTableWithItems:reloadableItems];
}

#pragma mark - SFSlideOutMenuDelegate
- (void)slideOutMenuButtonSelected:(UIButton *)button {
    [self setTitleText:button.titleLabel.text];
    [self.menu setActiveButton:button.tag];
    
    if (self.navigationController.view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Loading...";
    }

    MenuButton buttonType = button.tag;
    if (buttonType == MenuButtonTop) [self.requestManager fetchTopStories];
    else if (buttonType == MenuButtonNew) [self.requestManager fetchNewStories];
    else if (buttonType == MenuButtonAsk) [self.requestManager fetchAskStories];
    else if (buttonType == MenuButtonShow) [self.requestManager fetchShowStories];
    else if (buttonType == MenuButtonJob) [self.requestManager fetchJobStories];
    else if (buttonType == MenuButtonSaved) [self reloadTableWithItems:[RLMResults allCItems]];
    
    if (self.menu.isActive)[self.menu toggleActive];
}

#pragma mark - UIRefreshControl
- (void)tableView:(UITableView *)tableView refreshControlTriggered:(UIRefreshControl *)refreshControl {
    if (self.menu.activeButton == MenuButtonSaved) {
        [self reloadTableWithItems:[RLMResults allCItems]];
    } else {
        [self.requestManager refreshLastStories];
    }
}

#pragma mark - Navigation Bar Actions
- (void)menuButtonTouched:(id)sender {
    [self.menu toggleActive];
}

#pragma mark - Navigation Convenience
- (void)navigateToSafariViewControllerWithURLString:(NSString*)urlString {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)navigateToCommentViewControllerWithItem:(CItem*)item {
    CCommentViewController *vc = [[CCommentViewController alloc] initWithItem:item style:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
