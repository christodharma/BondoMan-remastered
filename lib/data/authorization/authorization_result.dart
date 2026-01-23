import 'package:flutter_project_1/data/authorization/authorization_credential.dart';

class AuthorizationResult {
  final bool success;
  final String? reason;
  final AuthCredential? user;

  const AuthorizationResult({required this.success, required this.reason, required this.user});

  static const noDebugResult = AuthorizationResult(
    success: false,
    reason: "App is calling debug mode features in release mode",
    user: null,
  );
}
