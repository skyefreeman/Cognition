//
//  HWebLinkViewController.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebLinkViewController.h"
#import <SFAdditions.h>
#import "HWebView.h"

@interface HWebLinkViewController() <UIWebViewDelegate>
@property (nonatomic) HWebView *webView;
@end

@implementation HWebLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[HWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    if (self.linkURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.linkURL];
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self displayActivityIndicator:self.view.center style:UIActivityIndicatorViewStyleGray];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self removeActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
