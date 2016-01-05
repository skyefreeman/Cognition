//
//  HTableView.m
//  HackerNewz
//
//  Created by Skye on 7/16/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HTableView.h"
#import "HNAdditions.h"

@interface HTableView()
@end

@implementation HTableView

+ (instancetype)tableViewWithEstimatedRowHeight:(CGFloat)estHeight {
    return [[self alloc] initWithEstimatedRowHeight:estHeight];
}

- (instancetype)initWithEstimatedRowHeight:(CGFloat)estHeight {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = estHeight;
        self.backgroundColor = [UIColor HNOrange];
        
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..." attributes:attrsDictionary];
        
        self.refreshController = [[UIRefreshControl alloc] init];
        self.refreshController.tintColor = [UIColor whiteColor];
        self.refreshController.attributedTitle = attributedTitle;
        [self.refreshController addTarget:self action:@selector(refreshControlActivated) forControlEvents:UIControlEventValueChanged];
        [self.refreshController setClipsToBounds:YES];
        [self insertSubview:self.refreshController atIndex:0];
    }
    return self;
}

#pragma mark - Refresh Control
- (void)refreshControlActivated {
    [self.refreshdelegate refreshControlActivated];
}

#pragma mark - Background Label
- (void)addBackgroundLabelWithText:(NSString *)text atCenter:(CGPoint)center {
    if (self.backgroundLabel) {
        [self.backgroundLabel removeFromSuperview];
        self.backgroundLabel = nil;
    }
    
    self.backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/6 * 5, self.frame.size.height)];
    self.backgroundLabel.text = text;
    self.backgroundLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.backgroundLabel.numberOfLines = 0;
    self.backgroundLabel.font = [UIFont hnFont:16];
    self.backgroundLabel.textColor = [UIColor whiteColor];
    self.backgroundLabel.alpha = 0.6;
    [self.backgroundLabel sizeToFit];
    [self.backgroundLabel setCenter:center];
    [self addSubview:self.backgroundLabel];
}

#pragma mark - Custom Table stuff
- (void)reloadDataAnimated {
    NSRange range = NSMakeRange(0, self.numberOfSections);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [self reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
}

@end
