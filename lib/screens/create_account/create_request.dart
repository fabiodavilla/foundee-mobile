import 'dart:convert';

import 'package:foundee_mobile/services/api.dart';
import 'package:foundee_mobile/services/entities/user.dart';

Future<User> createUser(Map<String, String> user) async {
  final response = await post("user", user);

  if (response != null) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw NullThrownError();
  }
}
