import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthorizationRepository _auth;

  LoginViewModel(this._auth);

  Future<void> submitLogin({
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) async {
    var authResult = await _auth.login(
      username: usernameController.text,
      key: passwordController.text,
    );
    if (authResult.success){
      // login success
      // TODO redirect
      print(authResult.reason);
    } else {
      print(authResult.reason);
    }
  }
}
