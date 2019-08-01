// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "GoogleMapGroundOverlayController.h"
#import "JsonConversions.h"

@implementation FLTGoogleMapGroundOverlayController {
  GMSGroundOverlay* _groundOverlay;
  GMSMapView* _mapView;
}

- (instancetype)initGroundOverlayWithBounds:(nullable GMSCoordinateBounds*)bounds
                            groundOverlayId:(NSString*)groundOverlayId
                                       icon:(nullable UIImage*)image
                                    mapView:(GMSMapView*)mapView {
  self = [super init];
  if (self) {
    _groundOverlay = [GMSGroundOverlay groundOverlayWithBounds:bounds icon:image];
    _mapView = mapView;
    _groundOverlayId = groundOverlayId;
    _groundOverlay.userData = @[ groundOverlayId ];
  }
  return self;
}

- (instancetype)initGroundOverlayWithPosition:(CLLocationCoordinate2D)position
                              groundOverlayId:(NSString*)groundOverlayId
                                         icon:(nullable UIImage*)image
                                      mapView:(GMSMapView*)mapView {
  self = [super init];
  if (self) {
    _groundOverlay = [GMSGroundOverlay groundOverlayWithPosition:position icon:image zoomLevel:1.0f];
    _mapView = mapView;
    _groundOverlayId = groundOverlayId;
    _groundOverlay.userData = @[ groundOverlayId ];
  }
  return self;
}

- (void)removeGroundOverlay {
  _groundOverlay.map = nil;
}

#pragma mark - FLTGoogleMapGroundOverlayOptionsSink methods

- (void)setConsumeTapEvents:(BOOL)consumes {
  _groundOverlay.tappable = consumes;
}
- (void)setAnchorU:(CGFloat)anchorU {
  _groundOverlay.anchor = CGPointMake(anchorU, _groundOverlay.anchor.y);
}
- (void)setAnchorV:(CGFloat)anchorV {
  _groundOverlay.anchor = CGPointMake(_groundOverlay.anchor.x, anchorV);
}
- (void)setBearing:(CLLocationDirection)bearing {
  _groundOverlay.bearing = bearing;
}
- (void)setBounds:(GMSCoordinateBounds*)bounds {
  _groundOverlay.bounds = bounds;
}
- (void)setHeight:(CGFloat)height {
  //_groundOverlay.height = height;
}
- (void)setImage:(UIImage*)image {
  _groundOverlay.icon = image;
}
- (void)setPosition:(CLLocationCoordinate2D)position {
  _groundOverlay.position = position;
}
- (void)setTransparency:(CGFloat)transparency {
  CGFloat opacity = 1 - transparency;

  if (opacity < 0.0f) opacity = 0.0f;
  else if (opacity > 1.0f) opacity = 1.0f;

  _groundOverlay.opacity = opacity;
}
- (void)setVisible:(BOOL)visible {
  _groundOverlay.map = visible ? _mapView : nil;
}
- (void)setWidth:(CGFloat)width {
  //_groundOverlay.width = width;
}
- (void)setZIndex:(CGFloat)zIndex {
  _groundOverlay.zIndex = zIndex;
}
@end

static int ToInt(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toInt:data];
}

static int ToFloat(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toFloat:data];
}

static BOOL ToBool(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toBool:data];
}

static CLLocationCoordinate2D ToLocation(NSArray* data) {
  return [FLTGoogleMapJsonConversions toLocation:data];
}

static CLLocationDirection ToLocationDirection(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toLocationDirection:data];
}

static GMSCoordinateBounds* ToBounds(NSArray* data) {
  return [FLTGoogleMapJsonConversions toBounds:data];
}

static CLLocationDistance ToDistance(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toFloat:data];
}

static UIColor* ToColor(NSNumber* data) {
  return [FLTGoogleMapJsonConversions toColor:data];
}

static UIImage* ToImage(NSArray* data) {
  return [FLTGoogleMapJsonConversions toImage:data];
}

static void InterpretGroundOverlayOptions(NSDictionary* data, id<FLTGoogleMapGroundOverlayOptionsSink> sink, NSObject<FlutterPluginRegistrar>* registrar) {
  NSNumber* consumeTapEvents = data[@"consumeTapEvents"];
  if (consumeTapEvents) {
    [sink setConsumeTapEvents:ToBool(consumeTapEvents)];
  }

  NSNumber* anchorU = data[@"anchorU"];
  if (anchorU) {
    [sink setAnchorU:ToFloat(anchorU)];
  }

  NSNumber* anchorV = data[@"anchorV"];
  if (anchorV) {
    [sink setAnchorV:ToFloat(anchorV)];
  }

  NSNumber* bearing = data[@"bearing"];
  if (bearing) {
    [sink setBearing:ToLocationDirection(bearing)];
  }

  NSArray* bounds = data[@"bounds"];
  if (bounds) {
    [sink setBounds:ToBounds(bounds)];
  }

  NSNumber* height = data[@"height"];
  if (height) {
    [sink setHeight:ToFloat(height)];
  }

  NSArray* image = data[@"image"];
  if (image) {
    [sink setImage:ToImage(image)];
  }

  NSArray* position = data[@"position"];
  if (position) {
    [sink setPosition:ToLocation(position)];
  }

  NSNumber* transparency = data[@"transparency"];
  if (transparency) {
    [sink setTransparency:ToFloat(transparency)];
  }

  NSNumber* visible = data[@"visible"];
  if (visible) {
    [sink setVisible:ToBool(visible)];
  }

  NSNumber* width = data[@"width"];
  if (width) {
    [sink setWidth:ToFloat(width)];
  }

  NSNumber* zIndex = data[@"zIndex"];
  if (zIndex) {
    [sink setZIndex:ToFloat(zIndex)];
  }
}

@implementation FLTGroundOverlaysController {
  NSMutableDictionary* _groundOverlayIdToController;
  FlutterMethodChannel* _methodChannel;
  NSObject<FlutterPluginRegistrar>* _registrar;
  GMSMapView* _mapView;
}
- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(GMSMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  if (self) {
    _methodChannel = methodChannel;
    _mapView = mapView;
    _groundOverlayIdToController = [NSMutableDictionary dictionaryWithCapacity:1];
    _registrar = registrar;
  }
  return self;
}
- (void)addGroundOverlays:(NSArray*)groundOverlaysToAdd {
  for (NSDictionary* groundOverlay in groundOverlaysToAdd) {
    GMSCoordinateBounds* bounds = [FLTGroundOverlaysController getBounds:groundOverlay];
    UIImage* image = [FLTGroundOverlaysController getImage:groundOverlay];
    NSString* groundOverlayId = [FLTGroundOverlaysController getGroundOverlayId:groundOverlay];
    FLTGoogleMapGroundOverlayController* controller =
        [[FLTGoogleMapGroundOverlayController alloc] initGroundOverlayWithBounds:bounds
                                                                 groundOverlayId:groundOverlayId
                                                                            icon:image
                                                                         mapView:_mapView];
    InterpretGroundOverlayOptions(groundOverlay, controller, _registrar);
    _groundOverlayIdToController[groundOverlayId] = controller;
  }
}
- (void)changeGroundOverlays:(NSArray*)groundOverlaysToChange {
  for (NSDictionary* groundOverlay in groundOverlaysToChange) {
    NSString* groundOverlayId = [FLTGroundOverlaysController getGroundOverlayId:groundOverlay];
    FLTGoogleMapGroundOverlayController* controller = _groundOverlayIdToController[groundOverlayId];
    if (!controller) {
      continue;
    }
    InterpretGroundOverlayOptions(groundOverlay, controller, _registrar);
  }
}
- (void)removeGroundOverlayIds:(NSArray*)groundOverlayIdsToRemove {
  for (NSString* groundOverlayId in groundOverlayIdsToRemove) {
    if (!groundOverlayId) {
      continue;
    }
    FLTGoogleMapGroundOverlayController* controller = _groundOverlayIdToController[groundOverlayId];
    if (!controller) {
      continue;
    }
    [controller removeGroundOverlay];
    [_groundOverlayIdToController removeObjectForKey:groundOverlayId];
  }
}
- (bool)hasGroundOverlayWithId:(NSString*)groundOverlayId {
  if (!groundOverlayId) {
    return false;
  }
  return _groundOverlayIdToController[groundOverlayId] != nil;
}
- (void)onGroundOverlayTap:(NSString*)groundOverlayId {
  if (!groundOverlayId) {
    return;
  }
  FLTGoogleMapGroundOverlayController* controller = _groundOverlayIdToController[groundOverlayId];
  if (!controller) {
    return;
  }
  [_methodChannel invokeMethod:@"groundOverlay#onTap" arguments:@{@"groundOverlayId" : groundOverlayId}];
}
+ (GMSCoordinateBounds*)getBounds:(NSDictionary*)groundOverlay {
  NSArray* bounds = groundOverlay[@"bounds"];
  return ToBounds(bounds);
}
+ (CLLocationCoordinate2D)getPosition:(NSDictionary*)groundOverlay {
  NSArray* position = groundOverlay[@"position"];
  return ToLocation(position);
}
+ (UIImage*)getImage:(NSDictionary*)groundOverlay {
  NSArray* image = groundOverlay[@"image"];
  return ToImage(image);
}
+ (NSString*)getGroundOverlayId:(NSDictionary*)groundOverlay {
  return groundOverlay[@"groundOverlayId"];
}
@end
