import '../models/desafio.dart';
import 'dart:convert';
import 'dart:io';

/// Classe responsável pela coleção de preferencias e seleção dos desafios
/// 
  /// Recebe como construtor uma lista de tipos de filtros.
  class Preferences {
  List<Desafio> possible_challenges = [];
  List<Desafio> completed_challenges = [];
  List<String> ods_preferences = [];

  Preferences(this.ods_preferences){
    load_all_possible_challenges();
  }
  /// Adiciona todos os desafios possiveis
  Future<void> load_all_possible_challenges() async {
    for (var ods in ods_preferences) {
      load_challenges(ods);
    }
  }
  ///Verifica existencia de um desafio
  bool check_existance(selected_challenge){
    if (possible_challenges.contains(selected_challenge)){
      return true;
    }
    else{
      return false;
    }
  }

  /// Dado um desafio, adiciona a lista de desafios
  void add_challenge(Desafio desafio){
    if(check_existance(desafio)){
      return;
    }
    possible_challenges.add(desafio);
    return;
  }

  /// Dado um desafio, remove da lista de desafios
  void remove_challenge(Desafio desafio){
    if(!check_existance(desafio)){
      return;
    }
    possible_challenges.remove(desafio);
    return;
  }

  // Marca um desafio como completo
  void finish_challenge(Desafio desafio){
    if(!check_existance(desafio)){
      return;
    }
    remove_challenge(desafio);
    completed_challenges.add(desafio);
    
    //Check the size of the possible_challenges to reset
    if(possible_challenges.length <= 0){
      load_all_possible_challenges();
    }

    return;
  }

  /// Coleta os desafios, com base no filtro
  Future<void> load_challenges(String choosen_ods, {String path = 'assets/ods_challenges_simple.json'}) async {
    var caminhoArquivo = path;
    final file = File(caminhoArquivo);
    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);

    for (var jsonItem in jsonData) {
      if (jsonItem['tema'] == choosen_ods){
        add_challenge(Desafio(
          desafio: jsonItem['desafio'],
          tema: jsonItem['tema'],
        ));
        }
    }
  return;
  }
}