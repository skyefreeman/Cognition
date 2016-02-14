//
//  HackerNewsManager.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HNManagerDelegate.h"
#import "HNCommunicatorDelegate.h"

@class HNCommunicator;
@class HNItemBuilder;

@interface HNManager : NSObject <HNCommunicatorDelegate>

@property (nonatomic, weak) id <HNManagerDelegate> delegate;

/** @brief Performs all Hacker News API web requests. */
@property (strong) HNCommunicator *communicator;

/** @brief Take's Hacker News Items and builds HNItems. */
@property (strong) HNItemBuilder *itemBuilder;

/**
 * @brief Perform a request for a single HNItem, the delegate is notified when the request completes.
 * @param identifier The Identifier number of a Hacker News Item.
 */
- (void)fetchItemForIdentifier:(NSInteger)identifier;

/**
 * @brief Performs a request retrieving all child HNItems of the passed in HNItem.
 * @param item The Hacker News Item to retrieve children items from.
 */
- (void)fetchCommentsForItem:(HNItem*)item;

/**
 * @brief Perform a top story request for an NSArray of HNItems, the delegate is notified when the request completes.
 */
- (void)fetchTopStories;

/**
 * @brief Perform a new story request for an NSArray of HNItems, the delegate is notified when the request completes.
 */
- (void)fetchNewStories;

/**
 * @brief Perform a ask story request for an NSArray of HNItems, the delegate is notified when the request completes.
 */
- (void)fetchAskStories;

/**
 * @brief Perform a show story request for an NSArray of HNItems, the delegate is notified when the request completes.
 */
- (void)fetchShowStories;

/**
 * @brief Perform a job story request for an NSArray of HNItems, the delegate is notified when the request completes.
 */
- (void)fetchJobStories;

/**
 * @brief Performs a request of the last request type, the delegate is notified when the request completes.
 */
- (void)refreshLastStories;

/**
 * @brief Performs a request of the last request type, retrieving the next 30 items, the delegate is notified when the request completes.
 */
- (void)fetchNextStories;

@end

extern NSString *HackerNewsManagerError;
typedef NS_ENUM(NSInteger, HackerNewsManagerErrorCode) {
    HackerNewsManagerErrorCodeFetch,
    HackerNewsManagerErrorCodePagination,
};

