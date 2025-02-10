import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get actionCannotBeUndoneWarning => 'Essa ação não poderá ser desfeita';

  @override
  String get appTitle => 'El PCD';

  @override
  String get areYouSureDialogTitle => 'Tem certeza?';

  @override
  String get backupImportFailureText => 'Não foi possível realizar a importação';

  @override
  String get backupImportFormatExceptionText => 'Formato inválido';

  @override
  String get backupSectionTitle => 'Backup';

  @override
  String get backupSuccessfullyExportedSnackbarText => 'O arquivo exportado pode ser importado pelo ElPCD';

  @override
  String get backupSuccessfullyImportedSnackbarText => 'Backup importado com sucesso';

  @override
  String get cancelButtonText => 'Cancelar';

  @override
  String get confirmImportDialogContent => 'Os dados existentes serão perdidos.';

  @override
  String get csvExportFondsArchivistNote => 'Este Plano de Classificação de Documentos foi elaborado no Software [ElPCD](https://elpcd.github.io).';

  @override
  String get dashboardTabClassificationSchemeLabel => 'Plano de Classificação';

  @override
  String get dashboardTabTemporalityTableLabel => 'Tabela de Temporalidade';

  @override
  String get deleteButtonText => 'Apagar';

  @override
  String get earqBrasilAberturaDefinition => 'Registra a abertura de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.4)';

  @override
  String get earqBrasilAberturaLabel => 'Registro de Abertura';

  @override
  String get earqBrasilAlteracaoDefinition => 'Registrar informações tais como: data/hora da alteração, responsável, identificador da classe que teve prazo ou destinação alterada, descrição da alteração (incluindo o prazo/destinação anterior). (e-ARQ Brasil 3.2.7)';

  @override
  String get earqBrasilAlteracaoLabel => 'Registro de Alteração';

  @override
  String get earqBrasilCodigoDefinition => 'Divisão de um plano ou código de classificação, representada por um conjunto de símbolos, normalmente letras e/ou números convencionados. Refere-se às classes, subclasses, grupos e subgrupos. (e-ARQ Brasil 3.1.2)';

  @override
  String get earqBrasilCodigoLabel => 'Código';

  @override
  String get earqBrasilDesativacaoDefinition => 'Registra a desativação de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.5)';

  @override
  String get earqBrasilDesativacaoLabel => 'Registro de Desativação';

  @override
  String get earqBrasilDeslocamentoDefinition => 'Registra o deslocamento de uma classe na hierarquia do plano de classificação, ou seja, a mudança de subordinação. Registrar informações tais como: data/hora, responsável e subordinação anterior. (e-ARQ Brasil 3.1.8)';

  @override
  String get earqBrasilDeslocamentoLabel => 'Registro de Deslocamento';

  @override
  String get earqBrasilDestinacaoDefinition => 'Preservação ou eliminação. (e-ARQ Brasil 3.2.6)';

  @override
  String get earqBrasilDestinacaoLabel => 'Destinação Final';

  @override
  String get earqBrasilEventoCorrenteDefinition => '(e-ARQ Brasil 3.2.3)';

  @override
  String get earqBrasilEventoCorrenteLabel => 'Evento de Contagem na Idade Corrente';

  @override
  String get earqBrasilEventoIntermediariaDefinition => '(e-ARQ Brasil 3.2.5)';

  @override
  String get earqBrasilEventoIntermediariaLabel => 'Evento de Contagem na Idade Intermediária';

  @override
  String get earqBrasilExtincaoDefinition => 'Registra a extinção de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.9)';

  @override
  String get earqBrasilExtincaoLabel => 'Registro de Extinção';

  @override
  String get earqBrasilFormDescricaoSectionHeader => 'Descrição';

  @override
  String get earqBrasilFormTemporalidadeSectionHeader => 'Temporalidade';

  @override
  String get earqBrasilIndicadorAtivaDefinition => 'Registro de classes inativas. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.10)';

  @override
  String get earqBrasilIndicadorAtivaLabel => 'Indicador Ativa/Inativa';

  @override
  String get earqBrasilMudancaNomeDefinition => 'Registra a mudança de nome de uma classe. Registrar informações tais como: data/hora, responsável e nome anterior. (e-ARQ Brasil 3.1.7)';

  @override
  String get earqBrasilMudancaNomeLabel => 'Registro de Mudança de Nome';

  @override
  String get earqBrasilNomeDefinition => 'Divisão de um plano ou código de classificação. Refere-se às classes, subclasses, grupos e subgrupos. (e-ARQ Brasil 3.1.1)';

  @override
  String get earqBrasilNomeLabel => 'Nome';

  @override
  String get earqBrasilObservacoesDefinition => 'Informações complementares tais como: previsão de conversão de suporte, legislação relativa à justificativa de prazos. (e-ARQ Brasil 3.2.8)';

  @override
  String get earqBrasilObservacoesLabel => 'Observações';

  @override
  String get earqBrasilPrazoCorrenteDefinition => '(e-ARQ Brasil 3.2.2)';

  @override
  String get earqBrasilPrazoCorrenteLabel => 'Prazo na Idade Corrente';

  @override
  String get earqBrasilPrazoIntermediariaDefinition => '(e-ARQ Brasil 3.2.4)';

  @override
  String get earqBrasilPrazoIntermediariaLabel => 'Prazo na Idade Intermediária';

  @override
  String get earqBrasilReativacaoDefinition => 'Registro de reativação da classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.6)';

  @override
  String get earqBrasilReativacaoLabel => 'Registro de Reativação';

  @override
  String get earqBrasilSubordinacaoDefinition => 'Registra a subordinação da classe na hierarquia do plano. (e-ARQ Brasil 3.1.3)';

  @override
  String get earqBrasilSubordinacaoLabel => 'Subordinação';

  @override
  String get emptyClassesExplorerBodyText => 'Crie uma Classe para começar';

  @override
  String get exportAtomIsadCsvButtonText => 'Exportar CSV modelo AtoM ISAD(G)';

  @override
  String get exportBackupButtonText => 'Exportar Backup';

  @override
  String get importBackupButtonText => 'Importar Backup';

  @override
  String get importButtonText => 'Importar';

  @override
  String get institutionCodeTitle => 'CODEARQ';

  @override
  String get newClassButtonText => 'Nova Classe';

  @override
  String get newSubordinateClassButtonText => 'Nova Classe Subordinada';

  @override
  String get opdsBlogButtonText => 'Observatório da Preservação Digital Sistêmica';

  @override
  String get saveButtonText => 'Salvar';

  @override
  String get searchClassesButtonText => 'Buscar Classes';

  @override
  String get sourceCodeButtonText => 'Código Fonte';

  @override
  String get temporalityTableHeaderClassification => 'Classificação';

  @override
  String get temporalityTableHeaderCurrentAge => 'Idade Corrente';

  @override
  String get temporalityTableHeaderDisposal => 'Destinação';

  @override
  String get temporalityTableHeaderIntermediateAge => 'Idade Intermediária';

  @override
  String get temporalityTableHeaderNotes => 'Observações';

  @override
  String get temporalityTableHeaderRententionPeriod => 'Prazo de Guarda';

  @override
  String get themeModeButtonText => 'Tema';

  @override
  String get unableToSaveClassSnackbarText => 'Não foi possível salvar a Classe';

  @override
  String get unnamedClass => 'Classe sem nome';
}
