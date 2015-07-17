//
//  HCommentViewController.m
//  HackerNewz
//
//  Created by Skye on 7/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HCommentViewController.h"

#import "NSObject+HNAdditions.h"

#import "HTableView.h"

#import "HComment.h"
#import "HCommentCell.h"

@interface HCommentViewController() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) HTableView *tableView;
@end

@implementation HCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Comments"];
    
    self.tableView = [HTableView tableViewWithEstimatedRowHeight:kCommentCellHeight];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self registerNibs];
    [self.tableView reloadData];
    
    NSLog(@"%@",self.allComments);
}

- (void)registerNibs {
    [self.tableView registerNib:[UINib nibWithNibName:[HCommentCell standardReuseIdentifier] bundle:nil] forCellReuseIdentifier:[HCommentCell standardReuseIdentifier]];
}
#pragma mark - UITableView Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allComments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HComment *comment = [self.allComments objectAtIndex:indexPath.row];
    
    id cell = [self.tableView dequeueReusableCellWithIdentifier:[HCommentCell standardReuseIdentifier]];
    [cell configureWithAuthor:comment.author time:comment.time text:comment.text];
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"This happend");
}

@end
