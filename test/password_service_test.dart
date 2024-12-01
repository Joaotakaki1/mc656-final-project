import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/password_service.dart';


void main() {
  group('Verificação de senha forte', () {

    test('Caso 1 - Senha válida: tam >= 8, min 1 num, min 1 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('abcd123@'), true);
    });

    test('Caso 2 - Senha inválida: tam < 8, 0 num, 0 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('_______'), false);
    });

    test('Caso 3 - Senha inválida: tam < 8, 0 num, 0 let, 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('!@#.?!:'), false);
    });

    test('Caso 4 - Senha inválida: tam < 8, 0 num, min 1 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('abcdefg'), false);
    });

    test('Caso 5 - Senha inválida: tam < 8, 0 num, min 1 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('abcdef!'), false);
    });

    test('Caso 6 - Senha inválida: tam < 8, min 1 num, 0 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('8765432'), false);
    });

    test('Caso 7 - Senha inválida: tam < 8, min 1 num, 0 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('1!2@3#4'), false);
    });

    test('Caso 8 - Senha inválida: tam < 8, min 1 num, min 1 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('abcde34'), false);
    });

    test('Caso 9 - Senha inválida: tam < 8, min 1 num, min 1 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('qwert!6'), false);
    });

    test('Caso 10 - Senha inválida: tam >= 8, 0 num, 0 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('________'), false);
    });

    test('Caso 11 - Senha inválida: tam >= 8, 0 num, 0 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('!@#!@#!@'), false);
    });

    test('Caso 12 - Senha inválida: tam >= 8, 0 num, min 1 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('qwertyui'), false);
    });

    test('Caso 13 - Senha inválida: tam >= 8, 0 num, min 1 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('testand@'), false);
    });

    test('Caso 14 - Senha inválida: tam >= 8, min 1 num, 0 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('20240101'), false);
    });

    test('Caso 15 - Senha inválida: tam >= 8, min 1 num, 0 let, min 1 carac. esp', () {
      expect(PasswordService.isStrongPassword('1!2@3#2@'), false);
    });

    test('Caso 16 - Senha inválida: tam >= 8, min 1 num, min 1 let, 0 carac. esp', () {
      expect(PasswordService.isStrongPassword('mrjel200'), false);
    });

  });
}
