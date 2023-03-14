import 'package:foundee_mobile/application/entities/point.dart';
import 'package:foundee_mobile/utils/services/api/api.dart';

class PointRepository extends Api {
  Future<Point> findAllByLocation(
      double north, double south, double east, double west) async {
    final x =
        "bounds={ 'north': $north, 'south': $south, 'east': $east, 'west': $west}";
    final response = await getAsync("points/location", x);

    if (response != null) {
      return Point.fromJson(response.data);
    } else {
      throw NullThrownError();
    }
  }
}
