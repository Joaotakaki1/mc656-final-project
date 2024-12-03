import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc656finalproject/services/login_controller.dart';

// Gera os mocks para FirebaseAuth, UserCredential e User com nomes únicos
@GenerateMocks(
  [FirebaseAuth, UserCredential],
  customMocks: [
    MockSpec<User>(as: #MockFirebaseUser),
  ],
)
import 'login_test.mocks.dart';

void main() {
  group('Login Tests', () {
    late MockFirebaseAuth mockAuth;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
    });

    test('E-mail cadastrado e senha correta -> Acesso permitido', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: "teste@teste.com",
        password: "senha123",
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(MockFirebaseUser());

      final result = await LoginController.loginWithEmailPassword(
        "teste@teste.com",
        "senha123",
        mock: mockAuth
      );

      expect(result['success'], true);
      expect(result['message'], 'Login feito com sucesso');
    });

    test('E-mail cadastrado e senha incorreta -> Acesso negado', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: "teste@teste.com",
        password: "senhaerrada",
      )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      final result = await LoginController.loginWithEmailPassword(
        "teste@teste.com",
        "senhaerrada",
        mock: mockAuth
      );

      expect(result['success'], false);
      expect(result['message'], 'Senha Incorreta');
    });

    test('E-mail não cadastrado -> Acesso negado', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: "naoexiste@teste.com",
        password: "senha123",
      )).thenThrow(FirebaseAuthException(code: 'user-not-found'));

      final result = await LoginController.loginWithEmailPassword(
        "naoexiste@teste.com",
        "senha123",
        mock: mockAuth
      );

      expect(result['success'], false);
      expect(result['message'], 'Usuário não cadastrado');
    });
  });
}