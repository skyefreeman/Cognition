//
//  HackerNewsCommunicatorDelegate.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HNCommunicatorDelegate <NSObject>

@optional
- (void)communicatorItemFetchFailedWithError:(NSError*)error;
- (void)communicatorTopStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorNewStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorAskStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorShowStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorJobStoriesFetchFailedWithError:(NSError*)error;

- (void)recievedItemWithJSON:(NSString*)objectNotation;
- (void)recievedTopStoriesWithJSON:(NSString*)objectNotation;
- (void)recievedNewStoriesWithJSON:(NSString*)objectNotation;
- (void)recievedAskStoriesWithJSON:(NSString*)objectNotation;
- (void)recievedShowStoriesWithJSON:(NSString*)objectNotation;
- (void)recievedJobsStoriesWithJSON:(NSString*)objectNotation;
@end
