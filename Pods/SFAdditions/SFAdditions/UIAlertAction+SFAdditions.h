//
//  UIAlertAction+SFAdditions.h
//
//  Created by Skye on 5/1/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertActionCompletion)(BOOL);

@interface UIAlertAction (SFAdditions)

+ (UIAlertAction*)actionWithTitle:(NSString*)title completion:(AlertActionCompletion)completion;

@end
