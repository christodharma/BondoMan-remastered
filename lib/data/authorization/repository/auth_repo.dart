import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/i_auth_repo.dart';
import 'package:flutter_project_1/data/authorization/service/i_auth.dart';
import 'package:flutter_project_1/data/authorization/session.dart';

class AuthorizationRepository extends ChangeNotifier
    implements IAuthorizationRepository {
  final IAuthorization service;

  AuthorizationRepository(this.service);

  Session _session = .nullSession;
  final StreamController<AuthState> _streamController =
      StreamController<AuthState>.broadcast();

  @override
  Session get getSession => _session;

  @override
  Stream<AuthState> get onStateChange => _streamController.stream;

  @override
  void setState(AuthState state) {
    if (_session == .nullSession) {
      _session = Session("", .nullAuthCredential, state);
    } else {
      _session.state = state;
    }

    _streamController.add(state);
  }

  @override
  Future<bool> authorize(AuthCredential cred) async {
    var result = await service.signIn(username: cred.username, key: cred.key);
    if (result.success) {
      _setCredential(cred);
      setState(.authenticated);
      return true;
    } else {
      _setCredential(.nullAuthCredential);
      setState(.guest);
      return false;
    }
  }

  @override
  Future<void> removeSession() async {
    await service.signOut();
    _session = .nullSession;
    setState(_session.state); // state = guest
  }

  void _setCredential(AuthCredential cred) {
    if (_session == .nullSession) {
      _session = Session("", cred, .guest);
    } else {
      _session.cred = cred;
    }
  }
}
