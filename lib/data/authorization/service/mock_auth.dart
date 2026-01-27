import 'package:flutter/foundation.dart';
import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/authorization_result.dart';
import 'package:flutter_project_1/data/authorization/service/i_auth.dart';
import 'package:flutter_project_1/data/authorization/session.dart';
import 'package:flutter_project_1/data/mocks/mock_user_db.dart';

class MockAuthorization implements IAuthorization {
  @override
  Future<AuthorizationResult> signIn({
    required String username,
    required String key,
  }) async {
    if (!kDebugMode) return .noDebugResult; // reject release mode calls
    {
      var user = AuthCredential(username, key);
      AuthCredential? foundUser;
      try {
        foundUser = TestUserList.users.firstWhere((u) => u == user);
      } on StateError {
        foundUser = null;
      }

      await Future.delayed(Duration()); // mock login duration

      return AuthorizationResult(
        success: foundUser != null,
        reason: foundUser?.username ?? "invalid credentials",
        session: foundUser?.toSession(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    if (!kDebugMode) return;

    // TODO notify repo
  }
}

extension on AuthCredential {
  Session toSession() {
    return Session(id: "", cred: this, state: .authenticated);
  }
}
