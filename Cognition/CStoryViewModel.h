//
//  CStoryViewModel.h
//  HackerNewz
//
//  Created by Skye on 12/31/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CItem;

@interface CStoryViewModel : NSObject

@property (nonatomic) CItem *originalItem;

@property (nonatomic, copy) NSString *commentCountString;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *storyInfoString;

- (instancetype)initWithCItem:(CItem*)item;
@end
