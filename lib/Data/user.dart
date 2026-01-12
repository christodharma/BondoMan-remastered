import 'dart:convert';

class User {
  final String username;
  final String key;

  const User._(this.username, this.key);

  factory User(String user, String password) {
    return User(user, _hashPassword(password));
  }

  Map<String, dynamic> toJson() => {'username': username, 'key': key};

  static String _hashPassword(String password) {
    // TODO implement password hashing
    utf8.encode(password);

    return password;
  }

  //TODO consider object equality comparison for login verification
  @override
  bool operator ==(Object other) => other is User && username == other.username;

  @override
  // TODO: implement hashCode
  int get hashCode => username.hashCode;
}
