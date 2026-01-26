import 'package:flutter/material.dart';
import 'package:flutter_project_1/ui/home.dart';
import 'package:flutter_project_1/ui/login/login.dart';
import 'package:flutter_project_1/ui/transaction_input/transaction_input.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login());
      case TransactionInput.routeName:
        return MaterialPageRoute(builder: (_) => TransactionInput());
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
    }
  }

  static const routeMap = <RouteNames, String>{
    .home: HomePage.routeName,
    .login: Login.routeName,
    .transactionInput: TransactionInput.routeName,
  };
}

enum RouteNames {
  login,
  home,
  transactionInput, // 3 other page is in one navigation bar page
  // history, graphs, settings,
}
