import 'package:foundee_mobile/application/entities/login.dart';
import 'package:foundee_mobile/utils/enum/http_status_enum.dart';
import 'package:foundee_mobile/utils/services/api/api.dart';
import 'package:foundee_mobile/utils/services/api/http_status_code.dart';
import 'package:foundee_mobile/application/entities/auth.dart';

class AuthRepository extends Api {
  Future<Auth> fetchLogin(Login login) async {
    try {
      final response = await simplePostAsync<Auth>("auth/login", login);

      if (HttpStatusCode.returnStatusType(response.statusCode) ==
          HttpStatusEnum.success) {
        return response.data;
      }

      throw Exception('Failed to login');
    } catch (e) {
      throw Exception(e);
    }
  }
}
