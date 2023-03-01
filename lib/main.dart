import 'package:flutter/material.dart';
import 'package:foundee_mobile/config/themes/routes.dart';

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
      initialRoute: Routes.defaultRoute,
      routes: Routes.configureRoutes(),
    );
  }
}
