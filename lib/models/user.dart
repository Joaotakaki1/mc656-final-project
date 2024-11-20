import 'preferences.dart';

/// Classe que representa um usuário no aplicativo.
class User {
  /// Email do usuário (identificador único).
  String _email;

  /// Nome de usuário (username).
  String _username;

  /// Senha do usuário.
  String _password;

  /// Sequência atual de atividades do usuário (dias consecutivos).
  int _currentStreak;

  /// Maior sequência alcançada pelo usuário.
  int _maxStreak;

  /// Preferências do usuário.
  Preferences _preferences;

  /// Construtor padrão.
  User({
    required String email,
    required String username,
    required String password,
    int currentStreak = 0,
    int maxStreak = 0,
    Preferences? preferences,
  })  : _email = email,
        _username = username,
        _password = password,
        _currentStreak = currentStreak,
        _maxStreak = maxStreak,
        _preferences = preferences ?? Preferences();

  /// Getters e Setters
  String get email => _email;
  set email(String email) => _email = email;

  String get username => _username;
  set username(String username) => _username = username;

  String get password => _password;
  set password(String password) => _password = password;

  int get currentStreak => _currentStreak;
  set currentStreak(int streak) => _currentStreak = streak;

  int get maxStreak => _maxStreak;
  set maxStreak(int streak) => _maxStreak = streak;

  Preferences get preferences => _preferences;
  set preferences(Preferences preferences) => _preferences = preferences;

  /// Atualiza a sequência do usuário.
  void updateStreak(int newStreak) {
    _currentStreak = newStreak;
    if (newStreak > _maxStreak) {
      _maxStreak = newStreak;
    }
  }

  /// Converte o objeto [User] para um mapa (para salvar no Firebase).
  Map<String, dynamic> toMap() {
    return {
      'email': _email,
      'username': _username,
      'password': _password,
      'currentStreak': _currentStreak,
      'maxStreak': _maxStreak,
      'preferences': _preferences.toMap(),
    };
  }

  /// Cria uma instância [User] a partir de um mapa (ex.: dados do Firebase).
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      currentStreak: map['currentStreak'] ?? 0,
      maxStreak: map['maxStreak'] ?? 0,
      preferences: Preferences.fromMap(map['preferences'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'User(email: $_email, username: $_username, currentStreak: $_currentStreak, maxStreak: $_maxStreak, preferences: $_preferences)';
  }
}
