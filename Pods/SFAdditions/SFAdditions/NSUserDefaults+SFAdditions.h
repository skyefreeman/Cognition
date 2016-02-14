//
//  NSUserDefaults+SFAdditions.h
//  SFAdditions
//
//  Created by Skye on 8/11/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (SFAdditions)

+ (void)setObject:(id)aObject forKey:(NSString*)key;
+ (id)getObjectForKey:(NSString*)key;

+ (void)setBool:(BOOL)aBool forKey:(NSString*)key;
+ (BOOL)getBoolForKey:(NSString*)key;

+ (void)setCustomObject:(id)aObject forKey:(NSString*)key;
+ (id)getCustomObjectForKey:(NSString*)key;

@end
