import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/session.dart';

abstract interface class IAuthorizationRepository {
  Session get getSession;

  Stream<AuthState> get onStateChange;

  void setState(AuthState state);

  Future<bool> authorize(AuthCredential cred);

  Future<void> removeSession();
}