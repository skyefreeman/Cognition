//
//  MKMapView+SFAdditions.m
//
//  Created by Skye on 6/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "MKMapView+SFAdditions.h"

@implementation MKMapView (SFAdditions)
- (void)zoomToLocation:(CLLocationCoordinate2D)location radius:(CGFloat)radius animated:(BOOL)animated {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location,
                                                                   [MKMapView milesToMeters:radius],
                                                                   [MKMapView milesToMeters:radius]);
    [self setRegion:region animated:animated];
}

- (void)zoomToUserWithRadius:(CGFloat)radius animated:(BOOL)animated {
    MKUserLocation *userlocation = self.userLocation;
    [self zoomToLocation:userlocation.location.coordinate radius:radius animated:animated];
}

- (void)zoomToRadius:(CGFloat)radius animated:(BOOL)animated {
    [self zoomToLocation:self.centerCoordinate radius:radius animated:animated];
}
@end

@implementation MKMapView (Conversions)
+ (CGFloat)milesToMeters:(CGFloat)miles {
    return (miles/0.621371f) * 1000;
}
@end
