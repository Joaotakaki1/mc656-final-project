/// Classe que representa as preferências do usuário.
class Preferences {
  List<String> _preferences;

  Preferences({List<String>? preferences})
      : _preferences = preferences ?? [];

  List<String> get preferences => _preferences;

  set preferences(List<String> preferences) {
    _preferences = preferences;
  }

  /// Adiciona uma nova preferência, caso ainda não esteja na lista.
  void addPreference(String preference) {
    if (!_preferences.contains(preference)) {
      _preferences.add(preference);
    }
  }

  /// Remove uma preferência, caso ela exista.
  void removePreference(String preference) {
    _preferences.remove(preference);
  }

  /// Verifica se uma preferência está presente na lista.
  bool hasPreference(String preference) {
    return _preferences.contains(preference);
  }

  /// Converte a instância [Preferences] para um mapa (para salvar no Firebase).
  Map<String, dynamic> toMap() {
    return {
      'preferences': _preferences,
    };
  }

  /// Cria uma instância [Preferences] a partir de um mapa (ex.: dados do Firebase).
  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      preferences: List<String>.from(map['preferences'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Preferences(preferences: $_preferences)';
  }
}
