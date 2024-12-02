import 'package:mc656finalproject/services/data_base_controller.dart';
import '../models/user.dart';

/// Controlador responsável pela lógica de gamificação.
class GamificationController {

  /// Construtor que recebe a instância do usuário.
  GamificationController();

  /// Retorna a sequência atual do usuário, buscando do Firestore.
  Future<Map<String, int>> getUserStreak(User user) async {
    return await DataBaseController.fetchUserStreak(user.uid);
  }

  void updateUserMaxStreak(User user) {
    DataBaseController.updateUserMaxStreak(user.maxStreak, user.uid);
  }

  void updateUserCurrentStreak(User user) {
    DataBaseController.updateUserCurrentStreak(user.currentStreak, user.uid);
  }
}