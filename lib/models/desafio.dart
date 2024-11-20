/// Classe que representa um desafio.
class Desafio {
  /// Descricao do desafio
  String _desafio;

  /// Tema do desafio
  String _tema;

  /// Construtor padrão.
  Desafio({
    required String desafio,
    required String tema,
  })  : _desafio = desafio,
        _tema = tema;

  /// Getters e Setters
  String get desafio => _desafio;
  set desafio(String desafio) => _desafio = desafio;

  String get tema => _tema;
  set tema(String tema) => _tema = tema;

  /// Converte a instância [Desafio] para um mapa (para salvar no Firebase).
  Map<String, dynamic> toMap() {
    return {
      'desafio': _desafio,
      'tema': _tema,
    };
  }

  /// Cria uma instância [Desafio] a partir de um mapa (ex.: dados do Firebase).
  factory Desafio.fromMap(Map<String, dynamic> map) {
    return Desafio(
      desafio: map['desafio'],
      tema: map['tema'],
    );
  }

  @override
  String toString() {
    return 'Desafio(desafio: $_desafio, tema: $_tema)';
  }
}