//
//  HHackerNewsSearchModel.m
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HHackerNewsRequestModel.h"
#import "HHackerNewsItem.h"
#import "HStory.h"
#import "HComment.h"
#import "HJob.h"
#import <AFNetworking.h>

NSString * kHNAPIAddress = @"https://hacker-news.firebaseio.com/v0/";

NSString * kHNItemKey = @"item";
NSString * kHNTopStoriesKey = @"topstories";
NSString * kHNNewStoriesKey = @"newstories";
NSString * kHNJobStoriesKey = @"jobstories";
NSString * kHNCommentsKey = @"kids";

int const kDefaultItemFetchCount = 30;

@interface HHackerNewsRequestModel ()
@property (nonatomic, readwrite) NSMutableArray *allStories;
@end

@implementation HHackerNewsRequestModel

- (void)getTopStories:(void (^)(NSError *error))completion {
    self.requestType = RequestTypeTopStories;
    [self topStories:^(id items, NSError *error) {
        if (!error) {
            [self parseItemsIntoStories:items withCompletion:^{
                if (completion) completion(nil);
            }];
        } else {
            if (completion) completion(error);
        }
    }];
}

- (void)getLatestStories:(void (^)(NSError *error))completion {
    self.requestType = RequestTypeLatestStories;
    [self newStories:^(id items, NSError *error) {
        if (!error) {
            [self parseItemsIntoStories:items withCompletion:^{
                if (completion) completion(nil);
            }];
        } else {
            if (completion) completion(error);
        }
    }];
}

- (void)getJobStories:(void (^)(NSError *error))completion {
    self.requestType = RequestTypeJobStories;
    [self jobStories:^(id jobs, NSError *error) {
        if (!error) {
            [self parseItemsIntoStories:jobs withCompletion:^{
                if (completion) completion(nil);
            }];
        } else {
            if (completion) completion(error);
        }
    }];
}

- (void)getCommentsForItem:(HHackerNewsItem*)item completion:(void (^)(id comments, NSError *error))completion {

    dispatch_group_t group = dispatch_group_create();
    
    NSMutableArray *tempComments = [NSMutableArray array];
    for (int i = 0; i < item.comments.count; i++) {
        dispatch_group_enter(group);

        NSString *comment = [NSString stringWithFormat:@"%@",item.comments[i]];
        [self itemWithID:comment completion:^(id item, NSError *error) {
            dispatch_group_leave(group);
            HComment *newComment = [HComment itemWithHNDictionary:item];
            [tempComments addObject:newComment];
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) completion(tempComments,nil);
    });
}

#pragma mark - Parsing Individual Stories
- (void)parseItemsIntoStories:(id)items withCompletion:(void (^)())completion {
    NSInteger totalItemCount = [items count];
    NSInteger fetchCount = (totalItemCount > kDefaultItemFetchCount) ? kDefaultItemFetchCount : totalItemCount;
    NSMutableArray *tempStories = [NSMutableArray arrayWithNullObjectCount:fetchCount];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < fetchCount; i++) {
        dispatch_group_enter(group);
        
        [self itemWithID:items[i] completion:^(id storyDictionary, NSError *error) {
            dispatch_group_leave(group);
            
            HHackerNewsItem *newsItem;
            switch (self.requestType) {
                case RequestTypeJobStories: {
                    newsItem = [HJob itemWithHNDictionary:storyDictionary];
                    break;
                }
                default: {
                    newsItem = [HStory itemWithHNDictionary:storyDictionary];
                    break;
                }
            }
            
            [tempStories replaceObjectAtIndex:i withObject:newsItem];
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.allStories = [NSMutableArray arrayWithArray:tempStories];
        if (completion) completion();
    });
}

#pragma mark - Hacker News API Requests
- (void)topStories:(void (^)(id stories, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNTopStoriesKey]];
    [HHackerNewsRequestModel requestWithURLAddress:address completion:completion];
}

- (void)newStories:(void (^)(id stories, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNNewStoriesKey]];
    [HHackerNewsRequestModel requestWithURLAddress:address completion:completion];
}

- (void)jobStories:(void (^)(id jobs, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNJobStoriesKey]];
    [HHackerNewsRequestModel requestWithURLAddress:address completion:completion];
}

- (void)itemWithID:(NSString*)itemID completion:(void (^)(id item, NSError *error))completion {
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
+ (NSMutableArray*)arrayWithNullObjectCount:(NSInteger)count {
    NSMutableArray *nullArray = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        [nullArray addObject:[NSNull null]];
    }
    return nullArray;
}
@end