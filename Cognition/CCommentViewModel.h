//
//  CCommentViewModel.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HNItem;

@interface CCommentViewModel : NSObject
- (instancetype)initWithItem:(HNItem*)aItem;
@property (nonatomic, strong) HNItem *item;

@property (nonatomic, copy) NSString *authorString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSAttributedString *formattedComment;
@end
