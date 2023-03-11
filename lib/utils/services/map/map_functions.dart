import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapFunctions {
  List<Marker> loadPoints(LatLngBounds bounds) {
    return [
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(bounds.center.latitude, bounds.center.longitude),
        builder: (ctx) => const FlutterLogo(),
      )
    ];
  }

  MapPosition positionToMapPosition(Position position) {
    final center = LatLng(position.latitude, position.longitude);
    const zoom = 16.0;
    final bounds = LatLngBounds(
      LatLng(center.latitude - 0.01, center.longitude - 0.01),
      LatLng(center.latitude + 0.01, center.longitude + 0.01),
    );
    return MapPosition(
      center: center,
      zoom: zoom,
      bounds: bounds,
    );
  }

  // void _onMapChanged(MapPosition position) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     _center = position.center;
  //     _mapFunctions.loadPoints(position.bounds!);
  //   });
  // }
}
