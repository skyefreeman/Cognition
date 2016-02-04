//
//  CCommentViewModel.h
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CItem;

@interface CCommentViewModel : NSObject
- (instancetype)initWithItem:(CItem*)aItem;
@property (nonatomic, strong) CItem *item;

@property (nonatomic, copy) NSString *authorString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *commentString;
@end
