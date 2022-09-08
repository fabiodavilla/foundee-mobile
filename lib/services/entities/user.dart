class User {
  final String name;
  final String lastName;
  final DateTime dateBirth;
  final String address;
  final String district;
  final String city;
  final String state;
  final String country;
  final int userType;
  final int status;
  final String imageUrl;
  final String email;
  final String password;

  const User(
      {required this.name,
      required this.lastName,
      required this.dateBirth,
      required this.address,
      required this.district,
      required this.city,
      required this.state,
      required this.country,
      required this.userType,
      required this.status,
      required this.imageUrl,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      lastName: json['lastName'],
      dateBirth: json['dateBirth'],
      address: json['address'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      userType: json['userType'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      password: json['password'],
    );
  }
}
