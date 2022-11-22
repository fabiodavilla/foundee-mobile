import 'dart:io';

class PlaceImage {
  final int idPlace;
  final File image;

  const PlaceImage({required this.idPlace, required this.image});

  factory PlaceImage.fromJson(Map<String, dynamic> json) {
    return PlaceImage(idPlace: json['name'], image: json['image']);
  }
}
