class Login {
  final bool valid;
  final bool userFound;
  final String message;

  const Login({
    required this.valid,
    required this.userFound,
    required this.message,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      valid: json['valid'],
      userFound: json['userFound'],
      message: json['message'],
    );
  }
}
