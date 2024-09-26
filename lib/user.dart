class User {
  String _username;
  String _password;

  User({
    required String username,
    required String password,
  })  : _username = username,
        _password = password;

  // Getter para username
  String get username => _username;

  // Setter para username
  set username(String username) {
    _username = username;
  }

  // Getter para password
  String get password => _password;

  // Setter para password
  set password(String password) {
    _password = password;
  }
}