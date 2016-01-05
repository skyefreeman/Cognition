//
//  UIViewController+ErrorAdditions.m
//  HackerNewz
//
//  Created by Skye on 1/4/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import "UIViewController+ErrorAdditions.h"
#import <SFAdditions.h>

@implementation UIViewController (ErrorAdditions)
- (void)errorAlert_checkInternetConnection {
    [self showAlertWithTitle:@"Error" message:[NSString stringWithFormat:@"Problem retrieving stories. Check your internet connection."]];
}
@end
