import 'preferences.dart';
/*
 Classe que representa um usuário no aplicativo.
 Contém informações essenciais como email, senha, sequência (streaks)
 e preferências personalizadas.
*/
class User {
  /// Email do usuário (utilizado como identificador único).
  final String email;

  /// Nome de usuário (username).
  final String username;

  /// Senha do usuário.
  final String password;

  /// Sequência atual de atividades do usuário (dias consecutivos).
  int currentStreak;

  /// Maior sequência alcançada pelo usuário.
  int maxStreak;

  /// Preferências do usuário (inclui tipos e desafios).
  Preferences preferences;

  /* Construtor da classe [User].
    Inicializa os campos obrigatórios e define valores padrão para
    [currentStreak], [maxStreak] e [preferences].
  */
  User({
    required this.email,
    required this.username,
    required this.password,
    this.currentStreak = 0,
    this.maxStreak = 0,
    Preferences? preferences,
  }) : preferences = preferences ?? Preferences();

  /* 
    Converte o objeto [User] para um formato de mapa (Map<String, dynamic>).
    Para salvar no firebase, se necessario.
  */
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'currentStreak': currentStreak,
      'maxStreak': maxStreak,
      'preferences': preferences.toMap(),
    };
  }

  
  /*
    Cria uma instância [User] a partir de um mapa (Map<String, dynamic>).
    Se quiser recuperar os dados do firebase.
  */
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
  /*
    Atualiza a sequência atual do usuário.
    Caso a sequência atual ultrapasse a maior sequência, o valor de
    [maxStreak] será atualizado.
  */
  void updateStreak(int newStreak) {
    currentStreak = newStreak;
    if (newStreak > maxStreak) {
      maxStreak = newStreak;
    }
  }

  @override
  String toString() {
    return 'User(email: $email, username: $username, currentStreak: $currentStreak, maxStreak: $maxStreak, preferences: $preferences)';
  }
}
