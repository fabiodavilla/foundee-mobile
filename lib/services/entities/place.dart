class Place {
  final String name;
  final String description;
  final int status;
  final int placeType;
  final String? commercialInfoId;

  const Place(
      {required this.name,
      required this.description,
      required this.status,
      required this.placeType,
      this.commercialInfoId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        name: json['name'],
        description: json['description'],
        status: json['status'],
        placeType: json['placeType'],
        commercialInfoId: json['commercialInfoId']);
  }
}
