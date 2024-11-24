import 'dart:math';
import '../services/master_controller.dart';
import '../models/desafio.dart';
import '../models/preferences.dart';

class ChallengeController {
  late Preferences preferences;

  List<Desafio> possible_challenges = [];
  List<Desafio> completed_challenges = [];
  List<Desafio> current_challenges = [];

  ChallengeController(List<String> ods_preferences) {
    preferences = Preferences();
    preferences.preferences = ods_preferences;
  }

  Future<void> load_all_possible_challenges() async {
    possible_challenges.clear(); // Limpa a lista antes de carregar novos desafios
    for (var ods in preferences.preferences) {
      List<Desafio> challengesByOds = await MasterController.fetchDesafioTema(ods);
      for (var challenge in challengesByOds) {
        possible_challenges.add(challenge);
      }
    }
  }

  void randomize_challenges() {
    if (possible_challenges.isEmpty) {
      print('Nenhum desafio disponível.');
      return;
    }

    Random random = Random();
    List<int> indexes = [];
    int numChallenges = min(3, possible_challenges.length); // Garantir que não tente pegar mais desafios do que existem

    while (indexes.length < numChallenges) {
      int index = random.nextInt(possible_challenges.length);
      if (!indexes.contains(index)) {
        indexes.add(index);
      }
    }

    for (var i in indexes) {
      current_challenges.add(possible_challenges[i]);
    }

    // Remover os desafios selecionados da lista de possíveis desafios
    indexes.sort((a, b) => b.compareTo(a)); // Ordenar os índices em ordem decrescente
    for (var i in indexes) {
      possible_challenges.removeAt(i);
    }
  }

  void completed_challenge(Desafio desafio) {
    current_challenges.remove(desafio);
    completed_challenges.add(desafio);
  }

  void setPreferences(List<String> newPreferences) {
    preferences.preferences = newPreferences;
    load_all_possible_challenges(); // Opcional: recarregar desafios com base nas novas preferências
  }
}