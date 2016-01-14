//
//  CStoryViewModel.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HNItem;

@interface CStoryViewModel : NSObject

@property (nonatomic) HNItem *originalItem;

@property (nonatomic, copy) NSString *commentCountString;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *storyInfoString;

- (instancetype)initWithHNItem:(HNItem*)item;
@end
