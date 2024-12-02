import 'preferences.dart';

/// Classe que representa um usuário no aplicativo.
class User {
  /// Email do usuário (identificador único).
  String _email;

  /// Nome de usuário (username).
  String _username;

  /// Senha do usuário.
  String _uid;

  /// Sequência atual de atividades do usuário (dias consecutivos).
  int _currentStreak;

  /// Maior sequência alcançada pelo usuário.
  int _maxStreak;

  /// Preferências do usuário.
  Preferences _preferences;

  int _coposSalvos;

  int _pessoasImpactadas;

  /// Construtor padrão.
  User({
    required String email,
    required String username,
    required String uid,
    int currentStreak = 0,
    int maxStreak = 0,
    int coposSalvos = 0,
    int pessoasImpactadas = 0,
    Preferences? preferences,
  })  : _email = email,
        _username = username,
        _uid = uid,
        _currentStreak = currentStreak,
        _maxStreak = maxStreak,
        _coposSalvos = coposSalvos,
        _pessoasImpactadas = pessoasImpactadas,
        _preferences = preferences ?? Preferences();
        
  /// Getters e Setters
  String get email => _email;
  set email(String email) => _email = email;

  String get username => _username;
  set username(String username) => _username = username;

  String get uid => _uid;
  set password(String password) => _uid = uid;

  int get currentStreak => _currentStreak;
  set currentStreak(int streak) => _currentStreak = streak;

  int get maxStreak => _maxStreak;
  set maxStreak(int streak) => _maxStreak = streak;

  int get coposSalvos => _coposSalvos;
  set coposSalvos(int coposSalvos) => _coposSalvos = coposSalvos;

  int get pessoasImpactadas => _pessoasImpactadas;
  set pessoasImpactadas(int pessoasImpactadas) => _pessoasImpactadas = pessoasImpactadas;

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
      'uid': _uid,
      'currentStreak': _currentStreak,
      'maxStreak': _maxStreak,
      'preferences': _preferences.toMap(),
      'coposSalvos': _coposSalvos,
      'pessoasImpactadas': _pessoasImpactadas,
    };
  }

  /// Cria uma instância [User] a partir de um mapa (ex.: dados do Firebase).
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      currentStreak: map['currentStreak'] ?? 0,
      maxStreak: map['maxStreak'] ?? 0,
      preferences: Preferences.fromMap(map['preferences'] ?? {}),
      coposSalvos: map['coposSalvos'] ?? 0,
      pessoasImpactadas: map['pessoasImpactadas'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'User(email: $_email, username: $_username, currentStreak: $_currentStreak, maxStreak: $_maxStreak, preferences: $_preferences)';
  }
}
