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
  final response = await http.post(
    Uri.parse("${Environment.url}:${Environment.port}/$route"),
    body: body,
  );

  if (HttpStatusCode.returnStatusType(response.statusCode) ==
      HttpStatusEnum.success) {
    return response;
  }

  return null;
}
