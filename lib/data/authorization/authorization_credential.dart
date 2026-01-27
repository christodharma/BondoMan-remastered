class AuthCredential {
  final String username;
  final String key;

  const AuthCredential._(this.username, this.key);

  factory AuthCredential(String user, String password) {
    return AuthCredential._(user, _hashPassword(password));
  }

  Map<String, dynamic> toJson() => {'username': username, 'key': key};

  static const nullAuthCredential = AuthCredential._("noLogin", "");

  static String _hashPassword(String password) {
    // TODO implement password hashing

    return password;
  }

  //TODO consider object equality comparison for login verification
  @override
  bool operator ==(Object other) =>
      other is AuthCredential && username == other.username && key == other.key;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(username, key);
}
