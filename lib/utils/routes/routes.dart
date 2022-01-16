import 'package:app/ui/home/home_page.dart';
import 'package:app/ui/login/login_page.dart';
import 'package:app/ui/pages/route_selector/route_selector_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String home = '/home_page';
  static const String routeSelectorPage = '/route_selector_page';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => const LoginPage(),
    home: (BuildContext context) => const HomePage(),
    routeSelectorPage: (BuildContext context) =>   const RouteSelectorPage(),
  };
}
