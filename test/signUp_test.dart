import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/signUp.dart';


void main() {
  group('Verificação de cadastro:', () {
    test('Cadastro concluido com sucesso', () async {
      expect(await SignUp.register('ThiagoNadim', 't239426.'), {'success': true, 'message': 'Cadastro realizado com sucesso.'});
    });

    test('Cadastro senha fraca', () async {
      expect(await SignUp.register('ViniLeme', 's'), {'success': false, 'message': 'Senha não é forte o suficiente.'});
    });

    test('Cadastro username em uso', () async {
      expect(await SignUp.register('RafaelCasonato', 'v2607277,'), {'success': false, 'message': 'Nome de usuário já está em uso.'});
    });

  });
}
