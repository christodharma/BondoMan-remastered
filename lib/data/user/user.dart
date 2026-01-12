class User {
  final String username;
  final String key;

  const User._(this.username, this.key);

  factory User(String user, String password) {
    return User._(user, _hashPassword(password));
  }

  Map<String, dynamic> toJson() => {'username': username, 'key': key};

  static String _hashPassword(String password) {
    // TODO implement password hashing

    return password;
  }

  //TODO consider object equality comparison for login verification
  @override
  bool operator ==(Object other) => other is User && username == other.username;

  @override
  // TODO: implement hashCode
  int get hashCode => username.hashCode;
}
