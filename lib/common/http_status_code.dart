import 'package:foundee_mobile/common/enum/http_status_enum.dart';

class HttpStatusCode {
  static HttpStatusEnum returnStatusType(int code) {
    if (code >= 100 && code <= 199) {
      return HttpStatusEnum.informal;
    } else if (code >= 200 && code <= 299) {
      return HttpStatusEnum.success;
    } else if (code >= 300 && code <= 399) {
      return HttpStatusEnum.redirection;
    } else if (code >= 400 && code <= 499) {
      return HttpStatusEnum.clientError;
    } else {
      return HttpStatusEnum.serverError;
    }
  }
}
