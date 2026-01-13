class AuthorizationResult {
  final bool success;
  final String? reason;

  const AuthorizationResult({required this.success, required this.reason});

  static const noDebugResult = AuthorizationResult(
    success: false,
    reason: "App is calling debug mode features in release mode",
  );
}
