//
//  HackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNCommunicatorDelegate.h"

@interface HNCommunicator : NSObject <NSURLSessionDataDelegate> {
@protected
    NSURL *fetchingURL;
    NSURLSession *session;
    NSURLSessionDataTask *fetchingTask;
    NSMutableData *receivedData;
@private
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (nonatomic, weak) id <HNCommunicatorDelegate> delegate;

- (void)fetchTopStories;
- (void)fetchNewStories;
- (void)fetchAskStories;
- (void)fetchShowStories;
- (void)fetchJobStories;
- (void)fetchItemForIdentifier:(NSInteger)identifier;
- (void)fetchItemForIdentifier:(NSInteger)identifier completion:(void (^)(NSString *objectNotation, NSError *error))completion;

@end

extern NSString *HackerNewsCommunicatorError;