/// Classe que representa as preferências do usuário.
class Preferences {
  /// Lista de preferências (ex.: ['Nome da ODS']).
  List<String> _preferences;

  /// Construtor padrão.
  Preferences({List<String>? preferences})
      : _preferences = preferences ?? [];

  /// Getter para obter as preferências.
  List<String> get preferences => _preferences;

  /// Setter para definir as preferências.
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

  /// Cria uma instância [Preferences] a partir de um mapa (ex.: dados do Firebases).
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
