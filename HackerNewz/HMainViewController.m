//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"
#import "HHackerNewsHelper.h"

int const kItemFetchCount = 30;

@interface HMainViewController ()
@property (nonatomic) NSMutableArray *topStories;
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topStories = [NSMutableArray arrayWithNullObjectCount:kItemFetchCount];
    [self getTopStories];
}

#pragma mark - Get Requests
- (void)getTopStories {
    [HHackerNewsHelper topStories:^(id stories, NSError *error) {
        if (!error) {
            [self getItemsFromStories:stories itemsToFetch:kItemFetchCount];
        } else {
            NSLog(@"Error getting stories: %@",error);
        }
    }];
}

- (void)getItemsFromStories:(id)stories itemsToFetch:(int)numItems {
    for (int i = 0; i < numItems; i++) {
        [HHackerNewsHelper itemWithID:[stories objectAtIndex:i] completion:^(id itemObject, NSError *error) {
            if (!error) {
                [self.topStories replaceObjectAtIndex:i withObject:itemObject];
//                [self.topStories insertObject:itemObject atIndex:i];
                NSLog(@"%@",itemObject);
            } else {
                NSLog(@"Error getting item: %@",error);
            }
        }];
    }
}

#pragma mark - Convenience

@end

@implementation NSMutableArray (SFAdditions)
+ (NSMutableArray*)arrayWithNullObjectCount:(int)count {
    NSMutableArray *nullArray = [NSMutableArray array];
    for (int i = 0 ; i<count; i++) {
        [nullArray addObject:[NSNull null]];
    }
    return nullArray;
}
@end