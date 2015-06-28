//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"
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
    
    self.requestModel = [[HHackerNewsRequestModel alloc] init];
    [self.requestModel getTopStories:^(BOOL success, NSError *error) {
        if (success) {
            for (HHackerNewsItem *item in self.requestModel.allStories) {
                if (item) {
                    NSLog(@"%@",item);
                }
            }
//            NSLog(@"%@",self.requestModel.allStories);
            [self.tableView reloadData];
        }
        else NSLog(@"%@",error);
    }];
}

#pragma mark - Table View
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
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
    
    static NSString *cellID = @"storyCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UILabel *titleLabel;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 220, 15)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.tag = 1;
        [cell.contentView addSubview:titleLabel];
    } else {
        titleLabel = (UILabel*)[cell.contentView viewWithTag:1];
    }
    
    titleLabel.text = item.title;
    
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

@end
