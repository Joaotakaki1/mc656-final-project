import 'dart:math';
import '../services/master_controller.dart';
import '../models/desafio.dart';
import '../models/preferences.dart';

class ChallengeController {

  late Preferences preferences;

  List<Desafio> possible_challenges = [];
  List<Desafio> completed_challenges = [];
  List<Desafio> current_challenges = [];

  ChallengeController(List<String> ods_preferences){
    preferences = Preferences();
    preferences.preferences = ods_preferences;
    }

  void load_all_possible_challenges() async {
    for (var ods in preferences.preferences) {
      List<Desafio> challenges_by_ods = await MasterController.fetchDesafioTema(ods);
      for (var challenge in challenges_by_ods){
        possible_challenges.add(challenge);
      }
    }
  }

  void randomize_challenges(){
    // Randomize the challenges
    // Generate 3 random numbers in the range of the possible_challenges
    // Add the challenges to the current_challenges

    Random random = Random();
    List<int> indexes = [];
    while(indexes.length < 3){
      int index = random.nextInt(possible_challenges.length);
      if(!indexes.contains(index)){
        indexes.add(index);
      }
    }

    for (var i in indexes){
      current_challenges.add(possible_challenges[i]);
      possible_challenges.remove(possible_challenges[i]);
    }
  }

  void completed_challenge(Desafio desafio){
    current_challenges.remove(desafio);
    completed_challenges.add(desafio);
  }
}

