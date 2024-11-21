import 'package:mc656finalproject/services/master_controller.dart';
import '../models/user.dart';

/// Controlador responsável pela lógica de gamificação.
class GamificationController {

  /// Construtor que recebe a instância do usuário.
  GamificationController();

  /// Retorna a sequência atual do usuário, buscando do Firestore.
  Future<List<int>> getUserStreak(User user) async {
    return await MasterController.fetchUserStreak(user.uid);
  }

  void updateUserStreak(User user) {
    MasterController.updateUserStreakDataBase(user.maxStreak, user.currentStreak, user.uid);
  }
}