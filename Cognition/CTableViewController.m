//
//  CTableViewController.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CTableViewController.h"
#import "CArrayDataSource.h"
#import "CCustomTitleLabel.h"
#import "CTableViewRefreshDelegate.h"

// Categories
#import "CAdditions.h"
#import "NSObject+Wait.h"
#import "UITableViewController+Animation.h"

// Libraries
#import <SFAdditions.h>
#import <JHChainableAnimations.h>
#import <SWTableViewCell.h>

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
    if (items) self.dataSource.items = items;
    
    CGFloat firstWaitTime = 0;
    CGFloat secondWaitTime = self.reloadAnimationTime;
    
    if (self.tableView.visibleCells.count > 0) {
        [self animateTableViewCellsOut];
        
        firstWaitTime = self.reloadAnimationTime;
        secondWaitTime = self.reloadAnimationTime * 2;
    }
    
    [self waitFor:firstWaitTime then:^{
        // Turn swipeableButton title colors to clear, to hide overlap
        [self toggleTableViewCellTitleColor:[UIColor clearColor]];
        [self.tableView reloadData];
        [self animateTableViewCellsIn];
    }];
    
    [self waitFor:secondWaitTime then:^{
        [self.refreshControl endRefreshing];
        [self scrollToTop];
        
        // Return swipeable cells to white text, then fix overlap
        [self fixSwipeCellOverlap];
        [self toggleTableViewCellTitleColor:[UIColor whiteColor]];
    }];
}

#pragma mark - Private
- (void)toggleTableViewCellTitleColor:(UIColor*)color {
    for (SWTableViewCell *cell in self.tableView.visibleCells) {
        for (UIButton *button in cell.rightUtilityButtons) {
            [button setTitleColor:color forState:UIControlStateNormal];
        }
    }
}

- (void)fixSwipeCellOverlap {
    for (SWTableViewCell *cell in self.tableView.visibleCells) {
        [cell showRightUtilityButtonsAnimated:NO];
        [cell hideUtilityButtonsAnimated:NO];
    }
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
