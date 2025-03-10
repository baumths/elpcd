// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get actionCannotBeUndoneWarning => 'Esta acción no podrá ser deshecha';

  @override
  String get appTitle => 'ElPCD';

  @override
  String get areYouSureDialogTitle => '¿Está seguro?';

  @override
  String get backupImportFailureText => 'No fue posible realizar la importación';

  @override
  String get backupImportFormatExceptionText => 'Formato inválido';

  @override
  String get backupSectionTitle => 'Backup';

  @override
  String get backupSuccessfullyExportedSnackbarText => 'El archivo exportado podrá ser importado por ElPCD';

  @override
  String get backupSuccessfullyImportedSnackbarText => 'Backup importado con éxito';

  @override
  String get cancelButtonText => 'Cancelar';

  @override
  String get confirmImportDialogContent => 'Los datos existentes se perderán.';

  @override
  String get csvExportFondsArchivistNote => 'Este Quadro de Clasificación Documental fue creado en el software [ElPCD](https://elpcd.github.io).';

  @override
  String get dashboardTabClassificationSchemeLabel => 'Cuadro de Clasificación';

  @override
  String get dashboardTabTemporalityTableLabel => 'Tabla de Retención y Disposición';

  @override
  String get deleteButtonText => 'Borrar';

  @override
  String get earqBrasilAberturaDefinition => 'Registra la apertura de una clase. Registra datos tales como: fecha/hora y responsable. (e-ARQ Brasil 3.1.4)';

  @override
  String get earqBrasilAberturaLabel => 'Registro de Apertura';

  @override
  String get earqBrasilAlteracaoDefinition => 'Registra datos tales como: fecha/hora de la alteración, responsable, identificador de clase que tubo plazo o disposición alterada, descripción de la alteración (incluye el plazo/disposición anterior). (e-ARQ Brasil 3.2.7)';

  @override
  String get earqBrasilAlteracaoLabel => 'Registro de Alteración';

  @override
  String get earqBrasilCodigoDefinition => 'División de un cuadro de clasificación, representado por un conjunto de símbolos, normalmente letras y/o números convencionados. Se refere a las clases, subclases, grupos y subgrupos. (e-ARQ Brasil 3.1.2)';

  @override
  String get earqBrasilCodigoLabel => 'Código';

  @override
  String get earqBrasilDesativacaoDefinition => 'Registra la desactivación de una clase. Registra datos tales como: fecha/hora y responsable. (e-ARQ Brasil 3.1.5)';

  @override
  String get earqBrasilDesativacaoLabel => 'Registro de Desactivación';

  @override
  String get earqBrasilDeslocamentoDefinition => 'Registra el desplazamiento de una clase en la jerarquia de un cuadro de clasificación, o sea, los cambios de subordinación. Registra datos tales como: fecha/hora, responsable y subordiación previa. (e-ARQ Brasil 3.1.8)';

  @override
  String get earqBrasilDeslocamentoLabel => 'Registro de Desplazamiento';

  @override
  String get earqBrasilDestinacaoDefinition => 'Preservación o Destrucción. (e-ARQ Brasil 3.2.6)';

  @override
  String get earqBrasilDestinacaoLabel => 'Disposición Final';

  @override
  String get earqBrasilEventoCorrenteDefinition => '(e-ARQ Brasil 3.2.3)';

  @override
  String get earqBrasilEventoCorrenteLabel => 'Evento de Cómputo en la Fase de Gestión';

  @override
  String get earqBrasilEventoIntermediariaDefinition => '(e-ARQ Brasil 3.2.5)';

  @override
  String get earqBrasilEventoIntermediariaLabel => 'Evento de Cómputo en la Fase Intermedia';

  @override
  String get earqBrasilExtincaoDefinition => 'Registra la eliminación de una clase. Registra datos tales como: fecha/hora y responsable. (e-ARQ Brasil 3.1.9)';

  @override
  String get earqBrasilExtincaoLabel => 'Registro de Eliminación';

  @override
  String get earqBrasilFormDescricaoSectionHeader => 'Descripción';

  @override
  String get earqBrasilFormTemporalidadeSectionHeader => 'Temporalidad';

  @override
  String get earqBrasilIndicadorAtivaDefinition => 'Registro de clases inactivas. Registra datos tales como: fecha/hora y responsable. (e-ARQ Brasil 3.1.10)';

  @override
  String get earqBrasilIndicadorAtivaLabel => 'Indicador Activa/Inactiva';

  @override
  String get earqBrasilMudancaNomeDefinition => 'Registra el cambio de nombre de una clase. Registra datos tales como: fecha/hora, responsable y nombre anterior. (e-ARQ Brasil 3.1.7)';

  @override
  String get earqBrasilMudancaNomeLabel => 'Registro de Cambio de Nombre';

  @override
  String get earqBrasilNomeDefinition => 'División de un cuadro de clasificación. Se refere a las clases, subclases, grupos y subgrupos. (e-ARQ Brasil 3.1.1)';

  @override
  String get earqBrasilNomeLabel => 'Nombre';

  @override
  String get earqBrasilObservacoesDefinition => 'Datos complementares tales como: previsión de conversión de soporte, legislación relacionada a la justificativa de plazos. (e-ARQ Brasil 3.2.8)';

  @override
  String get earqBrasilObservacoesLabel => 'Observaciones';

  @override
  String get earqBrasilPrazoCorrenteDefinition => '(e-ARQ Brasil 3.2.2)';

  @override
  String get earqBrasilPrazoCorrenteLabel => 'Plazo en la Fase de Gestión';

  @override
  String get earqBrasilPrazoIntermediariaDefinition => '(e-ARQ Brasil 3.2.4)';

  @override
  String get earqBrasilPrazoIntermediariaLabel => 'Plazo en la Fase Intermedia';

  @override
  String get earqBrasilReativacaoDefinition => 'Registro de reactivación de clase. Registra datos tales como: fecha/hora y responsable. (e-ARQ Brasil 3.1.6)';

  @override
  String get earqBrasilReativacaoLabel => 'Registro de Reactivación';

  @override
  String get earqBrasilSubordinacaoDefinition => 'Registra la subordinación de clase en la jerarquia del cuadro de clasificación. (e-ARQ Brasil 3.1.3)';

  @override
  String get earqBrasilSubordinacaoLabel => 'Subordinación';

  @override
  String get emptyClassesExplorerBodyText => 'Empieza por crear una Nueva Clase';

  @override
  String get exportAtomIsadCsvButtonText => 'Exportar CSV modelo AtoM ISAD(G)';

  @override
  String get exportBackupButtonText => 'Exportar Backup';

  @override
  String get importBackupButtonText => 'Importar Backup';

  @override
  String get importButtonText => 'Importar';

  @override
  String get institutionCodeTitle => 'Código Custodiante';

  @override
  String get newClassButtonText => 'Nueva Clase';

  @override
  String get newSubordinateClassButtonText => 'Nueva Clase Subordinada';

  @override
  String get opdsBlogButtonText => 'Observatorio de la Preservación Digital Sistémica';

  @override
  String get saveButtonText => 'Guardar';

  @override
  String get searchClassesButtonText => 'Buscar Clases';

  @override
  String get sourceCodeButtonText => 'Código Fuente';

  @override
  String get temporalityTableHeaderClassification => 'Clasificación';

  @override
  String get temporalityTableHeaderCurrentAge => 'Fase de Gestión';

  @override
  String get temporalityTableHeaderDisposal => 'Destinación';

  @override
  String get temporalityTableHeaderIntermediateAge => 'Fase Intermedia';

  @override
  String get temporalityTableHeaderNotes => 'Observaciones';

  @override
  String get temporalityTableHeaderRententionPeriod => 'Plazo de Guarda';

  @override
  String get themeModeButtonText => 'Tema';

  @override
  String get unableToSaveClassSnackbarText => 'No fue posible guardar la Clase';

  @override
  String get unnamedClass => 'Clase sin nombre';
}
