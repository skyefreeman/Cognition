//
//  HHackerNewsSearchModel.m
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsRequestModel.h"
#import <AFNetworking.h>

NSString * kHNAPIAddress = @"https://hacker-news.firebaseio.com/v0/";
NSString * kHNItemKey = @"item";
NSString * kHNTopStoriesKey = @"topstories";

int const kItemFetchCount = 30;

@interface HHackerNewsRequestModel ()
@property (nonatomic, readwrite) NSMutableArray *allStories;
@end

@implementation HHackerNewsRequestModel

- (void)getTopStories:(void (^)(BOOL success, NSError *error))completion {

    // Populate array with null objects, to chain story requests
    self.allStories = [NSMutableArray arrayWithNullObjectCount:kItemFetchCount];
    
    // Get all top story id's
    [self topStories:^(id stories, NSError *error) {
        if (!error) {
            
            // Get top 30 story item objects
            for (int i = 0; i < kItemFetchCount; i++) {
                [self itemWithID:[stories objectAtIndex:i] completion:^(id story, NSError *error) {
                    
                    if (!error) [self.allStories replaceObjectAtIndex:i withObject:story];
                    
                    if (i == (kItemFetchCount - 1)) {
                        if (completion) completion(YES,nil);
                    }
                }];
            }
        } else {
            if (completion) completion(nil,error);
        }
    }];
}

#pragma mark - Hacker News API Requests
- (void)topStories:(void (^)(id stories, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNTopStoriesKey]];
    [HHackerNewsRequestModel requestWithURLAddress:address completion:completion];
}

- (void)itemWithID:(NSString*)ID completion:(void (^)(id story, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@/%@",kHNAPIAddress,kHNItemKey,ID]];
    [HHackerNewsRequestModel requestWithURLAddress:address completion:completion];
}

#pragma mark - Convenience
+ (void)requestWithURLAddress:(NSString*)address completion:(void (^)(id stories, NSError *error))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:address parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id json) {
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

@implementation NSMutableArray (SFAdditions)
+ (NSMutableArray*)arrayWithNullObjectCount:(int)count {
    NSMutableArray *nullArray = [NSMutableArray array];
    for (int i = 0 ; i<count; i++) {
        [nullArray addObject:[NSNull null]];
    }
    return nullArray;
}
@end