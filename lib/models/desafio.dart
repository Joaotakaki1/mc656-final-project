class Desafio {
  String _desafio;
  String _tema;

  Desafio({
    required String desafio, 
    required String tema, 
  })
    : _desafio = desafio,
      _tema = tema;

  String get desafio => _desafio;
  set desafio(String value) => _desafio = value;

  String get tema => _tema;
  set tema(String value) => _tema = value;
}