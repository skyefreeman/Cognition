//
//  RLMObject+SaveAdditions.h
//  Cognition
//
//  Created by Skye on 2/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMObject (SaveAdditions)
- (void)saveObject;
- (void)deleteObject;
@end