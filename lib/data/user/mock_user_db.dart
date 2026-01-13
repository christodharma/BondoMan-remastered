import 'package:flutter/foundation.dart';
import 'package:flutter_project_1/data/user/user.dart';

class TestUserList {
  static List<User> get users {
    if (!kDebugMode) {
      throw Exception("App called debug mode features in release mode");
    }
    return <User>[User("Christo", "Test!123")];
  }
}
