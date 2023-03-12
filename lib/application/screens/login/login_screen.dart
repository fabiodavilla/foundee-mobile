import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foundee_mobile/application/entities/login.dart';
import 'package:foundee_mobile/config/constants/assets_path.dart';
import 'package:foundee_mobile/application/repositories/auth_repository.dart';
import 'package:foundee_mobile/application/entities/auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: const [
                    ColoredBox(
                      color: Colors.green,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(36),
                        child: Image(
                          image: AssetImage(AssetsPath.LogoNoText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(),
                          helperText: 'Type your email',
                        ),
                        obscureText: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a valid password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(),
                          helperText: 'Type your password',
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = emailController.text;
                            String password = passwordController.text;

                            Auth login = await _authRepository
                                .fetchLogin(Login(email, password));

                            if (login.accessToken.isNotEmpty) {
                              storage.write(
                                  key: 'access_token',
                                  value: login.accessToken);
                              Navigator.popAndPushNamed(context, '/');
                            }
                          }
                        },
                        child: const Text("LOGIN"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 13,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/createaccount');
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: const Center(
                              child: Text(
                                "Criar conta",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
