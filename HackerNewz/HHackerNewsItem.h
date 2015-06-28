//
//  HHackerNewsItem.h
//  HackerNewz
//
//  Created by Skye on 6/28/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHackerNewsItem : NSObject

+ (instancetype)itemWithHNDictionary:(id)dictionary;

@property (nonatomic) NSInteger ID;

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *text;

@property (nonatomic) NSInteger commentCount;
@property (nonatomic) NSArray *comments;

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger time;

@end
