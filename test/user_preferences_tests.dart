import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'user_preferences_proxy.dart';
import 'data_base_proxy.dart';
import 'package:mc656finalproject/models/preferences.dart';

// Gera os mocks para o DataBaseProxy
@GenerateMocks([DataBaseProxy])
import 'user_preferences_tests.mocks.dart';

void main() {
  group('UserPreferencesProxy Tests', () {
    late MockDataBaseProxy mockDataBaseProxy;
    late UserPreferencesProxy userPreferencesProxy;

    setUp(() {
      mockDataBaseProxy = MockDataBaseProxy();
      userPreferencesProxy = UserPreferencesProxy(mockDataBaseProxy);
    });

    group('getUserPreferences', () {
      test('Usuário cadastrado -> Lista de preferências retornada', () async {
        // Mocka o comportamento para um usuário cadastrado
        when(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com"))
            .thenAnswer((_) async => ["ODS1", "ODS2"]);

        // Chama o método de teste
        final preferences = await userPreferencesProxy.getUserPreferences("valid_user@test.com");

        // Valida o resultado
        expect(preferences, isNotNull); // Deve retornar preferências
        expect(preferences?.preferences, equals(["ODS1", "ODS2"])); // Conteúdo correto
      });

      test('Usuário não cadastrado -> Retorna nulo', () async {
        // Mocka o comportamento para um usuário não cadastrado
        when(mockDataBaseProxy.fetchUserPreferences("invalid_user@test.com"))
            .thenAnswer((_) async => []);

        // Chama o método de teste
        final preferences = await userPreferencesProxy.getUserPreferences("invalid_user@test.com");

        // Valida o resultado
        expect(preferences, isNull); // Não deve retornar preferências
      });
    });

    group('updateUserPreferences', () {
      test('Atualiza preferências com sucesso', () async {
        // Mocka o método de conversão de preferências
        when(mockDataBaseProxy.turnPreferencesInString(any)).thenReturn(["ODS1", "ODS2"]);

        // Mocka o método de atualização no banco
        when(mockDataBaseProxy.updateUserPreferences(any, any)).thenAnswer((_) async {});

        // Executa o método
        final preferences = Preferences(preferences: ["ODS1", "ODS2"]);
        await userPreferencesProxy.updateUserPreferences("valid_user@test.com", preferences);

        // Verifica se os métodos corretos foram chamados
        verify(mockDataBaseProxy.turnPreferencesInString(preferences)).called(1);
        verify(mockDataBaseProxy.updateUserPreferences(["ODS1", "ODS2"], "valid_user@test.com"))
            .called(1);
      });

      test('Erro ao atualizar preferências', () async {
        // Mocka o método para lançar uma exceção
        when(mockDataBaseProxy.updateUserPreferences(any, any)).thenThrow(Exception("Erro de atualização"));

        // Executa o método
        final preferences = Preferences(preferences: ["ODS1", "ODS2"]);
        try {
          await userPreferencesProxy.updateUserPreferences("valid_user@test.com", preferences);
        } catch (e) {
          // Verifica se o método foi chamado e a exceção tratada
          verify(mockDataBaseProxy.updateUserPreferences(any, any)).called(1);
        }
      });
    });

    group('addPreference', () {
      test('Adiciona preferência a um usuário com preferências existentes', () async {
        // Mocka o comportamento para buscar preferências existentes
        when(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com"))
            .thenAnswer((_) async => ["ODS1"]);

        // Mocka o método de conversão de preferências
        when(mockDataBaseProxy.turnPreferencesInString(any)).thenReturn(["ODS1", "ODS2"]);

        // Mocka o método de atualização
        when(mockDataBaseProxy.updateUserPreferences(any, any)).thenAnswer((_) async {});

        // Executa o método
        await userPreferencesProxy.addPreference("valid_user@test.com", "ODS2");

        // Verifica se os métodos corretos foram chamados
        verify(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com")).called(1);
        verify(mockDataBaseProxy.turnPreferencesInString(any)).called(1);
        verify(mockDataBaseProxy.updateUserPreferences(["ODS1", "ODS2"], "valid_user@test.com"))
            .called(1);
      });

      test('Adiciona primeira preferência para um usuário sem preferências', () async {
        // Mocka o comportamento para retornar sem preferências
        when(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com"))
            .thenAnswer((_) async => []);

        // Mocka o método de conversão de preferências
        when(mockDataBaseProxy.turnPreferencesInString(any)).thenReturn(["ODS1"]);

        // Mocka o método de atualização
        when(mockDataBaseProxy.updateUserPreferences(any, any)).thenAnswer((_) async {});

        // Executa o método
        await userPreferencesProxy.addPreference("valid_user@test.com", "ODS1");

        // Verifica se os métodos corretos foram chamados
        verify(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com")).called(1);
        verify(mockDataBaseProxy.turnPreferencesInString(any)).called(1);
        verify(mockDataBaseProxy.updateUserPreferences(["ODS1"], "valid_user@test.com")).called(1);
      });
    });

    group('removePreference', () {
      test('Remove preferência existente do usuário', () async {
        // Mocka o comportamento para buscar preferências existentes
        when(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com"))
            .thenAnswer((_) async => ["ODS1", "ODS2"]);

        // Mocka o método de conversão de preferências
        when(mockDataBaseProxy.turnPreferencesInString(any)).thenReturn(["ODS2"]);

        // Mocka o método de atualização
        when(mockDataBaseProxy.updateUserPreferences(any, any)).thenAnswer((_) async {});

        // Executa o método
        await userPreferencesProxy.removePreference("valid_user@test.com", "ODS1");

        // Verifica se os métodos corretos foram chamados
        verify(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com")).called(1);
        verify(mockDataBaseProxy.turnPreferencesInString(any)).called(1);
        verify(mockDataBaseProxy.updateUserPreferences(["ODS2"], "valid_user@test.com")).called(1);
      });

      test('Tenta remover preferência de um usuário sem preferências', () async {
        // Mocka o comportamento para retornar sem preferências
        when(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com"))
            .thenAnswer((_) async => []);

        // Executa o método
        await userPreferencesProxy.removePreference("valid_user@test.com", "ODS1");

        // Verifica que o método de atualização não foi chamado
        verify(mockDataBaseProxy.fetchUserPreferences("valid_user@test.com")).called(1);
        verifyNever(mockDataBaseProxy.updateUserPreferences(any, any));
      });
    });
  });
}