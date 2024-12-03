import 'dart:developer';
import '../models/preferences.dart';
import 'data_base_controller.dart';

class UserPreferencesController {
  /// Recupera as preferências do usuário utilizando o DataBankController.
  static Future<Preferences?> getUserPreferences(String email) async {
    try {
      // Busca as preferências do usuário pelo DataBankController.
      var preferencesList = await DataBaseController.fetchUserPreferences(email);

      if (preferencesList.isNotEmpty) {
        return Preferences(preferences: preferencesList);
      } else {
        log("Nenhuma preferência encontrada para o usuário.");
        return null;
      }
    } catch (e) {
      log("Erro ao recuperar preferências: $e", level: 1000); // Level 1000 = Severe
      return null;
    }
  }

  /// Atualiza as preferências do usuário utilizando o DataBankController.
  static Future<void> updateUserPreferences(String email, Preferences preferences) async {
    try {
      List<String> stringPreferences = DataBaseController.turnPreferencesInString(preferences);
      await DataBaseController.updateUserPreferences(stringPreferences, email);
      log("Preferências atualizadas com sucesso!");
    } catch (e) {
      log("Erro ao atualizar preferências: $e", level: 1000);
    }
  }

  /// Adiciona uma nova preferência para o usuário.
  static Future<void> addPreference(String email, String preference) async {
    try {
      Preferences? currentPreferences = await getUserPreferences(email);
      if (currentPreferences != null) {
        currentPreferences.addPreference(preference);
        await updateUserPreferences(email, currentPreferences);
        log("Preferência adicionada: $preference");
      } else {
        // Se não houver preferências, cria uma nova lista com a nova preferência.
        var newPreferences = Preferences(preferences: [preference]);
        await updateUserPreferences(email, newPreferences);
        log("Primeira preferência adicionada: $preference");
      }
    } catch (e) {
      log("Erro ao adicionar preferência: $e", level: 1000);
    }
  }

  /// Remove uma preferência do usuário.
  static Future<void> removePreference(String email, String preference) async {
    try {
      Preferences? currentPreferences = await getUserPreferences(email);
      if (currentPreferences != null) {
        currentPreferences.removePreference(preference);
        await updateUserPreferences(email, currentPreferences);
        log("Preferência removida: $preference");
      } else {
        log("Nenhuma preferência encontrada para remover.");
      }
    } catch (e) {
      log("Erro ao remover preferência: $e", level: 1000);
    }
  }
}