package io.flutter.plugins.googlemaps;

import com.google.android.gms.maps.model.GroundOverlayOptions;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

class GroundOverlayBuilder implements GroundOverlayOptionsSink {
    private final GroundOverlayOptions groundOverlayOptions;
    private boolean consumeTapEvents;

    GroundOverlayBuilder() {
        this.groundOverlayOptions = new GroundOverlayOptions();
    }

    GroundOverlayOptions build() {
        return groundOverlayOptions;
    }

    boolean consumeTapEvents() {
        return consumeTapEvents;
    }

    @Override
    void setAnchorU(float anchorU) {
        groundOverlayOptions.anchor(anchorU, groundOverlayOptions.getAnchorV());
    }

    @Override
    void setAnchorV(float anchorV) {
        groundOverlayOptions.anchor(groundOverlayOptions.getAnchorU(), anchorV);
    }

    @Override
    void setAnchor(float anchorU, float anchorV) {
        groundOverlayOptions.anchor(anchorU, anchorV);
    }

    @Override
    void setBearing(float bearing) {
        groundOverlayOptions.bearing(bearing);
    }

    @Override
    void setBounds(LatLngBounds bounds) {
        groundOverlayOptions.positionFromBounds(bounds);
    }

    @Override
    public void setConsumeTapEvents(boolean consumeTapEvents) {
        this.consumeTapEvents = consumeTapEvents;
        groundOverlayOptions.clickable(consumeTapEvents);
    }

    @Override
    public void setHeight(float height) {
        groundOverlayOptions.position(groundOverlayOptions.getLocation(), groundOverlayOptions.getWidth(), height);
    }

    @Override
    void setImage(BitmapDescriptor imageDescriptor) {
        groundOverlayOptions.image(imageDescriptor);
    }

    @Override
    void setPosition(LatLng location) {
        groundOverlayOptions.position(location, groundOverlayOptions.getWidth(), groundOverlayOptions.getHeight());
    }

    @Override
    void setPosition(LatLng location, float width) {
        groundOverlayOptions.position(location, width);
    }

    @Override
    void setPosition(LatLng location, float width, float height) {
        groundOverlayOptions.position(location, width, height);
    }

    @Override
    void setTransparency(float transparency) {
        groundOverlayOptions.transparency(transparency);
    }

    @Override
    public void setVisible(boolean visible) {
        groundOverlayOptions.visible(visible);
    }

    @Override
    public void setWidth(float width) {
        groundOverlayOptions.position(groundOverlayOptions.getLocation(), width);
    }

    @Override
    public void setZIndex(float zIndex) {
        groundOverlayOptions.zIndex(zIndex);
    }
}
