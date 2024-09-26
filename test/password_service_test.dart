import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/password_service.dart';


void main() {
  group('Verificação de senha forte', () {
    test('Senha é forte se todos as condições forem validadas', () {
      expect(PasswordService.isStrongPassword('Teste123!'), true);
    });

    test('Senha é fraca quando possui menos de 8 caracteres', () {
      expect(PasswordService.isStrongPassword('Tes1!'), false);
    });

    test('Senha é fraca quando não possui números', () {
      expect(PasswordService.isStrongPassword('Teste!!!'), false);
    });

    test('Senha é fraca quando não possui caracteres especiais', () {
      expect(PasswordService.isStrongPassword('Teste1234'), false);
    });

    test('Senha é fraca quando não possui letras', () {
      expect(PasswordService.isStrongPassword('12345678!'), false);
    });
  });
}
