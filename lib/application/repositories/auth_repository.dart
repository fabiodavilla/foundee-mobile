import 'package:foundee_mobile/application/entities/login.dart';
import 'package:foundee_mobile/utils/services/api/api.dart';
import 'package:foundee_mobile/application/entities/auth.dart';

class AuthRepository extends Api {
  Future<Auth> fetchLogin(Login login) async {
    try {
      final response = await simplePostAsync("auth/login", login);

      if (response != null) {
        return Auth.fromJson(response.data);
      }

      throw Exception('Failed to login');
    } catch (e) {
      throw Exception(e);
    }
  }
}
