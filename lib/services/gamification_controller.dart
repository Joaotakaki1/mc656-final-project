import 'package:mc656finalproject/services/data_base_controller.dart';
import '../models/user.dart';

/// Controlador responsável pela lógica de gamificação.
class GamificationController {
  String uid;
  bool concluido;

  GamificationController({required this.uid, required this.concluido}) {
    getCurrentDate();
    getLastDate();
    getStreaks();
    changeDailyChallenges();
  }

  int currentStreak = 0;
  int maxStreak = 0;
  String currentDate = '';
  String lastLogin = '';
  int copos = 0;
  int pessoas = 0;

  void getCurrentDate() {
    currentDate = DateTime.now().toIso8601String().split('T')[0];
  }

  Future<void> getLastDate() async {
    lastLogin = await DataBaseController.fetchUserLastLogin(uid);
  }

  void changeDailyChallenges() {
    if (currentDate != lastLogin) {
      if (concluido) {
        currentStreak += 1;
        updateUserCurrentStreak();
        if (currentStreak > maxStreak) {
          maxStreak = currentStreak;
          updateUserMaxStreak();
        }
      } else if (!concluido) {
        currentStreak = 0;
        updateUserCurrentStreak();
      }
    //pedir 3 novas challenges
    }
  }

  /// Retorna a sequência atual do usuário, buscando do Firestore.
  void getStreaks() async {
    Map<String, dynamic> streaks = await DataBaseController.fetchUserStreak(uid);
    currentStreak = streaks['currentStreak'];
    maxStreak = streaks['maxStreak'];
  }

  void updateUserMaxStreak() {
    DataBaseController.updateUserMaxStreak(maxStreak, uid);
  }

  void updateUserCurrentStreak() {
    DataBaseController.updateUserCurrentStreak(currentStreak, uid);
  }
}