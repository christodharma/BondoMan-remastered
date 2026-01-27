import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/authorization_result.dart';
import 'package:flutter_project_1/data/authorization/service/i_auth.dart';
import 'package:flutter_project_1/data/authorization/session.dart' as local;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth implements IAuthorization {
  final SupabaseClient client;

  SupabaseAuth(this.client);

  @override
  Future<AuthorizationResult> signIn({
    required String username,
    required String key,
  }) async {
    var authResponse = await client.auth.signInWithPassword(
      email: username,
      password: key,
    );
    return authResponse.toAuthorizationResult();
  }

  @override
  Future<void> signOut() async {
    return await client.auth.signOut();
  }
}

extension on AuthResponse {
  AuthorizationResult toAuthorizationResult() {
    if (session != null && user != null) {
      return AuthorizationResult(
        success: true,
        reason: "success",
        session: local.Session(
          id: session!.accessToken,
          cred: AuthCredential(user!.email!, ""),
          state: .authenticated,
        ),
      );
    } else {
      return AuthorizationResult(
        success: false,
        reason: toString(),
        session: .nullSession,
      );
    }
  }
}
