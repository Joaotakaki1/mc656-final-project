import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/login_verify.dart';

void main() {
  group('LoginVerify', () {
    test('Deve retornar false e "esse usuário não existe" se o username não existir', () async {
      final result = await LoginCheck.loginVerify('FulanoDeTal', 'Password123');
      expect(result['success'], false);
      expect(result['message'], 'Usuário não cadastrado');
    });

    test('Deve retornar false e "senha incorreta" se o password estiver errado', () async {
      final result = await LoginCheck.loginVerify('matheusheusmat', 'senhaErrada');
      expect(result['success'], false);
      expect(result['message'], 'Senha Incorreta');
    });

    test('Deve retornar true e "Login feito com sucesso" se o username e o password estiverem corretos', () async {
      final result = await LoginCheck.loginVerify('matheusheusmat', 'm247277?');
      expect(result['success'], true);
      expect(result['message'], 'Login feito com sucesso');
    });

    test('Teste com outro usuário: username correto e senha correta', () async {
      final result = await LoginCheck.loginVerify('JoaoTakaki', 'j260545@');
      expect(result['success'], true);
      expect(result['message'], 'Login feito com sucesso');
    });

    test('Teste com outro usuário: false e "senha incorreta"', () async {
      final result = await LoginCheck.loginVerify('JoaoTakaki', 'wrongPassword');
      expect(result['success'], false);
      expect(result['message'], 'Senha Incorreta');
    });
  });
}