//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

// View Controllers
#import "HHomeViewController.h"

#import "HWebLinkViewController.h"
#import "HCommentViewController.h"
#import "HSafariViewController.h"

// Libraries
#import "JHChainableAnimations.h"

// Categories
#import "HNAdditions.h"
#import "SFAdditions.h"

// Views
#import "HTableView.h"
#import "HDropdownMenuView.h"
#import "HCustomTitleLabel.h"

// Hacker News Model
#import "HackerNewsKit.h"
#import "HHackerNewsItemCell.h"
#import "HArrayDataSource.h"

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeTopStories,
    RequestTypeNewStories,
    RequestTypeAskStories,
    RequestTypeShowStories,
    RequestTypeJobStories,
};

@interface HHomeViewController ()
<UITableViewDelegate,
UIScrollViewDelegate,
HNManagerDelegate,
HHackerNewsItemCellDelegate,
HDropdownMenuViewDelegate,
HTableViewDelegate,
HCustomTitleLabelDelegate>

@property (nonatomic, strong) HTableView *tableView;
@property (nonatomic, strong) HArrayDataSource *dataSource;
@property (nonatomic, strong) HNManager *requestManager;;
@property (nonatomic) HDropdownMenuView *dropdownMenu;
@property (nonatomic) HCustomTitleLabel *titleLabel;

@end

@implementation HHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.requestManager = [[HNManager alloc] init];
    [self.requestManager setDelegate:self];
    
    [self configureTableView];
    [self configureSubviews];
    
    // Start initial loader
    [self displayActivityIndicator:CGPointMake(self.view.center.x, self.view.center.y - [self _navigationBarHeight]) style:UIActivityIndicatorViewStyleWhiteLarge];
    [self.requestManager fetchTopStories];
}

- (void)configureTableView {
    TableViewCellConfigureBlock configBlock = ^(HHackerNewsItemCell *cell, HNItem *item) {
        [cell setDelegate:self];
        [cell configureWithTitle:item.title points:item.score author:item.by time:item.time comments:item.descendants];
    };
    
    self.dataSource = [[HArrayDataSource alloc] initWithItems:@[] cellIdentifier:[HHackerNewsItemCell standardReuseIdentifier] configureCellBlock:configBlock];
    
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kTopStoryCellHeight];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    self.tableView.refreshdelegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[HHackerNewsItemCell nib] forCellReuseIdentifier:[HHackerNewsItemCell standardReuseIdentifier]];
}

- (void)configureSubviews {
    // Navigation bar
    self.titleLabel = [[HCustomTitleLabel alloc] initWithFrame:self.navigationController.navigationBar.frame title:@"Top Ranked"];
    self.titleLabel.delegate = self;
    [self.navigationItem setTitleView:self.titleLabel];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage upImage] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonTouched:)]];
    
    // Dropdown menu
    self.dropdownMenu = [HDropdownMenuView menuWithItems:@[@"Top Stories",@"New Stories",@"Ask Stories", @"Show Stories", @"Job Stories"]];
    self.dropdownMenu.delegate = self;
    [self.view addSubview:self.dropdownMenu];
    
    // To allow Status bar table view scroll to top
    for (UITextView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            view.scrollsToTop = NO;
        }
    }
}

- (void)customTitleLabelTouched {
    [self scrollToTopOfTableView];
}

- (void)setNavigationBarTitleText:(NSString*)text {
    [self.titleLabel setText:text];
    [self.titleLabel sizeToFit];
}

#pragma mark - HTableView Delegate methods
- (void)refreshControlActivated {
    //    [self.requestManager refreshLastStories];
}

#pragma mark - HNManagerDelegate Methods
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

- (void)didReceiveItem:(HNItem*)item {
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    [self handleError:error];
    NSLog(@"%@", error);
}

#pragma mark - HNManager Helpers
- (void)_hackerNewsRequestEndedWithStories:(NSArray*)stories {
    self.dataSource.items = stories;
    
    [self.tableView.refreshController endRefreshing];
    [self removeActivityIndicator];
    [self.tableView reloadDataAnimated];
    [self scrollToTopOfTableView];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error {
    [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"Problem retrieving stories. Check your internet connection."]];
}

#pragma mark - HDropdownMenuView Delegate Methods
- (void)didSelectItemAtRow:(NSInteger)row {
    RequestType request = row;
    switch (request) {
        case RequestTypeTopStories: {
            [self.requestManager fetchTopStories];
            break;
        }
        case RequestTypeNewStories: {
            [self.requestManager fetchNewStories];
            break;
        }
        case RequestTypeAskStories: {
            [self.requestManager fetchAskStories];
            break;
        }
        case RequestTypeShowStories: {
            [self.requestManager fetchShowStories];
            break;
        }
        case RequestTypeJobStories: {
            [self.requestManager fetchJobStories];
            break;
        }
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

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNItem *item = [self.dataSource itemAtIndexPath:indexPath];
    
    if (![item.url isNotEmptyString]) {
        [self showAlertWithTitle:@"Error" message:@"No URL for item"];
        return;
    }
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
    [self presentViewController:vc animated:YES completion:nil];
//    [self pushToWebLinkViewController:[NSURL URLWithString:story.url]];
}

#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.dropdownMenu.isActive) [self.dropdownMenu toggleSlide];
}

#pragma mark - HHackerNewsItemCell Delegate Methods
- (void)commentButtonTapped:(id)sender {
    
    HHackerNewsItemCell *cell = (HHackerNewsItemCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // Load comments for news item
    HNItem *item = [self.dataSource itemAtIndexPath:indexPath];
//    [self.requestModel getCommentsForItem:story completion:^(id comments, NSError *error) {
//        if (!error) {
//            [self pushToCommentViewController:comments];
//        } else {
//            [self handleError:error type:@"comments"];
//        }
//    }];
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
- (void)scrollToTopOfTableView {
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (CGFloat)_navigationBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}

@end

