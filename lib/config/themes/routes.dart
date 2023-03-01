import 'package:flutter/cupertino.dart';
import 'package:foundee_mobile/application/screens/map/add_new_point_screen.dart';
import 'package:foundee_mobile/application/screens/login/create_account_screen.dart';
import 'package:foundee_mobile/application/screens/login/login_screen.dart';
import 'package:foundee_mobile/application/screens/main/main_screen.dart';

class Routes {
  static const String defaultRoute = '/';

  static Map<String, WidgetBuilder> configureRoutes() {
    return {
      '/': (context) => const MainScreen(),
      '/login': (context) => LoginScreen(),
      '/createaccount': (context) => CreateAccountScreen(),
      '/addnewpoint': (context) => const AddNewPointScreen(),
    };
  }
}
