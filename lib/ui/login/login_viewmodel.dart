import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/i_auth_repo.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthorizationRepository _auth;

  LoginViewModel(this._auth);

  Future<bool> submitLogin({
    required String username,
    required String key,
  }) async {
    return await _auth.authorize(AuthCredential(username, key));
  }
}
