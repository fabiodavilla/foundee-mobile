import 'dart:convert';

import 'package:foundee_mobile/utils/services/api/api.dart';
import 'package:foundee_mobile/application/entities/new_place.dart';
import 'package:foundee_mobile/application/entities/place_image.dart';

class PlaceRepository extends Api {
  Future<NewPlace> createPlace(NewPlace place) async {
    final response = await postAsync("places", place);

    if (response != null) {
      return NewPlace.fromJson(jsonDecode(response.body));
    } else {
      throw NullThrownError();
    }
  }

  Future<PlaceImage> createPlaceImage(PlaceImage placeImage) async {
    final response = await postAsync("place-images", placeImage);

    if (response != null) {
      return PlaceImage.fromJson(jsonDecode(response.body));
    } else {
      throw NullThrownError();
    }
  }
}
