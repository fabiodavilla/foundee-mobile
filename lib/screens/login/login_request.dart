import 'dart:convert';

import 'package:foundee/common/enum/http_status_enum.dart';
import 'package:foundee/common/env.dart';
import 'package:foundee/common/http_status_code.dart';
import 'package:foundee/services/entities/login.dart';
import 'package:http/http.dart' as http;

Future<Login> fetchLogin(String email, String password) async {
  final response = await http.post(
    Uri.parse("${Environment.url}:${Environment.port}/login"),
    body: {"email": email, "password": password},
  );

  if (HttpStatusCode.returnStatusType(response.statusCode) ==
      HttpStatusEnum.success) {
    return Login.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to login');
  }
}
