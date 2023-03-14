class ResponseType {
  final bool success;
  final int statusCode;
  final String message;
  final dynamic data;

  const ResponseType({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
