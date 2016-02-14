//
//  HNItem.h
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNItem : NSObject <NSCoding>

- (instancetype)initWithIdentifier:(NSInteger)identifier;

@property (assign) NSInteger identifier;

@property (copy) NSString *type;
@property (copy) NSString *by;
@property (copy) NSString *text;
@property (copy) NSString *url;
@property (copy) NSString *title;

@property (assign) NSInteger time;
@property (assign) NSInteger parent;
@property (assign) NSInteger descendants;
@property (assign) NSInteger score;

@property (copy) NSArray *kids;
@property (copy) NSArray *parts;

@end
