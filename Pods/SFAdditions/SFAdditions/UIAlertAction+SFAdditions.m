//
//  UIAlertAction+SFAdditions.m
//
//  Created by Skye on 5/1/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "UIAlertAction+SFAdditions.h"

@implementation UIAlertAction (SFAdditions)

+ (UIAlertAction*)actionWithTitle:(NSString*)title completion:(AlertActionCompletion)completion {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completion(YES);
    }];
    return action;
}

@end
