//
//  NSString+SFAdditions.h
//
//  Created by Skye on 4/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringAdditions)

- (BOOL)isEmptyString;
- (BOOL)isNotEmptyString;

+ (NSString*)stringForFileName:(NSString*)fileName ofType:(NSString*)fileType;
+ (NSString*)stringWithoutNonDecimalCharacters:(NSString*)string;
+ (NSString*)phoneNumberFormattedString:(NSString*)string;

@end

@interface NSNumber (StringAdditions)
- (NSString*)toString;
@end