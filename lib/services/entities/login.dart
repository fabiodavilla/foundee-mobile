class Login {
  final String accessToken;

  const Login({
    required this.accessToken,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      accessToken: json['access_token'],
    );
  }
}
