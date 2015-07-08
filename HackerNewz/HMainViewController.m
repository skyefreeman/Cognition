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

#import "HTopStoryCell.h"
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
    [self.tableView registerNib:[UINib nibWithNibName:[HTopStoryCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:kTopStoryReuseIdentifier];
}

#pragma mark - Table View
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

#pragma mark - Error handling
- (void)handleError:(NSError*)error {
    NSLog(@"%@",error);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:@"Problem getting stories. Check your internet connection."
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
    NSString *itemTitle = item.title;
    NSInteger itemCount = indexPath.row + 1;
    
    id cell = [tableView dequeueReusableCellWithIdentifier:kTopStoryReuseIdentifier];
    [cell configureWithTitle:itemTitle count:itemCount];
    
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHackerNewsItem *item = [self itemAtIndexPath:indexPath];
    
    HWebLinkViewController *webVC = [[HWebLinkViewController alloc] init];
    [webVC setLinkURL:[NSURL URLWithString:item.url]];
    [self presentViewController:webVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDefaultCellHeight;
}

#pragma mark - Convenience
- (HHackerNewsItem*)itemAtIndexPath:(NSIndexPath*)indexPath {
    return (HHackerNewsItem*)[self.requestModel.allStories objectAtIndex:indexPath.row];
}

@end
