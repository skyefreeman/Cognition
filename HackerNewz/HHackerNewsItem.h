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
- (instancetype)initWithHNDictionary:(id)dictionary;

@property (nonatomic) NSInteger itemID;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSInteger time;
@property (nonatomic) NSAttributedString *text;
@property (nonatomic) NSString *url;

@property (nonatomic) NSInteger score;
@property (nonatomic) NSArray *parts;

@property (nonatomic) NSInteger parent;
@property (nonatomic) NSArray *comments;
@property (nonatomic) NSInteger commentCount;

@end
