import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/data/authorization/session.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthorizationRepository _auth;

  LoginViewModel(this._auth) {
    _auth.onStateChange.listen((newState) {
      switch (newState) {
        case AuthState.authenticated:
          // TODO: Handle this case.
          throw UnimplementedError();
        case AuthState.guest:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }

  Future<bool> submitLogin({
    required String username,
    required String key,
  }) async {
    return await _auth.authorize(AuthCredential(username, key));
  }
}
