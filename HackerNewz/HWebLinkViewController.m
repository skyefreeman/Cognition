//
//  HWebLinkViewController.m
//  HackerNewz
//
//  Created by Skye on 6/29/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HWebLinkViewController.h"
#import "HWebViewBar.h"
#import "HNAdditions.h"

#define kBarFadeTime 0.2

@interface HWebLinkViewController() <UIWebViewDelegate,UIScrollViewDelegate,HWebViewBarDelegate>
@property (nonatomic) UIWebView *webView;
@property (nonatomic) HWebViewBar *webViewBar;
@end

@implementation HWebLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    self.webViewBar = [[HWebViewBar alloc] initWithBarType:BarTypeBottom];
    self.webViewBar.delegate = self;
    [self.view addSubview:self.webViewBar];
    
    if (self.linkURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.linkURL];
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateDirectionalButtons];
}

#pragma mark - HWebViewBar Delegate Methods
- (void)cancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backButtonTapped {
    [self.webView goBack];
}

- (void)forwardButtonTapped {
    [self.webView goForward];
}

- (void)uploadButtonTapped {
    NSLog(@"this happend");
}

#pragma mark - Link Management
- (void)updateDirectionalButtons {
    [self.webViewBar setBackButtonActive:self.webView.canGoBack];
    [self.webViewBar setForwardButtonActive:self.webView.canGoForward];
}

#pragma mark - UIScrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self didScrollUp:scrollView]) {
        [self.webViewBar fadeIn];
    }
    
    if ([self didScrollDown:scrollView]) {
        [self.webViewBar fadeOut];
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - dealloc
- (void)dealloc {
    self.webView = nil;
}

@end
