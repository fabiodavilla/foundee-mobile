import 'dart:convert';

import 'package:foundee_mobile/application/entities/point.dart';
import 'package:foundee_mobile/utils/services/api/api.dart';

class PointRepository extends Api {
  Future<Point> createPoint(Point point) async {
    final response = await postAsync("points", point);

    if (response != null) {
      return Point.fromJson(jsonDecode(response.body));
    } else {
      throw NullThrownError();
    }
  }
}
