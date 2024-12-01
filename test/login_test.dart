import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc656finalproject/services/login_controller.dart';

// Gera os mocks para FirebaseAuth, UserCredential e User
@GenerateMocks([FirebaseAuth, UserCredential, User])
import 'login_test.mocks.dart';

class MockUser extends Mock implements User {}

void main() {
  group('Login Tests', () {
    late MockFirebaseAuth mockAuth;
    late MockUserCredential mockUserCredential;
    late LoginController loginController;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      loginController = LoginController(firebaseAuth: mockAuth);
    });

    test('E-mail cadastrado e senha correta -> Acesso permitido', () async {
      // Mocka o usuário autenticado
      final mockUser = MockUser();
      when(mockAuth.signInWithEmailAndPassword(
        email: "teste@teste.com",
        password: "senha123",
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(mockUser);

      // Executa o método de login
      final result = await loginController.loginWithEmailPassword(
        "teste@teste.com",
        "senha123",
      );

      // Valida o resultado
      expect(result['success'], true);
      expect(result['message'], 'Login feito com sucesso');
      expect(result['user'], isNotNull); // Valida que o usuário está presente
    });

    test('E-mail cadastrado e senha incorreta -> Acesso negado', () async {
      // Mocka exceção para senha incorreta
      when(mockAuth.signInWithEmailAndPassword(
        email: "teste@teste.com",
        password: "senhaerrada",
      )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      // Executa o método de login
      final result = await loginController.loginWithEmailPassword(
        "teste@teste.com",
        "senhaerrada",
      );

      // Valida o resultado
      expect(result['success'], false);
      expect(result['message'], 'Senha Incorreta');
    });

    test('E-mail não cadastrado -> Acesso negado', () async {
      // Mocka exceção para e-mail não cadastrado
      when(mockAuth.signInWithEmailAndPassword(
        email: "naoexiste@teste.com",
        password: "senha123",
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      // Executa o método de login
      final result = await loginController.loginWithEmailPassword(
        "naoexiste@teste.com",
        "senha123",
      );

      // Valida o resultado
      expect(result['success'], false);
      expect(result['message'], 'Usuário não cadastrado');
    });
  });
}
