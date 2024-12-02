import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mc656finalproject/services/user_preferences_controller.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';

// Gera os mocks para o MasterController
@GenerateMocks([DataBaseController])
import 'user_preferences_tests.mocks.dart';

void main() {
  group('UserPreferencesController.getUserPreferences', () {
    late MockDataBaseController mockDataBaseController;

    setUp(() {
      mockDataBaseController = MockDataBaseController();
    });

    test('Usuário cadastrado -> Lista de preferências retornada', () async {
      // Mocka o comportamento para um usuário cadastrado
      when(mockDataBaseController.fetchUserPreferences("valid_user@test.com"))
          .thenAnswer((_) async => ["ODS1", "ODS2"]);

      // Chama o método de teste
      final preferences = await UserPreferencesController.getUserPreferences("valid_user@test.com");

      // Valida o resultado
      expect(preferences, isNotNull); // Deve retornar preferências
      expect(preferences?.preferences, equals(["ODS1", "ODS2"])); // Conteúdo correto
    });

    test('Usuário não cadastrado -> Retorna nulo', () async {
      // Mocka o comportamento para um usuário não cadastrado
      when(mockDataBaseController.fetchUserPreferences("invalid_user@test.com"))
          .thenAnswer((_) async => []);

      // Chama o método de teste
      final preferences = await UserPreferencesController.getUserPreferences("invalid_user@test.com");

      // Valida o resultado
      expect(preferences, isNull); // Não deve retornar preferências
    });
  });
}