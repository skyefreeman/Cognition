//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"
#import "HWebLinkViewController.h"

#import <SFAdditions.h>
#import "NSObject+HNAdditions.h"

#import "HHackerNewsItemCell.h"
#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItem.h"

@interface HMainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *topStories;
@property (nonatomic) HHackerNewsRequestModel *requestModel;
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTableView];
    [self registerNibs];
    
    [self setTitle:@"Top Stories"];
    
    [self displayActivityIndicator:CGPointMake(self.view.center.x, self.view.center.y - 44) style:UIActivityIndicatorViewStyleGray];
    
    self.requestModel = [[HHackerNewsRequestModel alloc] init];
    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        
        [self removeActivityIndicator];
        
        if (success) {
            [self.tableView reloadData];
        } else {
            [self handleError:error];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HHackerNewsItemCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:kNewsItemReuseIdentifier];
}

#pragma mark - Table View
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;;
    self.tableView.estimatedRowHeight = kTopStoryCellHeight;
    [self.view addSubview:self.tableView];
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
    
    HWebLinkViewController *webVC = [[HWebLinkViewController alloc] init];
    [webVC setLinkURL:[NSURL URLWithString:item.url]];
    [self presentViewController:webVC animated:YES completion:nil];
}

#pragma mark - Convenience
- (HHackerNewsItem*)itemAtIndexPath:(NSIndexPath*)indexPath {
    return (HHackerNewsItem*)[self.requestModel.allStories objectAtIndex:indexPath.row];
}

@end
