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
@property (nonatomic) HWebViewbar *webBar;
@end

@implementation HWebLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.webBar = [[HWebViewbar alloc] initWithBarType:BarTypeBottom];
    self.webBar.delegate = self;
    [self.view addSubview:self.webBar];

    if (self.linkURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.linkURL];
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self displayActivityIndicator:self.webBar.center style:UIActivityIndicatorViewStyleWhite];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self removeActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - HWebViewBar Delegate Methods
- (void)webBarCancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self didScrollDown:scrollView]) {
        [self.webBar fadeOutWithDuration:kBarFadeTime];
    }
    
    if ([self didScrollUp:scrollView]) {
        [self.webBar fadeInWithDuration:kBarFadeTime];
    }
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
