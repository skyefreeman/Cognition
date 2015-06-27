//
//  HHackerNewsHelper.m
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsHelper.h"
#import <AFNetworking.h>

NSString * kHNAPIAddress = @"https://hacker-news.firebaseio.com/v0/";
NSString * kHNItemKey = @"item";
NSString * kHNTopStoriesKey = @"topstories";

@implementation HHackerNewsHelper

+ (void)topStories:(void (^)(id stories, NSError *error))completion {
    
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNTopStoriesKey]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:address parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id json) {
             NSLog(@"%@",json);
             if (completion) completion(json,nil);
         }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (completion) completion(nil, error);
         }];
}

@end

@implementation NSString (URLFormatting)
+ (NSString*)HNAPIFormattedString:(NSString*)string {
    return [string stringByAppendingString:@".json"];
}
@end