import 'package:flutter_project_1/data/authorization/authorization_credential.dart';

class Session {
  String? id;
  AuthCredential cred;
  AuthState state = .guest;

  Session(this.id, this.cred, this.state);

  static final nullSession = Session(null, .nullAuthCredential, .guest);
}

enum AuthState {
  authenticated, guest
}