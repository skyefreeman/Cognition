//
//  HWebLinkViewController.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebLinkViewController.h"
#import "UIColor+HNAdditions.h"
#import <SFAdditions.h>
#import "HWebViewbar.h"

#define kBarFadeTime 0.2

@interface HWebLinkViewController() <UIWebViewDelegate,HWebViewBarDelegate,UIScrollViewDelegate>
@property (nonatomic) UIWebView *webView;
@end

@implementation HWebLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];

    if (self.linkURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.linkURL];
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self removeActivityIndicator];
}

#pragma mark - HWebViewBar Delegate Methods
- (void)webBarCancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Convenience
- (BOOL)didScrollUp:(UIScrollView*)scrollView {
    if ([self translationWithScrollView:scrollView].y > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)didScrollDown:(UIScrollView*)scrollView {
    if ([self translationWithScrollView:scrollView].y < 0) {
        return YES;
    }
    return NO;
}

- (CGPoint)translationWithScrollView:(UIScrollView*)scrollView {
    return [scrollView.panGestureRecognizer translationInView:scrollView.superview];
}

@end
