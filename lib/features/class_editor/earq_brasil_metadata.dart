import '../../localization.dart';

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

  static Map<String, String> createKeyToLabelMap(AppLocalizations l10n) {
    return <String, String>{
      nome.key: l10n.earqBrasilNomeLabel,
      codigo.key: l10n.earqBrasilCodigoLabel,
      subordinacao.key: l10n.earqBrasilSubordinacaoLabel,
      abertura.key: l10n.earqBrasilAberturaLabel,
      desativacao.key: l10n.earqBrasilDesativacaoLabel,
      reativacao.key: l10n.earqBrasilReativacaoLabel,
      mudancaNome.key: l10n.earqBrasilMudancaNomeLabel,
      deslocamento.key: l10n.earqBrasilDeslocamentoLabel,
      extincao.key: l10n.earqBrasilExtincaoLabel,
      indicadorAtiva.key: l10n.earqBrasilIndicadorAtivaLabel,
      prazoCorrente.key: l10n.earqBrasilPrazoCorrenteLabel,
      eventoCorrente.key: l10n.earqBrasilEventoCorrenteLabel,
      prazoIntermediaria.key: l10n.earqBrasilPrazoIntermediariaLabel,
      eventoIntermediaria.key: l10n.earqBrasilEventoIntermediariaLabel,
      destinacao.key: l10n.earqBrasilDestinacaoLabel,
      alteracao.key: l10n.earqBrasilAlteracaoLabel,
      observacoes.key: l10n.earqBrasilObservacoesLabel,
    };
  }
}
