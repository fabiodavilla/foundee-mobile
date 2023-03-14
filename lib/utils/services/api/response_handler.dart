import 'dart:convert';

import 'package:foundee_mobile/common/types/response_type.dart';
import 'package:http/http.dart';

ResponseType convertResponse(Response response) {
  final Map<String, dynamic> body = json.decode(response.body);

  return ResponseType(
      success: body["success"],
      statusCode: body["statusCode"],
      message: body["message"],
      data: body["data"]);
}
