//
//  HWebLinkViewController.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebLinkViewController.h"
#import "HWebView.h"

@interface HWebLinkViewController()
@property (nonatomic) HWebView *webView;
@end

@implementation HWebLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[HWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
}

@end
