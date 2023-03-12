import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foundee_mobile/application/entities/auth.dart';
import 'package:foundee_mobile/common/types/response_type.dart';
import 'package:foundee_mobile/utils/enum/http_status_enum.dart';
import 'package:foundee_mobile/config/constants/api_path.dart';
import 'package:foundee_mobile/utils/interfaces/i_json_convertible.dart';
import 'package:foundee_mobile/utils/services/api/http_status_code.dart';
import 'package:foundee_mobile/utils/services/api/response_handler.dart';
import 'package:http/http.dart';

abstract class Api {
  Future<dynamic> getAsync(String route, String params) async {
    final response = convertResponse<dynamic>(await get(
      Uri.http("${ApiPath.url}:${ApiPath.port}/$route", params),
    ));

    if (HttpStatusCode.returnStatusType(response.statusCode) ==
        HttpStatusEnum.success) {
      return response;
    }
  }

  Future<Response?> postAsync(String route, IJsonConvertible body) async {
    const storage = FlutterSecureStorage();

    final accessToken = await storage.read(key: 'access_token');

    final response = await post(
        Uri.parse("${ApiPath.url}:${ApiPath.port}/$route"),
        body: jsonEncode(body.toJson()),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-type": "application/json"
        });

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

  Future<ResponseType<T>> simplePostAsync<T>(
      String route, IJsonConvertible data) async {
    final response = convertResponse<T>(await post(
      Uri.parse("${ApiPath.url}:${ApiPath.port}/$route"),
      body: data.toJson(),
    ));

    if (HttpStatusCode.returnStatusType(response.statusCode) ==
        HttpStatusEnum.success) {
      return response;
    }

    if (HttpStatusCode.returnStatusType(response.statusCode) ==
        HttpStatusEnum.clientError) {
      if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: jsonDecode(response.message),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    throw Exception;
  }
}
