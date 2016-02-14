//
//  HackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNManager.h"

// Communicator
#import "HNCommunicator.h"

// Builders
#import "HNItemBuilder.h"

// Helpers
#import "HNSortHelper.h"

// Models
#import "HNItem.h"

// Constants
NSString *HackerNewsManagerError = @"HackerNewsManagerError";
NSInteger const kMaxFetchCount = 30;

typedef NS_ENUM(NSUInteger, HNFetchType) {
    HNFetchTypeNone = 0,
    HNFetchTypeTopStories,
    HNFetchTypeNewStories,
    HNFetchTypeAskStories,
    HNFetchTypeShowStories,
    HNFetchTypeJobStories,
};

@interface HNManager()

// Cached Properties
@property (nonatomic, copy) NSString *cachedItemJSON;
@property (nonatomic) NSInteger fetchStartIndex;
@property (nonatomic, assign) HNFetchType lastFetchType;

// Fetching Queued Items
- (void)getItemsForItemIdentifiers:(NSArray*)itemIDs withSuccess:(void (^)(NSArray *))completion;
- (void)getItemsForJSON:(NSString*)itemJSON withSuccess:(void (^)(NSArray *itemObjects))completion;

// Error Reporting
- (void)tellDelegateAboutFetchError:(NSError*)error;
- (void)tellDelegateAboutPaginationError;

- (NSError*)reportableErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode;
- (NSDictionary*)errorInfoFromError:(NSError*)error;

// Convenience
- (NSArray*)arrayFromJSON:(NSString*)objectNotation;

@end

@implementation HNManager


- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.communicator = [[HNCommunicator alloc] init];
    self.communicator.delegate = self;
    
    self.itemBuilder = [[HNItemBuilder alloc] init];
    
    return self;
}

- (void)setDelegate:(id<HNManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(HNManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol." userInfo:nil] raise];
    }
    _delegate = delegate;
}

#pragma mark - Stories
- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self.communicator fetchItemForIdentifier:identifier];
}

- (void)fetchCommentsForItem:(HNItem*)item {
    [self getItemsForItemIdentifiers:item.kids withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveItemComments:itemObjects];
    }];
}

- (void)fetchTopStories {
    self.lastFetchType = HNFetchTypeTopStories;
    [self.communicator fetchTopStories];
}

- (void)fetchNewStories {
    self.lastFetchType = HNFetchTypeNewStories;
    [self.communicator fetchNewStories];
}

- (void)fetchAskStories {
    self.lastFetchType = HNFetchTypeAskStories;
    [self.communicator fetchAskStories];
}

- (void)fetchShowStories {
    self.lastFetchType = HNFetchTypeShowStories;
    [self.communicator fetchShowStories];
}

- (void)fetchJobStories {
    self.lastFetchType = HNFetchTypeJobStories;
    [self.communicator fetchJobStories];
}

- (void)refreshLastStories {
    switch (self.lastFetchType) {
        case HNFetchTypeNone:
            break;
            
        case HNFetchTypeTopStories:
            [self fetchTopStories];
            break;
            
        case HNFetchTypeNewStories:
            [self fetchNewStories];
            break;
            
        case HNFetchTypeAskStories:
            [self fetchAskStories];
            break;
            
        case HNFetchTypeShowStories:
            [self fetchShowStories];
            break;
            
        case HNFetchTypeJobStories:
            [self fetchJobStories];
            break;
    }
}

- (void)fetchNextStories {
    if (self.cachedItemJSON == nil) {
        [self tellDelegateAboutPaginationError];
        return;
    }
    
    self.fetchStartIndex += kMaxFetchCount;
    
    switch (self.lastFetchType) {
        case HNFetchTypeNone:
            break;
            
        case HNFetchTypeTopStories: {
            [self recievedTopStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case HNFetchTypeNewStories: {
            [self recievedNewStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case HNFetchTypeAskStories: {
            [self recievedAskStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case HNFetchTypeShowStories: {
            [self recievedShowStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case HNFetchTypeJobStories: {
            [self recievedJobsStoriesWithJSON:self.cachedItemJSON];
            break;
        }
    }
}

#pragma mark - Setter Override
- (void)setLastFetchType:(HNFetchType)cachedItemFetchType {
    _lastFetchType = cachedItemFetchType;
    self.fetchStartIndex = 0;
}

#pragma mark - HackerNewsCommunicator Delegate
- (void)communicatorItemFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorTopStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorNewStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorAskStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorShowStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorJobStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)recievedItemWithJSON:(NSString *)objectNotation {
    NSError *error = nil;
    HNItem *item  = [_itemBuilder itemFromJSON:objectNotation error:&error];
    if (!item) {
        [self tellDelegateAboutFetchError:error];
    } else {
        [self.delegate didReceiveItem:item];
    }
}

- (void)recievedTopStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveTopStories:itemObjects];
    }];
}

- (void)recievedNewStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveNewStories:itemObjects];
    }];
}

- (void)recievedAskStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveAskStories:itemObjects];
    }];
}

- (void)recievedShowStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveShowStories:itemObjects];
    }];
}

- (void)recievedJobsStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveJobStories:itemObjects];
    }];
}

#pragma mark - Item Fetch + Building
- (void)getItemsForJSON:(NSString*)itemJSON withSuccess:(void (^)(NSArray *itemObjects))successHandler {
    self.cachedItemJSON = itemJSON;
    NSArray *itemIdentifiers = [self arrayFromJSON:itemJSON];
    [self getItemsForItemIdentifiers:itemIdentifiers withSuccess:successHandler];
}

- (void)getItemsForItemIdentifiers:(NSArray*)itemIDs withSuccess:(void (^)(NSArray *))successHandler {
    NSInteger remainingItemIDs = itemIDs.count - _fetchStartIndex;
    NSInteger fetchableItemCount = (remainingItemIDs > 0) ? remainingItemIDs : 0;
    NSInteger fetchCount = (remainingItemIDs > kMaxFetchCount) ? kMaxFetchCount : fetchableItemCount;
    
    [self performItemRequestsWithItemIdentifiers:itemIDs withCount:fetchCount startIndex:_fetchStartIndex withCompletion:^(NSArray *itemObjects) {
        NSError *error = nil;

        // Turns json into HNItem objects
        NSArray *builtItems = [_itemBuilder itemsFromJSONArray:itemObjects error:&error];
        
        // Sort HNItems to fix mismatched request completions
        // If FetchType is 'New', then sort by time, else sort to match identifiers
        
        NSArray *sortedBuiltItems;
        if (self.lastFetchType == HNFetchTypeNewStories) {
            sortedBuiltItems = [HNSortHelper sortHNItems:builtItems];
        } else {
            sortedBuiltItems = [HNSortHelper sortHNItems:builtItems toMatchIdentifiers:itemIDs];
        }
        
        if (!sortedBuiltItems) {
            [self tellDelegateAboutFetchError:error];
        } else {
            if (successHandler) successHandler(sortedBuiltItems);
        }
    }];
}

- (void)performItemRequestsWithItemIdentifiers:(NSArray *)itemIDs
                                     withCount:(NSInteger)itemCount
                                    startIndex:(NSInteger)startIndex
                                withCompletion:(void (^)(NSArray *itemObjects))completion
{
    NSMutableArray *itemObjects = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = startIndex; i < (startIndex + itemCount); i++) {
        
        dispatch_group_enter(group);
        NSString *IDString = itemIDs[i];
        HNCommunicator *communicator = [[HNCommunicator alloc] init];
        [communicator fetchItemForIdentifier:[IDString integerValue] completion:^(NSString *objectNotation, NSError *error) {
            if (objectNotation) {
                [itemObjects addObject:objectNotation];
            }
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) completion(itemObjects);
    });
}

#pragma mark - Error Handling
- (void)tellDelegateAboutFetchError:(NSError*)error {
    NSError *reportableError = [self reportableErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeFetch];
    [self.delegate hackerNewsFetchFailedWithError:reportableError];
}

- (void)tellDelegateAboutPaginationError {
    NSError *error = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodePagination userInfo:nil];
    [self.delegate hackerNewsFetchFailedWithError:error];
}

- (NSError*)reportableErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode {
    NSDictionary *errorInfo = [self errorInfoFromError:error];
    return [NSError errorWithDomain:errorDomain code:errorCode userInfo:errorInfo];
}

- (NSDictionary*)errorInfoFromError:(NSError*)error {
    if (error) {
        return [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    return nil;
}

#pragma mark - Convenience 
- (NSArray*)arrayFromJSON:(NSString*)objectNotation {
    NSError *localError = nil;
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options: 0 error:&localError];
    return [NSArray arrayWithArray:jsonObject];
}

@end
