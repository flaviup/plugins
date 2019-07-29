package io.flutter.plugins.googlemaps;

import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.GroundOverlay;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.LatLngBounds;

/** Controller of a single GroundOverlay on the map. */
class GroundOverlayController implements GroundOverlayOptionsSink {
    private final GroundOverlay groundOverlay;
    private final String googleMapsGroundOverlayId;
    private boolean consumeTapEvents;

    GroundOverlayController(GroundOverlay groundOverlay, boolean consumeTapEvents) {
        this.groundOverlay = groundOverlay;
        this.consumeTapEvents = consumeTapEvents;
        this.googleMapsGroundOverlayId = groundOverlay.getId();
    }

    void remove() {
        groundOverlay.remove();
    }

    @Override
    public void setAnchorU(float anchorU) {
        //groundOverlay.setAnchor(anchorU, groundOverlay.getAnchorV());
    }

    @Override
    public void setAnchorV(float anchorV) {
        //groundOverlay.setAnchor(groundOverlay.getAnchorU(), anchorV);
    }

    @Override
    public void setAnchor(float anchorU, float anchorV) {
        //groundOverlay.setAnchor(anchorU, anchorV);
    }

    @Override
    public void setBearing(float bearing) {
        groundOverlay.setBearing(bearing);
    }

    @Override
    public void setBounds(LatLngBounds bounds) {
        groundOverlay.setPositionFromBounds(bounds);
    }

    @Override
    public void setConsumeTapEvents(boolean consumeTapEvents) {
        this.consumeTapEvents = consumeTapEvents;
        groundOverlay.setClickable(consumeTapEvents);
    }

    @Override
    public void setHeight(float height) {
        groundOverlay.setDimensions(groundOverlay.getWidth(), height);
    }

    @Override
    public void setImage(BitmapDescriptor imageDescriptor) {
        groundOverlay.setImage(imageDescriptor);
    }

    @Override
    public void setPosition(LatLng location) {
        groundOverlay.setPosition(location);
    }

    @Override
    public void setPosition(LatLng location, float width) {
        groundOverlay.setPosition(location);
        groundOverlay.setDimensions(width);
    }

    @Override
    public void setPosition(LatLng location, float width, float height) {
        groundOverlay.setPosition(location);
        groundOverlay.setDimensions(width, height);
    }

    @Override
    public void setTransparency(float transparency) {
        groundOverlay.setTransparency(transparency);
    }

    @Override
    public void setVisible(boolean visible) {
        groundOverlay.setVisible(visible);
    }

    @Override
    public void setWidth(float width) {
        groundOverlay.setDimensions(width, groundOverlay.getHeight());
    }

    @Override
    public void setZIndex(float zIndex) {
        groundOverlay.setZIndex(zIndex);
    }

    String getGoogleMapsGroundOverlayId() {
        return googleMapsGroundOverlayId;
    }

    boolean consumeTapEvents() {
        return consumeTapEvents;
    }
}
