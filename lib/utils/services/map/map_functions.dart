import 'package:flutter_map/plugin_api.dart';

class MapFunctions {
  void loadPoints(LatLngBounds bounds) {}

  // void _onMapChanged(MapPosition position) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 500), () {
  //     _center = position.center;
  //     _mapFunctions.loadPoints(position.bounds!);
  //   });
  // }
}
