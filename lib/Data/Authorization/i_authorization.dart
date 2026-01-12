import '../user.dart';
import 'authorization_result.dart';

abstract interface class IAuthorization {
  Future<AuthorizationResult> authorize(User user);
}