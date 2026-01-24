import 'package:flutter/material.dart';
import 'package:flutter_project_1/ui/history/history.dart';
import 'package:flutter_project_1/ui/login/login.dart';
import 'package:flutter_project_1/ui/transaction_input/transaction_input.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case History.routeName:
        return MaterialPageRoute(builder: (_) => History());
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login());
      case TransactionInput.routeName:
        return MaterialPageRoute(builder: (_) => TransactionInput());
      default:
        return MaterialPageRoute(builder: (_) => CircularProgressIndicator());
    }
  }
}
