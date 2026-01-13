import 'package:flutter/foundation.dart';
import 'package:flutter_project_1/data/authorization/authorization_result.dart';
import 'package:flutter_project_1/data/authorization/i_authorization.dart';
import 'package:flutter_project_1/data/user/user.dart';

import 'package:flutter_project_1/data/user/mock_user_db.dart';

class MockAuthorization implements IAuthorization {
  @override
  Future<AuthorizationResult> authorize(User user) async {
    if (!kDebugMode) return .noDebugResult; // reject release mode calls

    var isFound = TestUserList.users.any((user_) => user_ == user);

    await Future.delayed(Duration()); // mock login duration

    return AuthorizationResult(
      success: isFound,
      reason: "${isFound ? "" : "no "}${user.username}",
    );
  }
}
