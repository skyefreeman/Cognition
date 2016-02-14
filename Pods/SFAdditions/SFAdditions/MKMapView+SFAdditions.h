//
//  MKMapView+SFAdditions.h
//
//  Created by Skye on 6/14/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (Zooming)
- (void)zoomToUserWithRadius:(CGFloat)radius animated:(BOOL)animated;
- (void)zoomToRadius:(CGFloat)radius animated:(BOOL)animated;
- (void)zoomToLocation:(CLLocationCoordinate2D)location radius:(CGFloat)radius animated:(BOOL)animated;
@end

@interface MKMapView (Conversions)
+ (CGFloat)milesToMeters:(CGFloat)miles;
@end