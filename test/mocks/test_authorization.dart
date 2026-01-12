import 'package:flutter_project_1/Data/Authorization/authorization_result.dart';
import 'package:flutter_project_1/Data/Authorization/i_authorization.dart';
import 'package:flutter_project_1/Data/user.dart';

import 'UserDB.dart';

class TestAuthorization implements IAuthorization {
  @override
  Future<AuthorizationResult> authorize(User user) async {
    var isFound = TestUserList.users.any((user_) => user_ == user);

    await Future.delayed(Duration()); // mock login duration

    return AuthorizationResult(
      success: isFound,
      reason: "${isFound ? "" : "no "}${user.username}",
    );
  }
}
