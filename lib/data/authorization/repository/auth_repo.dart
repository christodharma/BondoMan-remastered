import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/authorization_result.dart';
import 'package:flutter_project_1/data/authorization/service/i_auth.dart';
import 'package:flutter_project_1/data/user.dart';

abstract interface class IAuthorizationRepository {
  Future<AuthorizationResult> login({
    required String username,
    required String key,
  });

  // Future<bool> logout(User user);
}

class AuthorizationRepository extends ChangeNotifier
    implements IAuthorizationRepository {
  final IAuthorization service;

  AuthorizationRepository(this.service);

  User? _currentUser;

  @override
  Future<AuthorizationResult> login({
    required String username,
    required String key,
  }) async {
    if (_currentUser != null) {
      return AuthorizationResult(
        success: true,
        reason: "login with active session",
        user: _currentUser,
      );
    }

    var result = await service.authorize(username: username, key: key);
    _currentUser = result.user;
    return result;
  }
}
