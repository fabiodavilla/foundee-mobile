import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foundee_mobile/common/enum/http_status_enum.dart';
import 'package:foundee_mobile/common/env.dart';
import 'package:foundee_mobile/common/http_status_code.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<dynamic> get(String route, String params) async {
  final response = await http.get(
    Uri.http("${Environment.url}:${Environment.port}/$route", params),
  );

  if (HttpStatusCode.returnStatusType(response.statusCode) ==
      HttpStatusEnum.success) {
    return response;
  }
}

Future<Response?> post(String route, Object body) async {
  const storage = FlutterSecureStorage();

  final access_token = await storage.read(key: 'access_token');

  final response = await http.post(
      Uri.parse("${Environment.url}:${Environment.port}/$route"),
      body: body,
      headers: {"Authorization": "Bearer $access_token"});

  if (HttpStatusCode.returnStatusType(response.statusCode) ==
      HttpStatusEnum.success) {
    return response;
  }

  if (HttpStatusCode.returnStatusType(response.statusCode) ==
      HttpStatusEnum.clientError) {
    if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: jsonDecode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  return null;
}
