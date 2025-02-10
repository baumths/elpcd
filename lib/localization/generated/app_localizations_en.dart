import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get actionCannotBeUndoneWarning => 'This action cannot be undone';

  @override
  String get appTitle => 'ElPCD';

  @override
  String get areYouSureDialogTitle => 'Are you sure?';

  @override
  String get backupImportFailureText => 'Import failed';

  @override
  String get backupImportFormatExceptionText => 'Invalid Format';

  @override
  String get backupSectionTitle => 'Backup';

  @override
  String get backupSuccessfullyExportedSnackbarText => 'The exported file can be imported by ElPCD';

  @override
  String get backupSuccessfullyImportedSnackbarText => 'Backup imported successfully';

  @override
  String get cancelButtonText => 'Cancel';

  @override
  String get confirmImportDialogContent => 'Existing data will be lost.';

  @override
  String get csvExportFondsArchivistNote => 'This Classification Scheme was created using the [ElPCD](https://elpcd.github.io) software.';

  @override
  String get dashboardTabClassificationSchemeLabel => 'Classification Scheme';

  @override
  String get dashboardTabTemporalityTableLabel => 'Retention and Disposal Table';

  @override
  String get deleteButtonText => 'Delete';

  @override
  String get earqBrasilAberturaDefinition => 'Registers the opening of a class. Register informations such as: date/time and responsible. (e-ARQ Brasil 3.1.4)';

  @override
  String get earqBrasilAberturaLabel => 'Opening Registry';

  @override
  String get earqBrasilAlteracaoDefinition => 'Register informations such as: date/time of the change, responsible, the identifier of the class that had its retention periods or disposal changed, a description of the changes (including the previous retention period/disposal). (e-ARQ Brasil 3.2.7)';

  @override
  String get earqBrasilAlteracaoLabel => 'Changes Registry';

  @override
  String get earqBrasilCodigoDefinition => 'The division of a classification scheme/code, represented by a set of symbols, usually letters and/or numbers by convention. Refers to the classes, subclasses, groups and subgroups. (e-ARQ Brasil 3.1.2)';

  @override
  String get earqBrasilCodigoLabel => 'Code';

  @override
  String get earqBrasilDesativacaoDefinition => 'Registers the deactivation of a class. Register informations such as: date/time and responsible. (e-ARQ Brasil 3.1.5)';

  @override
  String get earqBrasilDesativacaoLabel => 'Deactivation Registry';

  @override
  String get earqBrasilDeslocamentoDefinition => 'Registers the displacement of a class in the classification scheme hierarchy, that is, the shift of subordination. Register informations such as: date/time, responsible and the previous subordination. (e-ARQ Brasil 3.1.8)';

  @override
  String get earqBrasilDeslocamentoLabel => 'Displacement Registry';

  @override
  String get earqBrasilDestinacaoDefinition => 'Preservation or elimination. (e-ARQ Brasil 3.2.6)';

  @override
  String get earqBrasilDestinacaoLabel => 'Final Disposal';

  @override
  String get earqBrasilEventoCorrenteDefinition => '(e-ARQ Brasil 3.2.3)';

  @override
  String get earqBrasilEventoCorrenteLabel => 'Current Age Counting Event';

  @override
  String get earqBrasilEventoIntermediariaDefinition => '(e-ARQ Brasil 3.2.5)';

  @override
  String get earqBrasilEventoIntermediariaLabel => 'Intermediate Age Counting Event';

  @override
  String get earqBrasilExtincaoDefinition => 'Registers the extinction of a class. Register informations such as: date/time and responsible. (e-ARQ Brasil 3.1.9)';

  @override
  String get earqBrasilExtincaoLabel => 'Extinction Registry';

  @override
  String get earqBrasilFormDescricaoSectionHeader => 'Description';

  @override
  String get earqBrasilFormTemporalidadeSectionHeader => 'Retention';

  @override
  String get earqBrasilIndicadorAtivaDefinition => 'Inactive classes registry. Register informations such as: date/time and responsible. (e-ARQ Brasil 3.1.10)';

  @override
  String get earqBrasilIndicadorAtivaLabel => 'Active/Inactive Indicator';

  @override
  String get earqBrasilMudancaNomeDefinition => 'Registers changes to the name of the class. Register informations such as: date/time, responsible and the previous name. (e-ARQ Brasil 3.1.7)';

  @override
  String get earqBrasilMudancaNomeLabel => 'Name Changes Registry';

  @override
  String get earqBrasilNomeDefinition => 'The division of a classification scheme/code. Refers to the classes, subclasses, groups and subgroups. (e-ARQ Brasil 3.1.1)';

  @override
  String get earqBrasilNomeLabel => 'Name';

  @override
  String get earqBrasilObservacoesDefinition => 'Additional information such as: support conversion forecast, retention periods justificative legislation. (e-ARQ Brasil 3.2.8)';

  @override
  String get earqBrasilObservacoesLabel => 'Notes';

  @override
  String get earqBrasilPrazoCorrenteDefinition => '(e-ARQ Brasil 3.2.2)';

  @override
  String get earqBrasilPrazoCorrenteLabel => 'Current Age Retention Period';

  @override
  String get earqBrasilPrazoIntermediariaDefinition => '(e-ARQ Brasil 3.2.4)';

  @override
  String get earqBrasilPrazoIntermediariaLabel => 'Intermediate Age Retention Period';

  @override
  String get earqBrasilReativacaoDefinition => 'Class reactivation registry. Registers informations such as: date/time and responsible. (e-ARQ Brasil 3.1.6)';

  @override
  String get earqBrasilReativacaoLabel => 'Reactivation Registry';

  @override
  String get earqBrasilSubordinacaoDefinition => 'Registers the subordination of a class in the scheme hierarchy. (e-ARQ Brasil 3.1.3)';

  @override
  String get earqBrasilSubordinacaoLabel => 'Subordination';

  @override
  String get emptyClassesExplorerBodyText => 'Start by creating a New Class';

  @override
  String get exportAtomIsadCsvButtonText => 'Export CSV AtoM ISAD(G) template';

  @override
  String get exportBackupButtonText => 'Export a Backup';

  @override
  String get importBackupButtonText => 'Import a Backup';

  @override
  String get importButtonText => 'Import';

  @override
  String get institutionCodeTitle => 'Institution Code';

  @override
  String get newClassButtonText => 'New Class';

  @override
  String get newSubordinateClassButtonText => 'New Subordinate Class';

  @override
  String get opdsBlogButtonText => 'Active Digital Preservation Observatory';

  @override
  String get saveButtonText => 'Save';

  @override
  String get searchClassesButtonText => 'Search Classes';

  @override
  String get sourceCodeButtonText => 'Source Code';

  @override
  String get temporalityTableHeaderClassification => 'Classification';

  @override
  String get temporalityTableHeaderCurrentAge => 'Current Age';

  @override
  String get temporalityTableHeaderDisposal => 'Disposal';

  @override
  String get temporalityTableHeaderIntermediateAge => 'Intermediate Age';

  @override
  String get temporalityTableHeaderNotes => 'Notes';

  @override
  String get temporalityTableHeaderRententionPeriod => 'Retention Period';

  @override
  String get themeModeButtonText => 'Theme';

  @override
  String get unableToSaveClassSnackbarText => 'Unable to save the Class';

  @override
  String get unnamedClass => 'Unnamed Class';
}
