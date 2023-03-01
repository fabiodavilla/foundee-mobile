import 'dart:io';

import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';

class PlaceImage implements IJsonConvertible {
  final int idPlace;
  final File image;

  const PlaceImage({required this.idPlace, required this.image});

  factory PlaceImage.fromJson(Map<String, dynamic> json) =>
      PlaceImage(idPlace: json['name'], image: json['image']);

  @override
  Map<String, dynamic> toJson() => {'idPlace': idPlace, 'image': image};
}
