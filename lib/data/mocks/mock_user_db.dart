import 'package:flutter/foundation.dart';
import 'package:flutter_project_1/data/authorization/authorization_credential.dart';

// a mock external_service system for user authentication db
class TestUserList {
  static final List<AuthCredential> _users = [
    AuthCredential("Christo@dev.yup", "Test!123")
  ];

  static List<AuthCredential> get users {
    if (!kDebugMode) {
      throw Exception("App called debug mode features in release mode");
    }
    return _users;
  }

  static void signUp(AuthCredential newCred) => _users.add(newCred);
}
