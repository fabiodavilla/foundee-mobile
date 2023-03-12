class ResponseType<T> {
  final bool success;
  final int statusCode;
  final String message;
  final T data;

  const ResponseType({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
