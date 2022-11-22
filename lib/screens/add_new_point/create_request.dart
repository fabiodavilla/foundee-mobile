import 'dart:convert';

import 'package:foundee_mobile/services/api.dart';
import 'package:foundee_mobile/services/entities/place.dart';
import 'package:foundee_mobile/services/entities/place_image.dart';
import 'package:foundee_mobile/services/entities/point.dart';

Future<Place> createPlace(Map<String, dynamic> place) async {
  final response = await post("places", place);

  if (response != null) {
    return Place.fromJson(jsonDecode(response.body));
  } else {
    throw NullThrownError();
  }
}

Future<PlaceImage> createPlaceImage(Map<String, String> place) async {
  final response = await post("place-images", place);

  if (response != null) {
    return PlaceImage.fromJson(jsonDecode(response.body));
  } else {
    throw NullThrownError();
  }
}

Future<Point> createPoint(Map<String, String> place) async {
  final response = await post("points", place);

  if (response != null) {
    return Point.fromJson(jsonDecode(response.body));
  } else {
    throw NullThrownError();
  }
}
