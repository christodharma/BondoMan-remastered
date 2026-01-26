import 'package:flutter_project_1/data/authorization/session.dart';

class AuthorizationResult {
  final bool success;
  final String? reason;
  final Session? session;

  const AuthorizationResult({required this.success, required this.reason, required this.session});

  static const noDebugResult = AuthorizationResult(
    success: false,
    reason: "App is calling debug mode features in release mode",
    session: null,
  );
}
