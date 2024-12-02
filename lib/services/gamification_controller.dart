import 'package:mc656finalproject/services/data_bank_controller.dart';
import '../models/user.dart';

/// Controlador responsável pela lógica de gamificação.
class GamificationController {

  /// Construtor que recebe a instância do usuário.
  GamificationController();

  /// Retorna a sequência atual do usuário, buscando do Firestore.
  Future<Map<String, int>> getUserStreak(User user) async {
    return await DataBankController.fetchUserStreak(user.uid);
  }

  void updateUserMaxStreak(User user) {
    DataBankController.updateUserMaxStreak(user.maxStreak, user.uid);
  }

  void updateUserCurrentStreak(User user) {
    DataBankController.updateUserCurrentStreak(user.currentStreak, user.uid);
  }
}