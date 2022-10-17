import 'package:intl/intl.dart';

extension FormatDate on String {
  DateTime convertToDateTime(String separator) {
    final splitted = split(separator);
    return DateTime.parse("${splitted[2]}-${splitted[1]}-${splitted[0]}");
  }

  String invertDate(String separator) {
    return DateFormat('yyyy-MM-dd').format(convertToDateTime(separator));
  }
}
