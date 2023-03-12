import 'package:foundee_mobile/utils/helpers/crypt/hash_password.dart';
import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';

class Login implements IJsonConvertible {
  final String email;
  late String password;

  Login(this.email, String password) {
    this.password = hashPassword(password);
  }

  @override
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
