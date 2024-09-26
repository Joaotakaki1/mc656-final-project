import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/desafiosUsuario.dart';

void main() {
  group('DesafiosUsuario', () {
    late DesafiosUsuario desafiosUsuario;

    setUp(() {
      desafiosUsuario = DesafiosUsuario();
    });

    test('carregarDesafios carrega desafios corretamente', () async {
      await desafiosUsuario.carregarDesafios();
      expect(desafiosUsuario.desafios.isNotEmpty, true);
    });

    test('obterDesafiosAleatorios retorna a quantidade correta de desafios', () async {
      await desafiosUsuario.obterDesafiosAleatorios(2, 2, 2);
      expect(desafiosUsuario.desafios.length, 6);
    });

    test('obterDesafiosAleatorios não retorna desafios duplicados', () async {
      await desafiosUsuario.obterDesafiosAleatorios(2, 2, 2);
      final desafiosList = desafiosUsuario.desafios.toList();
      final desafiosSet = desafiosUsuario.desafios;
      expect(desafiosList.length, desafiosSet.length);
    });

    test('obterDesafiosAleatorios retorna desafios com dificuldades corretas', () async {
      await desafiosUsuario.obterDesafiosAleatorios(2, 2, 2);
      final facil = desafiosUsuario.desafios.where((d) => d.dificuldade == 'Fácil').length;
      final medio = desafiosUsuario.desafios.where((d) => d.dificuldade == 'Médio').length;
      final dificil = desafiosUsuario.desafios.where((d) => d.dificuldade == 'Difícil').length;
      expect(facil, 2);
      expect(medio, 2);
      expect(dificil, 2);
    });
  });
}