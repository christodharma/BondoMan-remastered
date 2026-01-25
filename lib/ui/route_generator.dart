import 'package:flutter/material.dart';
import 'package:flutter_project_1/ui/home.dart';
import 'package:flutter_project_1/ui/login/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login());
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
    }
  }

  static const routeMap = <RouteNames, String>{
    .home: HomePage.routeName,
    .login: Login.routeName,
  };
}

enum RouteNames {
  login,
  home, // 4 other page is in one navigation bar page
  // history, transactionInput, graphs, settings,
}
