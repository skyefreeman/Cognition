//
//  HComment.m
//  HackerNewz
//
//  Created by Skye on 7/17/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HComment.h"
#import "HConstants.h"

@implementation HComment
- (instancetype)initWithHNDictionary:(id)HNDictionary {
    self = [super initWithHNDictionary:HNDictionary];
    if (self) {
        self.author = [HNDictionary objectForKey:kByKey];
        self.itemID = [[HNDictionary objectForKey:kIDKey] integerValue];
        self.comments = [HNDictionary objectForKey:kKidsKey];
        self.parent = [[HNDictionary objectForKey:kParentKey] integerValue];
        self.time = [[HNDictionary objectForKey:kTimeKey] integerValue];
        self.type = [HNDictionary objectForKey:kTypeKey];
        
        NSString *textObject = [HNDictionary objectForKey:kTextKey];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[textObject dataUsingEncoding:NSUnicodeStringEncoding]
                                                                               options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                                    documentAttributes:nil
                                                                                  error:nil];
        self.text = attributedString;
    }
    return self;
}
@end
