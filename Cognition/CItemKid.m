//
//  CItemKid.m
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "CItemKid.h"

@implementation CItemKid
- (instancetype)initWithIdentifier:(NSInteger)identifier {
    self = [super init];
    if (!self) return nil;
    
    self.identifier = identifier;
    
    return self;
}

@end
