import 'dart:convert';
import 'dart:io';
import '../desafio.dart';
import 'dart:math';

class DesafiosUsuario {
  final Set<Desafio> _desafios = {};

  Set<Desafio> get desafios => _desafios;

  Future<void> carregarDesafios() async {
    const caminhoArquivo = 'assets/ods_challenges_simple.json';
    final file = File(caminhoArquivo);
    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);

    for (var jsonItem in jsonData) {
      _desafios.add(Desafio(
        desafio: jsonItem['desafio'],
        tema: jsonItem['tema'],
        dificuldade: jsonItem['dificuldade'],
      ));
    }
  }

  Future<void> obterDesafiosAleatorios(int facil, int medio, int dificil) async {
    await carregarDesafios();
    final random = Random();
    final Set<Desafio> desafiosAleatorios = {};

    List<Desafio> desafiosFacil = _desafios.where((d) => d.dificuldade == 'Fácil').toList();
    List<Desafio> desafiosMedio = _desafios.where((d) => d.dificuldade == 'Médio').toList();
    List<Desafio> desafiosDificil = _desafios.where((d) => d.dificuldade == 'Difícil').toList();

    // Adicionar desafios fáceis
    while (desafiosAleatorios.length < facil && desafiosFacil.isNotEmpty) {
        desafiosAleatorios.add(desafiosFacil.removeAt(random.nextInt(desafiosFacil.length)));
    }

    // Adicionar desafios médios
    while (desafiosAleatorios.length < facil + medio && desafiosMedio.isNotEmpty) {
        desafiosAleatorios.add(desafiosMedio.removeAt(random.nextInt(desafiosMedio.length)));
    }

    // Adicionar desafios difíceis
    while (desafiosAleatorios.length < facil + medio + dificil && desafiosDificil.isNotEmpty) {
        desafiosAleatorios.add(desafiosDificil.removeAt(random.nextInt(desafiosDificil.length)));
    }

    // Preencher desafios restantes com qualquer dificuldade disponível
    List<Desafio> desafiosRestantes = <Desafio>[...desafiosFacil, ...desafiosMedio, ...desafiosDificil];

    while (desafiosAleatorios.length < facil + medio + dificil && desafiosRestantes.isNotEmpty) {
        desafiosAleatorios.add(desafiosRestantes.removeAt(random.nextInt(desafiosRestantes.length)));
    }

    _desafios
      ..clear() // Clear the existing set of challenges
      ..addAll(desafiosAleatorios); // Add the selected challenges to the class attribute set
  }
}