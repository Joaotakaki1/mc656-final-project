import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/username_check.dart';


void main() {
  group('Verificação de Username:', () {
    test('Username já está em uso', () {
      expect(UsernameCheck.isSignedUp('RafaelCasonato'), true);
    });

    test('Username disponível', () {
      expect(UsernameCheck.isSignedUp('NovoUser'), false);
    });

  });
}
