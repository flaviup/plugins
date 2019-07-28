// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>
#import <GoogleMaps/GoogleMaps.h>

// Defines ground overlay UI options writable from Flutter.
@protocol FLTGoogleMapGroundOverlayOptionsSink
- (void)setConsumeTapEvents:(BOOL)consume;
- (void)setAnchorU:(CGFloat)anchorU;
- (void)setAnchorV:(CGFloat)anchorV;
- (void)setBearing:(CLLocationDirection)bearing;
- (void)setBounds:(GMSCoordinateBounds*)bounds;
- (void)setHeight:(CGFloat)height;
- (void)setImage:(UIImage*)image;
- (void)setPosition:(CLLocationCoordinate2D)position;
- (void)setTransparency:(CGFloat)transparency;
- (void)setVisible:(BOOL)visible;
- (void)setWidth:(CGFloat)width;
- (void)setZIndex:(CGFloat)zIndex;
@end

// Defines ground overlay controllable by Flutter.
@interface FLTGoogleMapGroundOverlayController : NSObject <FLTGoogleMapGroundOverlayOptionsSink>
@property(atomic, readonly) NSString* groundOverlayId;
- (instancetype)initGroundOverlayWithBounds:(nullable GMSCoordinateBounds *)bounds
                                       icon:(nullable UIImage*)image
                            groundOverlayId:(NSString*)groundOverlayId
                                    mapView:(GMSMapView*)mapView;
- (instancetype)initGroundOverlayWithPosition:(CLLocationCoordinate2D)position
                                         icon:(nullable UIImage*)image
                              groundOverlayId:(NSString*)groundOverlayId
                                      mapView:(GMSMapView*)mapView;
- (void)removeGroundOverlay;
@end

@interface FLTGroundOverlaysController : NSObject
- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(GMSMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar;
- (void)addGroundOverlays:(NSArray*)groundOverlaysToAdd;
- (void)changeGroundOverlays:(NSArray*)groundOverlaysToChange;
- (void)removeGroundOverlayIds:(NSArray*)groundOverlayIdsToRemove;
- (void)onGroundOverlayTap:(NSString*)groundOverlayId;
- (bool)hasGroundOverlayWithId:(NSString*)groundOverlayId;
@end
