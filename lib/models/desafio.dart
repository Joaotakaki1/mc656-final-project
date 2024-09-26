class Desafio {
  String _desafio;
  String _tema;
  String _dificuldade;

  Desafio({required String desafio, required String tema, required String dificuldade})
      : _desafio = desafio,
        _tema = tema,
        _dificuldade = dificuldade;

  String get desafio => _desafio;
  set desafio(String value) => _desafio = value;

  String get tema => _tema;
  set tema(String value) => _tema = value;

  String get dificuldade => _dificuldade;
  set dificuldade(String value) => _dificuldade = value;
}