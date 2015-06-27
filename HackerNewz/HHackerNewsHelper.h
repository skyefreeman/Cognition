//
//  HHackerNewsHelper.h
//  HackerNewz
//
//  Created by Skye on 6/26/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHackerNewsHelper : NSObject
+ (void)topStories:(void (^)(id stories, NSError *error))completion;
@end

@interface NSString (URLFormatting)
+ (NSString*)HNAPIFormattedString:(NSString*)string;
@end