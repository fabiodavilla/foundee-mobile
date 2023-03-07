import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';

class NewPlace implements IJsonConvertible {
  final String name;
  final String description;
  final int placeType;
  final double latitude;
  final double longitude;
  final String idUser;
  final List<String> imagesStringList;
  final String? commercialInfoId;

  const NewPlace(
      {required this.name,
      required this.description,
      required this.placeType,
      required this.latitude,
      required this.longitude,
      required this.idUser,
      required this.imagesStringList,
      this.commercialInfoId});

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'placeType': placeType,
        'commercialInfoId': commercialInfoId,
        'latitude': latitude,
        'longitude': longitude,
        'idUser': idUser,
        'imagesStringList': imagesStringList
      };
}
