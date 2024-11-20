enum TiposDeFiltros {
  erradicacaoDaPobreza,
  fomeZeroEAgriculturaSustentavel,
  saudeEBemEstar,
  educacaoDeQualidade,
  igualdadeDeGenero,
  aguaPotavelESaneamento,
  energiaAcessivelELimpa,
  trabalhoDecenteECrescimentoEconomico,
  industriaInovacaoEInfraestrutura,
  reducaoDasDesigualdades,
  cidadesEComunidadesSustentaveis,
  consumoEProducaoResponsaveis,
  acoesContraMudancaGlobalDoClima,
  vidaNaAgua,
  vidaTerrestre,
  pazJusticaEInstituicoesEficazes,
}

class ODS {
  static const Map<String, TiposDeFiltros> _filtrosMap = {
    "Erradicação da Pobreza": TiposDeFiltros.erradicacaoDaPobreza,
    "Fome Zero e Agricultura Sustentável": TiposDeFiltros.fomeZeroEAgriculturaSustentavel,
    "Saúde e Bem-Estar": TiposDeFiltros.saudeEBemEstar,
    "Educação de Qualidade": TiposDeFiltros.educacaoDeQualidade,
    "Igualdade de Gênero": TiposDeFiltros.igualdadeDeGenero,
    "Água Potável e Saneamento": TiposDeFiltros.aguaPotavelESaneamento,
    "Energia Acessível e Limpa": TiposDeFiltros.energiaAcessivelELimpa,
    "Trabalho Decente e Crescimento Econômico": TiposDeFiltros.trabalhoDecenteECrescimentoEconomico,
    "Indústria, Inovação e Infraestrutura": TiposDeFiltros.industriaInovacaoEInfraestrutura,
    "Redução das Desigualdades": TiposDeFiltros.reducaoDasDesigualdades,
    "Cidades e Comunidades Sustentáveis": TiposDeFiltros.cidadesEComunidadesSustentaveis,
    "Consumo e Produção Responsáveis": TiposDeFiltros.consumoEProducaoResponsaveis,
    "Ação Contra a Mudança Global do Clima": TiposDeFiltros.acoesContraMudancaGlobalDoClima,
    "Vida na Água": TiposDeFiltros.vidaNaAgua,
    "Vida Terrestre": TiposDeFiltros.vidaTerrestre,
    "Paz, Justiça e Instituições Eficazes": TiposDeFiltros.pazJusticaEInstituicoesEficazes,
  };

  static TiposDeFiltros? getFiltro(String tema) {
    return _filtrosMap[tema];
  }
}