//
//  HHackerNewsSearchModel.h
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHackerNewsItem.h"

@interface HHackerNewsRequestModel : NSObject

@property (nonatomic, readonly) NSMutableArray *allStories;

- (void)getTopStories:(void (^)(BOOL success, NSError *error))completion;

- (void)getCommentsForItem:(HHackerNewsItem*)item completion:(void (^)(NSArray *comments, NSError *error))completion;

@end

@interface NSString (URLFormatting)
+ (NSString*)HNAPIFormattedString:(NSString*)string;
@end

@interface NSMutableArray (HNAdditions)
+ (NSMutableArray*)arrayWithNullObjectCount:(int)count;
@end
