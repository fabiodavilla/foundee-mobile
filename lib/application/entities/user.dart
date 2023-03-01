import 'package:foundee_mobile/utils/helpers/crypt/hash_password.dart';
import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';

class User implements IJsonConvertible {
  final String name;
  final String lastName;
  final DateTime date;
  final String address;
  final String district;
  final String city;
  final String state;
  final String country;
  final int userType;
  final int status;
  final String email;
  String password;

  User(
      {required this.name,
      required this.lastName,
      required this.date,
      required this.address,
      required this.district,
      required this.city,
      required this.state,
      required this.country,
      required this.userType,
      required this.status,
      required this.email,
      required this.password});

  void passwordHash() {
    password = hashPassword(password);
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        lastName: json['lastName'],
        date: DateTime.parse(json['dateBirthday']),
        address: json['address'],
        district: json['district'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        userType: json['userType'],
        status: json['status'],
        email: json['email'],
        password: json['password'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'date': date.toString(),
        'address': address,
        'district': district,
        'city': city,
        'state': state,
        'country': country,
        'userType': userType,
        'status': status,
        'email': email,
        'password': password,
      };
}
