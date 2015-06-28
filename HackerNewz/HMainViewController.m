//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"

#import "HNewsCell.h"
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
    [self setTitle:@"Hacker News"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.requestModel = [[HHackerNewsRequestModel alloc] init];
    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        if (success) {
            [self.tableView reloadData];
        } else {
            [self handleError:error];
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - Table View
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view = self.tableView;
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:@"Problem getting stories."
                          delegate:self
                          cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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
    
    HNewsCell *cell = (HNewsCell*)[tableView dequeueReusableCellWithIdentifier:kHNewsCellReuseID];
    
    if (cell == nil) {
        cell = [[HNewsCell alloc] init];
    } else {
    }
    
    [cell configureWithTitle:item.title];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultCellHeight;
}

@end
