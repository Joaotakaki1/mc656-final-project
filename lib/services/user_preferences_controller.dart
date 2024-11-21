import '../models/preferences.dart';
import 'master_controller.dart';

class UserPreferencesController {
  /// Recupera as preferências do usuário chamando a MasterController.
  static Future<Preferences?> getUserPreferences(String userId) async {
    try {
      // Busca os dados do usuário pelo MasterController
      Map<String, dynamic>? userData = await MasterController.fetchUserDataBase(userId);
      if (userData != null && userData.containsKey(userId)) {
        // Converte o campo "preferences" para o modelo Preferences
        final data = userData[userId];
        if (data['preferences'] != null) {
          return Preferences.fromMap(data['preferences']);
        }
      }
      print("Nenhuma preferência encontrada para o usuário.");
      return null;
    } catch (e) {
      print("Erro ao recuperar preferências: $e");
      return null;
    }
  }

  /// Atualiza as preferências do usuário chamando a MasterController.
  static Future<void> updateUserPreferences(String userId, Preferences preferences) async {
    try {
      // Atualiza as informações de preferência do usuário no Firebase
      await MasterController.updateUserData(userId, {
        'preferences': preferences.toMap(),
      });
      print("Preferências atualizadas com sucesso!");
    } catch (e) {
      print("Erro ao atualizar preferências: $e");
    }
  }

  /// Adiciona um tipo de preferência para o usuário.
  static Future<void> addPreferenceType(String userId, String newType) async {
    Preferences? preferences = await getUserPreferences(userId);
    if (preferences != null && !preferences.types.contains(newType)) {
      preferences.types.add(newType);
      await updateUserPreferences(userId, preferences);
      print("Tipo de preferência adicionado: $newType");
    } else {
      print("Tipo já existe ou erro ao carregar preferências.");
    }
  }

  /// Remove um tipo de preferência do usuário.
  static Future<void> removePreferenceType(String userId, String type) async {
    Preferences? preferences = await getUserPreferences(userId);
    if (preferences != null && preferences.types.contains(type)) {
      preferences.types.remove(type);
      await updateUserPreferences(userId, preferences);
      print("Tipo de preferência removido: $type");
    } else {
      print("Tipo não encontrado ou erro ao carregar preferências.");
    }
  }

}