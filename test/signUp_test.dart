import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/signUp.dart';

void main() {
  group('Verificação de cadastro:', () {
    List<dynamic> mockData = [
      {"username": "RafaelCasonato", "password": "r260660*"},
      {"username": "JoaoTakaki", "password": "j260545@"},
      {"username": "matheusheusmat", "password": "m247277?"},
      {"username": "lcardosott", "password": "l246125|"},
      {"username": "eduardorbl", "password": "e260551#"}
    ];
    String mockDataJson = jsonEncode(mockData);

    test('Cadastro concluído com sucesso', () async {
      String result =
          await SignUp.register('ThiagoNadim', 't239426.', mockDataJson);
      List<dynamic> updatedData = jsonDecode(result);
      List<dynamic> expectedData = [
        {"username": "RafaelCasonato", "password": "r260660*"},
        {"username": "JoaoTakaki", "password": "j260545@"},
        {"username": "matheusheusmat", "password": "m247277?"},
        {"username": "lcardosott", "password": "l246125|"},
        {"username": "eduardorbl", "password": "e260551#"},
        {"username": "ThiagoNadim", "password": "t239426."}
      ];
      expect(updatedData, expectedData);
    });

    test('Cadastro senha fraca', () async {
      String result = await SignUp.register('ViniLeme', 's', mockDataJson);
      List<dynamic> updatedData = jsonDecode(result);
      expect(updatedData, mockData);
    });

    test('Cadastro username em uso', () async {
      String result =
          await SignUp.register('RafaelCasonato', 'v2607277,', mockDataJson);
      List<dynamic> updatedData = jsonDecode(result);
      expect(updatedData, mockData);
    });
  });
}
