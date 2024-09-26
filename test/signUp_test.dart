import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/signUp.dart';


void main() {
  group('Verificação de cadastro:', () {
    test('Cadastro concluido com sucesso', () async {
      expect(await SignUp.register('ThiagoNadim', 't239426.'), true);
    });

    test('Cadastro senha fraca', () async {
      expect(await SignUp.register('ViniLeme', 's'), false);
    });

    test('Cadastro username em uso', () async {
      expect(await SignUp.register('RafaelCasonato', 'v2607277,'), false);
    });

  });
}
