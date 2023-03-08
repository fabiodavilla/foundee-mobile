import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';

class NewPlace implements IJsonConvertible {
  final String name;
  final String description;
  final int placeType;
  final double latitude;
  final double longitude;
  final List<String> imagesStringList;
  final String? commercialInfoId;

  const NewPlace(
      {required this.name,
      required this.description,
      required this.placeType,
      required this.latitude,
      required this.longitude,
      required this.imagesStringList,
      this.commercialInfoId});

  factory NewPlace.fromJson(Map<String, dynamic> json) => NewPlace(
      name: json['name'],
      description: json['description'],
      placeType: json['placeType'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      imagesStringList: json['imagesStringList'] ?? [],
      commercialInfoId: json['commercialInfoId']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'placeType': placeType,
        'commercialInfoId': commercialInfoId,
        'latitude': latitude,
        'longitude': longitude,
        'imagesStringList': imagesStringList
      };
}
