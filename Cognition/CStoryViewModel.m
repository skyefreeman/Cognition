//
//  CStoryViewModel.m
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CStoryViewModel.h"

// Models
#import "HNItem.h"

// Libaries
#import "TTTTimeIntervalFormatter.h"

@implementation CStoryViewModel
- (instancetype)init {
    return nil;
}

- (instancetype)initWithHNItem:(HNItem *)item {
    self = [super init];
    if (!self) return nil;
    
    self.originalItem = item;
    
    self.commentCountString = [self _createCommentCountStringWithCount:item.descendants];
    self.storyInfoString = [self _createStoryInfoStringWithScore:item.score author:item.by time:item.time];
    self.urlString = [self _createUrlStringWithURLString:item.url];
    
    return self;
}

- (NSString*)_createCommentCountStringWithCount:(NSInteger)count {
    return [NSString stringWithFormat:@"%lu",count];
}

- (NSString*)_createStoryInfoStringWithScore:(NSInteger)score author:(NSString*)author time:(NSInteger)time {
    NSString *pointsString = (score > 1) ? [NSString stringWithFormat:@"%lu points ",(long)score] : @"";
    NSString *authorString = [NSString stringWithFormat:@"by %@",author];
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:time];
    TTTTimeIntervalFormatter *formatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeString = [formatter stringForTimeIntervalFromDate:[NSDate date] toDate:postDate];
    
    return [NSString stringWithFormat:@"%@%@ %@",pointsString,authorString,timeString];
}

- (NSString*)_createUrlStringWithURLString:(NSString*)urlString {
    NSInteger slashCount = 0;
    for (int i = 0; i < urlString.length; i++) {
        NSString *thisChar = [urlString substringWithRange:NSMakeRange(i, 1)];
        if ([thisChar isEqualToString:@"/"]) {
            slashCount++;
        }

        if (slashCount >= 3) {
            return [urlString substringToIndex:i];
        }
    }
    
    return urlString;
}

@end
