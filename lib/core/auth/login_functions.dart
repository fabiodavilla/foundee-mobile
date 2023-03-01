import 'dart:convert';

import 'package:foundee_mobile/utils/enum/http_status_enum.dart';
import 'package:foundee_mobile/config/constants/api_path.dart';
import 'package:foundee_mobile/utils/helpers/crypt/hash_password.dart';
import 'package:foundee_mobile/utils/services/api/http_status_code.dart';
import 'package:foundee_mobile/application/entities/login.dart';
import 'package:http/http.dart' as http;

Future<Login> fetchLogin(String email, String password) async {
  try {
    final response = await http.post(
        Uri.parse("${ApiPath.url}:${ApiPath.port}/auth/login"),
        body: {"email": email, "password": hashPassword(password)});

    if (HttpStatusCode.returnStatusType(response.statusCode) ==
        HttpStatusEnum.success) {
      return Login.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to login');
  } catch (e) {
    throw Exception(e);
  }
}
