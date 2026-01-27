import 'package:flutter_project_1/data/authorization/authorization_credential.dart';

class Session {
  final String? id;
  final AuthCredential cred;
  final AuthState state;

  const Session({required this.id, required this.cred, required this.state});

  factory Session.changeState(Session old, AuthState state) {
    return Session(id: old.id, cred: old.cred, state: state);
  }

  factory Session.changeCredential(Session old, AuthCredential cred) {
    return Session(id: old.id, cred: cred, state: old.state);
  }

  static const Session nullSession = Session(
    id: null,
    cred: .nullAuthCredential,
    state: .guest,
  );
}

enum AuthState { authenticated, guest }
