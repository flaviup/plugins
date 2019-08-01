// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "JsonConversions.h"

@implementation FLTGoogleMapJsonConversions

+ (bool)toBool:(NSNumber*)data {
  return data.boolValue;
}

+ (int)toInt:(NSNumber*)data {
  return data.intValue;
}

+ (double)toDouble:(NSNumber*)data {
  return data.doubleValue;
}

+ (float)toFloat:(NSNumber*)data {
  return data.floatValue;
}

+ (CLLocationCoordinate2D)toLocation:(NSArray*)data {
  return CLLocationCoordinate2DMake([FLTGoogleMapJsonConversions toDouble:data[0]],
                                    [FLTGoogleMapJsonConversions toDouble:data[1]]);
}

+ (CLLocationDirection)toLocationDirection:(NSNumber*)data {
  return data.doubleValue;
}

+ (GMSCoordinateBounds*)toBounds:(NSArray*)data {
  return [[GMSCoordinateBounds alloc] initWithCoordinate:[FLTGoogleMapJsonConversions toLocation:((NSArray*)data[0])]
                                              coordinate:[FLTGoogleMapJsonConversions toLocation:((NSArray*)data[1])]];
}

+ (CGPoint)toPoint:(NSArray*)data {
  return CGPointMake([FLTGoogleMapJsonConversions toDouble:data[0]],
                     [FLTGoogleMapJsonConversions toDouble:data[1]]);
}

+ (NSArray*)positionToJson:(CLLocationCoordinate2D)position {
  return @[ @(position.latitude), @(position.longitude) ];
}

+ (UIColor*)toColor:(NSNumber*)numberColor {
  unsigned long value = [numberColor unsignedLongValue];
  return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16)) / 255.0
                         green:((float)((value & 0xFF00) >> 8)) / 255.0
                          blue:((float)(value & 0xFF)) / 255.0
                         alpha:((float)((value & 0xFF000000) >> 24)) / 255.0];
}

+ (NSArray<CLLocation*>*)toPoints:(NSArray*)data {
  NSMutableArray* points = [[NSMutableArray alloc] init];
  for (unsigned i = 0; i < [data count]; i++) {
    NSNumber* latitude = data[i][0];
    NSNumber* longitude = data[i][1];
    CLLocation* point =
        [[CLLocation alloc] initWithLatitude:[FLTGoogleMapJsonConversions toDouble:latitude]
                                   longitude:[FLTGoogleMapJsonConversions toDouble:longitude]];
    [points addObject:point];
  }

  return points;
}

+ (UIImage*)toImage:(NSArray*)data {
  NSString* dataType = (NSString*)data[0];

  if ([dataType isEqualToString:@"fromBytes"]) {
    FlutterStandardTypedData* flutterData = (FlutterStandardTypedData*)data[1];
    return [UIImage imageWithData:[flutterData data]];
  } else if ([dataType isEqualToString:@"fromAssets"]) {
    // TODO: implementation
  }

  return nil;
}

@end
