//
//  HHackerNewsSearchModel.h
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHackerNewsItem.h"

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeTopStories = 0,
    RequestTypeLatestStories,
    RequestTypeJobStories,
};

@interface HHackerNewsRequestModel : NSObject

@property (nonatomic) RequestType requestType;
@property (nonatomic, readonly) NSMutableArray *allStories;

- (void)getTopStories:(void (^)(BOOL success, NSError *error))completion;
- (void)getLatestStories:(void (^)(BOOL success, NSError *error))completion;
- (void)getJobStories:(void (^)(BOOL success, NSError *error))completion;

- (void)getCommentsForItem:(HHackerNewsItem*)item completion:(void (^)(id comments, NSError *error))completion;

@end

@interface NSString (URLFormatting)
+ (NSString*)HNAPIFormattedString:(NSString*)string;
@end

@interface NSMutableArray (HNAdditions)
+ (NSMutableArray*)arrayWithNullObjectCount:(NSInteger)count;
@end
