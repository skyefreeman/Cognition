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
    
    NSMutableArray *tempStories = [NSMutableArray arrayWithNullObjectCount:kItemFetchCount];
    
    [self topStories:^(id stories, NSError *error) {
        if (!error) {
            dispatch_group_t group = dispatch_group_create();
            
            for (int i = 0; i < kItemFetchCount; i++) {
                dispatch_group_enter(group);
                
                [self itemWithID:stories[i] completion:^(id storyDictionart, NSError *error) {
                    dispatch_group_leave(group);
                    HStory *newStory = [HStory itemWithHNDictionary:storyDictionart];
                    [tempStories replaceObjectAtIndex:i withObject:newStory];
                }];
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                self.allStories = [NSMutableArray arrayWithArray:tempStories];
                if (completion) completion(YES,nil);
            });
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
            HComment *newComment = [HComment itemWithHNDictionary:item];
            [tempComments addObject:newComment];
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) completion(tempComments,nil);
        NSLog(@"Done getting comments");
    });
}

#pragma mark - Hacker News API Requests
- (void)topStories:(void (^)(id stories, NSError *error))completion {
    NSString *address = [NSString HNAPIFormattedString:[NSString stringWithFormat:@"%@%@",kHNAPIAddress,kHNTopStoriesKey]];
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
+ (NSMutableArray*)arrayWithNullObjectCount:(int)count {
    NSMutableArray *nullArray = [NSMutableArray array];
    for (int i = 0 ; i<count; i++) {
        [nullArray addObject:[NSNull null]];
    }
    return nullArray;
}
@end