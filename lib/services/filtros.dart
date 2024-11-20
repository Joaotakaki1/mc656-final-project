import '../models/desafio.dart';
import 'ods.dart';
import 'dart:convert';
import 'dart:io';

/// Classe responsável pela filtragem e seleção dos desafios
class Filtro {
  List<Desafio> desafiosSelecionados = [];
  TiposDeFiltros filtro;

  Filtro(this.filtro);

  ///Verifica existencia de um desafio
  bool verificaExistencia(desafioSelecionado){
    if (desafiosSelecionados.contains(desafioSelecionado)){
      return true;
    }
    else{
      return false;
    }
  }

  /// Dado um desafio, adiciona a lista de desafios
  void adicionarDesafio(Desafio desafio){
    if(verificaExistencia(desafio)){
      return;
    }
    desafiosSelecionados.add(desafio);
    return;
  }

  /// Dado um desafio, remove da lista de desafios
  void removeDesafio(Desafio desafio){
    if(!verificaExistencia(desafio)){
      return;
    }
    desafiosSelecionados.remove(desafio);
    return;
  }

  /// Coleta os desafios, com base no filtro
  Future<void> carregarDesafios({String path = 'assets/ods_challenges_simple.json'}) async {
    var caminhoArquivo = path;
    final file = File(caminhoArquivo);
    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);

    for (var jsonItem in jsonData) {
      if (ODS.getFiltro(jsonItem['tema']) == filtro){
        adicionarDesafio(Desafio(
          desafio: jsonItem['desafio'],
          tema: jsonItem['tema'],
          dificuldade: jsonItem['dificuldade'],
        ));
        }
    }
  return;
  }
}
