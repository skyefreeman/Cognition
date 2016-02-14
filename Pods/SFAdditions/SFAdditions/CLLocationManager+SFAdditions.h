//
//  CLLocationManager+SFAdditions.h
//
//  Created by Skye on 6/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RequestLocationPermissionType) {
    RequestLocationPermissionTypeWhenInUse,
    RequestLocationPermissionTypeAlways,
};

@interface CLLocationManager (SFAdditions)

+ (UIAlertController*)userEnableLocationAlertWhenInUse;
+ (UIAlertController*)userEnableLocationAlertAlways;

/* 
 Don't forget to set 'NSLocationWhenInUseUsageDescription' or 'NSLocationAlwaysUsageDescription'
 property in app target plist for location services to work.
 */
- (void)requestLocationPermission:(RequestLocationPermissionType)type
                          success:(void (^)())successHandler
                          failure:(void (^)())failureHandler;
@end
