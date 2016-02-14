//
//  CLLocationManager+SFAdditions.m
//
//  Created by Skye on 6/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CLLocationManager+SFAdditions.h"

@implementation CLLocationManager (SFAdditions)

- (void)requestLocationPermission:(RequestLocationPermissionType)type
                          success:(void (^)())successHandler
                          failure:(void (^)())failureHandler
{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined: {

            switch (type) {
                case RequestLocationPermissionTypeWhenInUse: {
                    [self requestWhenInUseAuthorization];
                    break;
                }
                case RequestLocationPermissionTypeAlways: {
                    [self requestAlwaysAuthorization];
                    break;
                }
            }
            if (successHandler) successHandler();
            
            break;
        }
        case kCLAuthorizationStatusRestricted: {
            if (failureHandler) failureHandler();
            break;
        }
        case kCLAuthorizationStatusDenied: {
            if (failureHandler) failureHandler();
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways: {
            if (successHandler) successHandler();
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            if (successHandler) successHandler();
            break;
        }
    }
}

#pragma mark - Enable User Location Manager Alert Actions
+ (UIAlertController*)userEnableLocationAlertWhenInUse {
    return [CLLocationManager locationAlertWithMessage:@"To enabled location services please turn on 'When In Use' in the location services settings. Would you like to change it now?"];
}

+ (UIAlertController*)userEnableLocationAlertAlways {
    return [CLLocationManager locationAlertWithMessage:@"To enabled location services please turn on 'Always' in the location services settings. Would you like to change it now?"];
}

+ (UIAlertController*)locationAlertWithMessage:(NSString*)message {
    // Create Alert Actions
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    
    NSArray *alertActions = [NSArray arrayWithObjects:settingsAction,cancelAction, nil];
    
    // Define Alert title and message
    NSString *title = @"Background Services Not Enabled";

    // Create an alert and attach actions
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (UIAlertAction *action in alertActions) {
        [alert addAction:action];
    }
    return alert;
}

@end
