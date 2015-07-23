//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

// View Controllers
#import "HMainViewController.h"
#import "HWebLinkViewController.h"
#import "HCommentViewController.h"

// Categories
#import <SFAdditions.h>
#import "NSObject+HNAdditions.h"
#import "UIColor+HNAdditions.h"

// Views
#import "HTableView.h"

// Hacker News
#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItemCell.h"
#import "HStory.h"

@interface HMainViewController () <UITableViewDataSource,UITableViewDelegate,HHackerNewsItemCellDelegate>

@property (nonatomic) HTableView *tableView;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) UISegmentedControl *segmentedControl;

@property (nonatomic) NSMutableArray *topStories;
@property (nonatomic) HHackerNewsRequestModel *requestModel;
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Top Stories"];

    CGFloat controlHeight = 22;
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Top", @"Latest"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.frame = CGRectMake(0, 44, self.view.width, controlHeight);
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.tintColor = [UIColor HNOrange];
    
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kTopStoryCellHeight];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.segmentedControl;
    [self.view addSubview:self.tableView];
    
    [self registerNibs];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.756 green:0.304 blue:0.283 alpha:1.000];
;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(requestTopStories) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self requestTopStories];
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HHackerNewsItemCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:[HHackerNewsItemCell standardReuseIdentifier]];
}

#pragma mark - Requests
- (void)requestTopStories {
    if (!self.requestModel) {
        self.requestModel = [[HHackerNewsRequestModel alloc] init];
    }

    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        [self.refreshControl endRefreshing];
        
        if (success) [self.tableView reloadData];
        else [self handleError:error type:@"stories"];
        
    }];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error type:(NSString*)itemType{
    [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"Problem getting %@. Check your internet connection.",itemType]];
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
    HStory *item = (HStory*)[self.requestModel.allStories objectAtIndex:indexPath.row];

    id cell = [tableView dequeueReusableCellWithIdentifier:[HHackerNewsItemCell standardReuseIdentifier]];
    [cell setDelegate:self];
    [cell configureWithTitle:item.title points:item.score author:item.author time:item.time comments:item.commentCount];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HStory *story = [self storyAtIndexPath:indexPath];
    
    if (![story.url isNotEmptyString]) {
        [self showAlertWithTitle:@"Error" message:@"No URL for item"];
        return;
    }
    
    [self pushToWebLinkViewController:[NSURL URLWithString:story.url]];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

#pragma mark - HHackerNewsItemCell Delegate Methods
- (void)commentBubbleTapped:(id)sender {
    
    HHackerNewsItemCell *cell = (HHackerNewsItemCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Load comments for news item
    HStory *story = [self.requestModel.allStories objectAtIndex:indexPath.row];
    [self.requestModel getCommentsForItem:story completion:^(id comments, NSError *error) {
        if (comments) {
            [self pushToCommentViewController:comments];
        } else {
            [self handleError:error type:@"comments"];
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - View Controller Navigation
- (void)pushToWebLinkViewController:(NSURL*)linkURL {
    HWebLinkViewController *webVC = [[HWebLinkViewController alloc] init];
    [webVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [webVC setLinkURL:linkURL];
    [self presentViewController:webVC animated:YES completion:nil];
}

- (void)pushToCommentViewController:(NSArray*)comments {
    HCommentViewController *commentVC = [[HCommentViewController alloc] init];
    [commentVC setAllComments:comments];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - Convenience
- (HStory*)storyAtIndexPath:(NSIndexPath*)indexPath {
    return (HStory*)[self.requestModel.allStories objectAtIndex:indexPath.row];
}

@end
