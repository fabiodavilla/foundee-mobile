class Point {
  final double latitude;
  final double longitude;
  final String idUser;
  final String idPlace;
  final int placeType;

  const Point(
      {required this.latitude,
      required this.longitude,
      required this.idUser,
      required this.idPlace,
      required this.placeType});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      latitude: json['latitude'],
      longitude: json['longitude'],
      idUser: json['idUser'],
      idPlace: json['idPlace'],
      placeType: json['placeType'],
    );
  }
}
