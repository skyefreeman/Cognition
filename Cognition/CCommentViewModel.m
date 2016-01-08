//
//  CCommentViewModel.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CCommentViewModel.h"
#import "TTTTimeIntervalFormatter.h"
#import <HackerNewsKit.h>
#import <NSString+HTML.h>

@implementation CCommentViewModel
- (instancetype)init {
    return nil;
}

- (instancetype)initWithItem:(HNItem *)aItem {
    self = [super init];
    if (!self) return nil;

    self.item = aItem;
    if (aItem.by) self.authorString = [self _configureAuthorString:aItem.by];
    if (aItem.text) self.commentString = [self _configureCommentString:aItem.text];
    if (aItem.time) self.timeString = [self _configureTimeString:aItem.time];
    
    return self;
}

- (NSString*)_configureAuthorString:(NSString*)author {
    return [@"by " stringByAppendingString:author];
}

- (NSString*)_configureCommentString:(NSString*)comment {
    return [comment stringByConvertingHTMLToPlainText];
}

- (NSString*)_configureTimeString:(NSInteger)time {
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    return [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];
}

@end
