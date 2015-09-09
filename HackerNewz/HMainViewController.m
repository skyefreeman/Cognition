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

// Libraries
#import <JHChainableAnimations.h>

// Categories
#import <SFAdditions.h>
#import "NSObject+HNAdditions.h"
#import "UIColor+HNAdditions.h"
#import "UIImage+HNAdditions.h"
#import "UIFont+HNAdditions.h"

// Views
#import "HTableView.h"
#import "HDropdownMenuView.h"
#import "HCustomTitleLabel.h"

// Hacker News
#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItemCell.h"
#import "HStory.h"

@interface HMainViewController () <UITableViewDataSource,UITableViewDelegate,HHackerNewsItemCellDelegate,HDropdownMenuViewDelegate,HTableViewDelegate, HCustomTitleLabelDelegate>

@property (nonatomic) HTableView *tableView;
@property (nonatomic) HDropdownMenuView *dropdownMenu;

@property (nonatomic) NSMutableArray *topStories;
@property (nonatomic) HHackerNewsRequestModel *requestModel;

@property (nonatomic) HCustomTitleLabel *titleLabel;
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSubviews];
    [self registerNibs];
    
    // Start initial loader
    [self displayActivityIndicator:CGPointMake(self.view.center.x, self.view.center.y - [self.navigationController barHeight]) style:UIActivityIndicatorViewStyleGray];
    
    // Start first story request
    [self refreshStories];
}

#pragma mark - View Customization
- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HHackerNewsItemCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:[HHackerNewsItemCell standardReuseIdentifier]];
}

- (void)configureSubviews {
    // Table view
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kTopStoryCellHeight];
    self.tableView.delegate = self;
    self.tableView.refreshdelegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // Navigation bar
    self.titleLabel = [[HCustomTitleLabel alloc] initWithFrame:self.navigationController.navigationBar.frame title:@"Top Ranked"];
    self.titleLabel.delegate = self;
    [self.navigationItem setTitleView:self.titleLabel];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage upImage] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched:)]];
    
    // Dropdown menu
    self.dropdownMenu = [HDropdownMenuView menuWithItems:@[@"Top Ranked",@"Most Recent",@"Jobs"]];
    self.dropdownMenu.delegate = self;
    [self.view addSubview:self.dropdownMenu];
    
    // To allow Status bar table view scroll to top
    for (UITextView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            view.scrollsToTop = NO;
        }
    }
}

#pragma mark - Navigation Bar Custom Title
- (void)customTitleLabelTouched {
    [self scrollToTopOfTableView];
}

- (void)setNavigationBarTitleText:(NSString*)text {
    [self.titleLabel setText:text];
    [self.titleLabel sizeToFit];
}

#pragma mark - HTableView Delegate methods
- (void)refreshControlActivated {
    [self refreshStories];
}

#pragma mark - Requests
- (void)refreshStories {
    if (!self.requestModel) {
        self.requestModel = [[HHackerNewsRequestModel alloc] init];
    }

    switch (self.requestModel.requestType) {
        case RequestTypeTopStories: {
            [self requestTopStories];
            break;
        }
        case RequestTypeLatestStories: {
            [self requestLatestStories];
            break;
        }
        case RequestTypeJobStories: {
            [self requestJobStories];
            break;
        }
    }
}

- (void)requestTopStories {
    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        [self removeActivityIndicator];
        
        if (success) {[self.tableView reloadData]; [self scrollToTopOfTableView];}
        else [self handleError:error type:@"stories"];
    }];
}

- (void)requestLatestStories {
    [self.requestModel getLatestStories:^(BOOL success, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        [self removeActivityIndicator];
        
        if (success) {[self.tableView reloadData]; [self scrollToTopOfTableView];}
        else [self handleError:error type:@"stories"];
    }];
}

- (void)requestJobStories {
    [self.requestModel getJobStories:^(BOOL success, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        [self removeActivityIndicator];
        
        if (success) {[self.tableView reloadData]; [self scrollToTopOfTableView];}
        else [self handleError:error type:@"stories"];
    }];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error type:(NSString*)itemType{
    [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"Problem getting %@. Check your internet connection.",itemType]];
}

#pragma mark - HDropdownMenuView Delegate Methods
- (void)didSelectItemAtRow:(NSInteger)row {
    
    if (row == RequestTypeTopStories) {
        [self requestTopStories];
    }
    
    else if (row == RequestTypeLatestStories) {
        [self requestLatestStories];
    }
    
    else if (row == RequestTypeJobStories) {
        [self requestJobStories];
    }
    
    [self toggleDropdownMenuSlide];
    [self setNavigationBarTitleText:[self.dropdownMenu.items objectAtIndex:row]];
}

#pragma mark - Dropdown Menu
- (void)menuButtonTouched:(id)sender {
    [self toggleDropdownMenuSlide];
}

- (void)toggleDropdownMenuSlide {
    [self.dropdownMenu toggleSlide];
    
    if (self.dropdownMenu.isActive) {
        self.navigationItem.leftBarButtonItem.image = [UIImage upImage];
    } else {
        self.navigationItem.leftBarButtonItem.image = [UIImage downImage];
    }
}

#pragma mark - UITableView Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.requestModel.allStories.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHackerNewsItem *item = [self.requestModel.allStories objectAtIndex:indexPath.row];

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

#pragma mark - HHackerNewsItemCell Delegate Methods
- (void)commentBubbleTapped:(id)sender {
    
    HHackerNewsItemCell *cell = (HHackerNewsItemCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Load comments for news item
    HStory *story = [self.requestModel.allStories objectAtIndex:indexPath.row];
    [self.requestModel getCommentsForItem:story completion:^(id comments, NSError *error) {
        [sender commentLoadingViewVisible:NO];

        if (comments) {
            [self pushToCommentViewController:comments];
        } else {
            [self handleError:error type:@"comments"];
        }
    }];
}

#pragma mark - View Controller Navigation
- (void)pushToWebLinkViewController:(NSURL*)linkURL {
    HWebLinkViewController *webVC = [[HWebLinkViewController alloc] init];
    [webVC setModalTransitionStyle: UIModalTransitionStyleCoverVertical];
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

- (void)scrollToTopOfTableView {
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

@implementation UINavigationController (MainViewControllerAdditions)
- (CGFloat)barHeight {
    return self.navigationBar.height;
}
@end
