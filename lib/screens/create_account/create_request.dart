import 'package:foundee/services/api.dart';
import 'package:foundee/services/entities/user.dart';
import 'package:http/http.dart' as http;

Future<User> createUser(Map<String, String> user) async {
  final response = await post("user", user);

  if (response != null) {
    return User.fromJson(response);
  } else {
    throw NullThrownError();
  }
}
