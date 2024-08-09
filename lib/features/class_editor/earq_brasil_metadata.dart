enum EarqBrasilMetadata {
  // Identification & Hierarchy
  nome('Nome da Classe'),
  codigo('Código da Classe'),
  subordinacao('Subordinação da Classe'),

  // Description
  abertura('Registro de Abertura'),
  desativacao('Registro de Desativação'),
  reativacao('Reativação da Classe'),
  mudancaNome('Registro de Mudança de Nome de Classe'),
  deslocamento('Registro de Deslocamento de Classe'),
  extincao('Registro de Extinção'),
  indicadorAtiva('Indicador de Classe Ativa/Inativa'),

  // Temporality
  prazoCorrente('Prazo de Guarda na Fase Corrente'),
  eventoCorrente(
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente'),
  prazoIntermediaria('Prazo de Guarda na Fase Intermediária'),
  eventoIntermediaria(
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária'),
  destinacao('Destinação Final'),
  alteracao('Registro de Alteração'),
  observacoes('Observações'),
  ;

  const EarqBrasilMetadata(this.key);
  final String key;
}
