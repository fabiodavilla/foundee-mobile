import 'dart:convert';

import 'package:foundee_mobile/common/enum/http_status_enum.dart';
import 'package:foundee_mobile/common/env.dart';
import 'package:foundee_mobile/common/http_status_code.dart';
import 'package:foundee_mobile/services/entities/login.dart';
import 'package:http/http.dart' as http;

Future<Login> fetchLogin(String email, String password) async {
  try {
    final response = await http.post(
        Uri.parse("${Environment.url}:${Environment.port}/auth/login"),
        body: {"email": email, "password": password});

    if (HttpStatusCode.returnStatusType(response.statusCode) ==
        HttpStatusEnum.success) {
      return Login.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to login');
  } catch (e) {
    throw Exception(e);
  }
}
