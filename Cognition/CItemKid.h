//
//  CItemKid.h
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Realm/Realm.h>

@interface CItemKid : RLMObject
- (instancetype)initWithIdentifier:(NSInteger)identifier;
@property (assign) NSInteger identifier;
@end

RLM_ARRAY_TYPE(CItemKid);