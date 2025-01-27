// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of google_maps_flutter;

/// Uniquely identifies a [GroundOverlay] among [GoogleMap] ground overlays.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class GroundOverlayId {
  GroundOverlayId(this.value) : assert(value != null);

  /// value of the [GroundOverlayId].
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final GroundOverlayId typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'GroundOverlayId{value: $value}';
  }
}

/// Draws a ground overlay on the map.
@immutable
class GroundOverlay {
  const GroundOverlay({
    @required this.groundOverlayId,
    this.consumeTapEvents = false,
    this.anchorU,
    this.anchorV,
    this.bearing,
    this.bounds,
    this.height,
    @required this.image,
    this.position,
    this.transparency,
    this.visible = true,
    this.width,
    this.zIndex,
    this.onTap,
  });

  /// Uniquely identifies a [GroundOverlay].
  final GroundOverlayId groundOverlayId;

  /// True if the [GroundOverlay] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  final double anchorU;
  final double anchorV;
  final double bearing;
  final LatLngBounds bounds;
  /// The ground overlay's height in screen points.
  final double height;
  final BitmapDescriptor image;
  final LatLng position;
  final double transparency;

  /// True if the ground overlay is visible.
  final bool visible;

  /// The ground overlay's width in screen points.
  final double width;

  /// The z-index of the ground overlay, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final double zIndex;

  /// Callbacks to receive tap events for ground overlays placed on this map.
  final VoidCallback onTap;

  /// Creates a new [GroundOverlay] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  GroundOverlay copyWith({
    bool consumeTapEventsParam,
    double anchorUParam,
    double anchorVParam,
    double bearingParam,
    LatLngBounds boundsParam,
    double heightParam,
    BitmapDescriptor imageParam,
    LatLng positionParam,
    double transparencyParam,
    bool visibleParam,
    double widthParam,
    double zIndexParam,
    VoidCallback onTapParam,
  }) {
    return GroundOverlay(
      groundOverlayId: groundOverlayId,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      anchorU: anchorUParam ?? anchorU,
      anchorV: anchorVParam ?? anchorV,
      bearing: bearingParam ?? bearing,
      bounds: boundsParam ?? bounds,
      height: heightParam ?? height,
      image: imageParam ?? image,
      position: positionParam ?? position,
      transparency: transparencyParam ?? transparency ,
      visible: visibleParam ?? visible,
      width: widthParam ?? width,
      zIndex: zIndexParam ?? zIndex,
      onTap: onTapParam ?? onTap,
    );
  }

  dynamic _toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('groundOverlayId', groundOverlayId.value);
    addIfPresent('consumeTapEvents', consumeTapEvents);
    addIfPresent('anchorU', anchorU);
    addIfPresent('anchorV', anchorV);
    addIfPresent('bearing', bearing);
    addIfPresent('bounds', bounds?._toList());
    addIfPresent('height', height);
    addIfPresent('image', image?._toJson());
    addIfPresent('position', position?._toJson());
    addIfPresent('transparency', transparency);
    addIfPresent('visible', visible);
    addIfPresent('width', width);
    addIfPresent('zIndex', zIndex);

    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final GroundOverlay typedOther = other;
    return groundOverlayId == typedOther.groundOverlayId;
  }

  @override
  int get hashCode => groundOverlayId.hashCode;
}

Map<GroundOverlayId, GroundOverlay> _keyByGroundOverlayId(Iterable<GroundOverlay> groundOverlays) {
  if (groundOverlays == null) {
    return <GroundOverlayId, GroundOverlay>{};
  }
  return Map<GroundOverlayId, GroundOverlay>.fromEntries(groundOverlays.map(
          (GroundOverlay groundOverlay) => MapEntry<GroundOverlayId, GroundOverlay>(groundOverlay.groundOverlayId, groundOverlay)));
}

List<Map<String, dynamic>> _serializeGroundOverlaySet(Set<GroundOverlay> groundOverlays) {
  if (groundOverlays == null) {
    return null;
  }
  return groundOverlays.map<Map<String, dynamic>>((GroundOverlay go) => go._toJson()).toList();
}
