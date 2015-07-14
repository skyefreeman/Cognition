//
//  HHackerNewsSearchModel.m
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItem.h"
#import <AFNetworking.h>

NSString * kHNAPIAddress = @"https://hacker-news.firebaseio.com/v0/";

NSString * kHNItemKey = @"item";
NSString * kHNTopStoriesKey = @"topstories";
NSString * kHNCommentsKey = @"kids";

int const kItemFetchCount = 30;

@interface HHackerNewsRequestModel ()
@property (nonatomic, readwrite) NSMutableArray *allStories;

@end

@implementation HHackerNewsRequestModel

- (void)getTopStories:(void (^)(BOOL success, NSError *error))completion {

    // Populate array with null objects, to chain story requests
    NSMutableArray *tempStories = [NSMutableArray arrayWithNullObjectCount:kItemFetchCount];
    
    // Get all top story id's
    [self topStories:^(id stories, NSError *error) {
        if (!error) {
            
            // Get top 30 story item objects
            for (int i = 0; i < kItemFetchCount; i++) {
                [self itemWithID:[stories objectAtIndex:i] completion:^(id story, NSError *error) {
                    
                    if (!error) {
                        HHackerNewsItem *item = [HHackerNewsItem itemWithHNDictionary:story];
                        if (i < tempStories.count) [tempStories replaceObjectAtIndex:i withObject:item];
                    }
                    
                    if (i == (kItemFetchCount - 1)) {
                        self.allStories = [self checkForNilInArray:tempStories];
                        if (completion) completion(YES, nil);
                    }
                }];
            }
            
        } else {
            if (completion) completion(NO, error);
        }
    }];
}

- (void)getCommentsForItem:(HHackerNewsItem*)item completion:(void (^)(id comments, NSError *error))completion {
    NSString *comment = [NSString stringWithFormat:@"%@",[item.comments objectAtIndex:0]];

    [self itemWithID:comment completion:^(id story, NSError *error) {
        if (story) {
            if (completion) completion(story,nil);
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

- (void)itemWithID:(NSString*)itemID completion:(void (^)(id story, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@/%@",kHNAPIAddress,kHNItemKey,itemID]];
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

- (NSMutableArray*)checkForNilInArray:(NSMutableArray*)array {
    NSMutableArray *tempArray = array;
    for (int i = 0; i < tempArray.count; i++) {
        if ([tempArray objectAtIndex:i] == [NSNull null]) {
            [tempArray removeObjectAtIndex:i];
        }
    }
    
    return tempArray;
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