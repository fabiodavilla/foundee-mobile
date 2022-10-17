import 'package:flutter/material.dart';
import 'package:foundee_mobile/screens/add_new_point/add_new_point_screen.dart';
import 'package:foundee_mobile/screens/create_account/create_account_screen.dart';
import 'package:foundee_mobile/screens/login/login_screen.dart';
import 'package:foundee_mobile/screens/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foundee',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => LoginScreen(),
        '/createaccount': (context) => CreateAccountScreen(),
        '/addnewpoint': (context) => const AddNewPointScreen(),
      },
    );
  }
}
