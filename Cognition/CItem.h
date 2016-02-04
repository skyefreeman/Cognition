//
//  CItem.h
//  Cognition
//
//  Created by Skye on 2/1/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Realm/Realm.h>

@interface CItem : RLMObject

@property (assign) NSInteger identifier;

@property (copy) NSString *type;
@property (copy) NSString *by;
@property (copy) NSString *text;
@property (copy) NSString *url;
@property (copy) NSString *title;

@property (assign) NSInteger time;
@property (assign) NSInteger parent;
@property (assign) NSInteger descendants;
@property (assign) NSInteger score;

//@property (copy) RLMArray *kids;
//@property (copy) RLMArray *parts;

@end
