import 'package:flutter_test/flutter_test.dart';
import 'package:mc656finalproject/services/ods.dart';
import 'package:mc656finalproject/services/filtros.dart';
import 'package:mc656finalproject/models/desafio.dart';

void main(){
  group('Testa a classe filtro', (){
    test("Adiciona um Desafio", (){
      Filtro filtro = Filtro(TiposDeFiltros.erradicacaoDaPobreza);
      Desafio desafio = Desafio(desafio: "Desafio 1", tema: "Tema 1", dificuldade: "Dificuldade 1");
      filtro.adicionarDesafio(desafio);
      expect(filtro.desafiosSelecionados.contains(desafio), true);
    });

    test("Remove um Desafio", (){
      Filtro filtro = Filtro(TiposDeFiltros.erradicacaoDaPobreza);
      Desafio desafio = Desafio(desafio: "Desafio 1", tema: "Tema 1", dificuldade: "Dificuldade 1");
      filtro.adicionarDesafio(desafio);
      filtro.removeDesafio(desafio);
      expect(filtro.desafiosSelecionados.contains(desafio), false);
    });

    test("Com base no filtro, carregam desafios que tem o tema no nosso banco de dados", () async {
      Filtro filtro = Filtro(TiposDeFiltros.vidaTerrestre);
      await filtro.carregarDesafios(path: "test/assets/filter_example.json");
      expect(filtro.desafiosSelecionados.length, 3);

      for(Desafio desafio in filtro.desafiosSelecionados){
        expect(desafio.tema, "Vida Terrestre");
      }
    });

    test("Não existem desafios que tem o tema ", () async {
      Filtro filtro = Filtro(TiposDeFiltros.vidaNaAgua);
      await filtro.carregarDesafios(path: "test/assets/filter_example.json");
      expect(filtro.desafiosSelecionados.length, 0);
    });

  });
}
