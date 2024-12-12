import 'package:flutter/material.dart';
import 'package:mc656finalproject/screens/daily_progress_screen.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
import '../models/desafio.dart';
import 'package:provider/provider.dart';

// fazer as coisas serem diarias, diferença de 1 dia, e nao qualquer diferença de dias

/// Controlador responsável pela lógica de gamificação.
class GamificationController {
  int copos = 0;
  int pessoas = 0;

  static void milestoneStreak(bool concluiu, String user) async {
    int currentStreak = await getCurrentStreak(user);
    int maxStreak = await getMaxStreak(user);
    currentStreak += 1;
    updateUserCurrentStreak(currentStreak, user);
    if (currentStreak > maxStreak) {
      maxStreak = currentStreak;
      updateUserMaxStreak(maxStreak, user);
    }
  }

  void milestoneImpact(List<Desafio> completedChallenges) {
    // fazer o cálculo dos impactos de acordo com os desafios concluidos
  }

  static void changeDailyChallenges(String uid, BuildContext context) {
    var currentDate = getCurrentDate(uid);
    var lastLogin = getLastDate(uid);
    if (currentDate != lastLogin) {
      final challengeController =
        Provider.of<ChallengeController>(context, listen: false);
      challengeController.resetAllChallenges();
      challengeController.randomizeChallenges();
      }
      // bool concluiu = await DataBaseController.fetchCompletedChallenges(uid);
      // if (!concluiu) {

      //}
    }

  static Future<int> getCurrentStreak(String user) async {
    Map<String, dynamic> streaks = await DataBaseController.fetchUserStreak(user);
    return streaks['currentStreak'];
  }
  
  static Future<int> getMaxStreak(String user) async {
    Map<String, dynamic> streaks = await DataBaseController.fetchUserStreak(user);
    return streaks['maxStreak'];
  }

  static void updateUserMaxStreak(int max, String user) {
    DataBaseController.updateUserMaxStreak(max, user);
  }

  static void updateUserCurrentStreak(int current, String user) {
    DataBaseController.updateUserCurrentStreak(current, user);
  }

  static Future<String> getCurrentDate(String uid) async {
    return await DataBaseController.fetchUserCurrentLogin(uid);
  }

  static Future<String> getLastDate(String uid) async {
    return await DataBaseController.fetchUserLastLogin(uid);
  }
}