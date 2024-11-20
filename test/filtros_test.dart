import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/models/ods.dart';
import 'package:mc656finalproject/models/preferences.dart';
import 'package:mc656finalproject/models/desafio.dart';

void main(){
  group('Testa a classe filtro', (){
    test("Adiciona um Desafio", (){
      Preferences preferences = Preferences([TiposDeFiltros.erradicacaoDaPobreza]);
      Desafio desafio = Desafio(desafio: "Desafio 1", tema: "Tema 1");
      preferences.add_challenge(desafio);
      expect(preferences.possible_challenges.contains(desafio), true);
    });

    test("Remove um Desafio", (){
      Preferences preferences = Preferences([TiposDeFiltros.erradicacaoDaPobreza]);
      Desafio desafio = Desafio(desafio: "Desafio 1", tema: "Tema 1");
      preferences.add_challenge(desafio);
      preferences.remove_challenge(desafio);
      expect(preferences.possible_challenges.contains(desafio), false);
    });

    test("Com base no filtro, carregam desafios que tem o tema no nosso banco de dados", () async {
      Preferences preferences = Preferences([TiposDeFiltros.vidaTerrestre]);
      await preferences.load_all_possible_challenges();
      expect(preferences.possible_challenges.length, 3);

      for(Desafio desafio in preferences.possible_challenges){
        expect(desafio.tema, "Vida Terrestre");
      }
    });

    test("Não existem desafios que tem o tema ", () async {
      Preferences preferences = Preferences([TiposDeFiltros.vidaNaAgua]);
      await preferences.load_all_possible_challenges();
      expect(preferences.possible_challenges.length, 0);
    });

  });
}
