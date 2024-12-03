/// Classe que representa um desafio.
class Desafio {
  /// Descricao do desafio
  String _desafio;

  /// Tema do desafio
  String _tema;

  String _descricaoCurta;
  String _descricao;
  int _pessoasAfetadas;
  int _coposPlasticos;
  List<String> _impactoQualitativo;


  /// Construtor padrão.
  Desafio({
    required String desafio,
    required String tema,
    required String descricaoCurta,
    required String descricao,
    required int pessoasAfetadas,
    required int coposPlasticos,
    required List<String> impactoQualitativo,
  })  : _desafio = desafio,
        _tema = tema,
        _descricaoCurta = descricaoCurta,
        _descricao = descricao,
        _pessoasAfetadas = pessoasAfetadas,
        _coposPlasticos = coposPlasticos,
        _impactoQualitativo = impactoQualitativo;

  /// Getters e Setters
  String get desafio => _desafio;
  set desafio(String desafio) => _desafio = desafio;

  String get tema => _tema;
  set tema(String tema) => _tema = tema;
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;
  int get pessoasAfetadas => _pessoasAfetadas;
  set pessoasAfetadas(int pessoasAfetadas) => _pessoasAfetadas = pessoasAfetadas;
  int get coposPlasticos => _coposPlasticos;
  set coposPlasticos(int coposPlasticos) => _coposPlasticos = coposPlasticos;
  /// Converte a instância [Desafio] para um mapa (para salvar no Firebase).
  Map<String, dynamic> toMap() {
    return {
      'desafio': _desafio,
      'tema': _tema,
    };
  }

    factory Desafio.fromFirestore(Map<String, dynamic> data) {
    return Desafio(
      desafio: data['nome'] ?? '',
      descricaoCurta: data['descricao_curta'] ?? '',
      descricao: data['descricao'] ?? '',
      tema: data['ods'] ?? '',
      pessoasAfetadas: data['impacto_quantitativo']?['pessoas_afetadas'] ?? 0,
      coposPlasticos: data['impacto_quantitativo']?['copos_plasticos'] ?? 0,
      impactoQualitativo: List<String>.from(data['impacto_qualitativo'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Desafio(desafio: $_desafio, tema: $_tema)';
  }
}