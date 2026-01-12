import 'package:flutter_project_1/data/user/user.dart';
import 'package:flutter_project_1/data/authorization/authorization_result.dart';

abstract interface class IAuthorization {
  Future<AuthorizationResult> authorize(User user);
}