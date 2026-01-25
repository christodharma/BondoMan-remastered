import 'dart:async';

import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/i_auth_repo.dart';
import 'package:flutter_project_1/data/authorization/session.dart' as local;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthorizationRepository implements IAuthorizationRepository {
  final GoTrueClient _auth;

  SupabaseAuthorizationRepository(this._auth);

  @override
  Future<bool> authorize(AuthCredential cred) async {
    var res = await _auth.signInWithPassword(
      password: cred.key,
      email: cred.username,
    );
    if (res.session == null || res.user == null) {
      return false;
    }
    return true;
  }

  @override
  local.Session get getSession =>
      _auth.currentSession?.toLocalSession() ?? local.Session.nullSession;

  @override
  Stream<local.AuthState> get onStateChange {
    return _auth.onAuthStateChange
        .map(
          (event) => switch (event.event) {
            AuthChangeEvent.initialSession => local.AuthState.guest,
            AuthChangeEvent.passwordRecovery => local.AuthState.guest,
            AuthChangeEvent.signedOut => local.AuthState.guest,
            AuthChangeEvent.userUpdated => local.AuthState.guest,
            AuthChangeEvent.userDeleted => local.AuthState.guest,
            AuthChangeEvent.signedIn => local.AuthState.authenticated,
            AuthChangeEvent.tokenRefreshed => local.AuthState.authenticated,
            AuthChangeEvent.mfaChallengeVerified =>
              local.AuthState.authenticated,
          },
        )
        .asBroadcastStream();
  }

  @override
  Future<void> removeSession() async {
    return await _auth.signOut();
  }

  @override
  @Deprecated(
    "Don't use this method because its already provided by GoTrueClient",
  )
  void setState(local.AuthState state) {
    return;
  }
}

extension on Session {
  local.Session toLocalSession() {
    return local.Session(
      accessToken,
      AuthCredential(user.id, ""),
      isExpired ? .authenticated : .guest,
    );
  }
}
