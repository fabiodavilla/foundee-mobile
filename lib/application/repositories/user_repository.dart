import 'dart:convert';

import 'package:foundee_mobile/utils/services/api/api.dart';
import 'package:foundee_mobile/application/entities/user.dart';

class UserRepository extends Api {
  Future<User> createUser(User user) async {
    user.passwordHash();

    final response = await postAsync("user", user);

    if (response != null) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw NullThrownError();
    }
  }
}
