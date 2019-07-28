package io.flutter.plugins.googlemaps;

import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

/** Receiver of GroundOverlay configuration options. */
interface GroundOverlayOptionsSink {

    void setAnchorU(float anchorU);

    void setAnchorV(float anchorV);

    void setAnchor(float anchorU, float anchorV);

    void setBearing(float bearing);

    void setBounds(LatLngBounds bounds);

    void setConsumeTapEvents(boolean consumetapEvents);

    void setHeight(float height);

    void setImage(BitmapDescriptor imageDescriptor);

    void setPosition(LatLng location);

    void setPosition(LatLng location, float width);

    void setPosition(LatLng location, float width, float height);

    void setTransparency(float transparency);

    void setVisible(boolean visible);

    void setWidth(float width);

    void setZIndex(float zIndex);
}
