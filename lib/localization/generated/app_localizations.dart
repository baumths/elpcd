import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @actionCannotBeUndoneWarning.
  ///
  /// In pt, this message translates to:
  /// **'Essa ação não poderá ser desfeita'**
  String get actionCannotBeUndoneWarning;

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'El PCD'**
  String get appTitle;

  /// No description provided for @areYouSureDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza?'**
  String get areYouSureDialogTitle;

  /// No description provided for @backupImportFailureText.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível realizar a importação'**
  String get backupImportFailureText;

  /// No description provided for @backupImportFormatExceptionText.
  ///
  /// In pt, this message translates to:
  /// **'Formato inválido'**
  String get backupImportFormatExceptionText;

  /// No description provided for @backupSectionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Backup'**
  String get backupSectionTitle;

  /// No description provided for @backupSuccessfullyExportedSnackbarText.
  ///
  /// In pt, this message translates to:
  /// **'O arquivo exportado pode ser importado pelo ElPCD'**
  String get backupSuccessfullyExportedSnackbarText;

  /// No description provided for @backupSuccessfullyImportedSnackbarText.
  ///
  /// In pt, this message translates to:
  /// **'Backup importado com sucesso'**
  String get backupSuccessfullyImportedSnackbarText;

  /// No description provided for @cancelButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancelButtonText;

  /// No description provided for @confirmImportDialogContent.
  ///
  /// In pt, this message translates to:
  /// **'Os dados existentes serão perdidos.'**
  String get confirmImportDialogContent;

  /// No description provided for @csvExportFondsArchivistNote.
  ///
  /// In pt, this message translates to:
  /// **'Este Plano de Classificação de Documentos foi elaborado no Software [ElPCD](https://elpcd.github.io).'**
  String get csvExportFondsArchivistNote;

  /// No description provided for @dashboardTabClassificationSchemeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Plano de Classificação'**
  String get dashboardTabClassificationSchemeLabel;

  /// No description provided for @dashboardTabTemporalityTableLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tabela de Temporalidade'**
  String get dashboardTabTemporalityTableLabel;

  /// No description provided for @deleteButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Apagar'**
  String get deleteButtonText;

  /// No description provided for @earqBrasilAberturaDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra a abertura de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.4)'**
  String get earqBrasilAberturaDefinition;

  /// No description provided for @earqBrasilAberturaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Abertura'**
  String get earqBrasilAberturaLabel;

  /// No description provided for @earqBrasilAlteracaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registrar informações tais como: data/hora da alteração, responsável, identificador da classe que teve prazo ou destinação alterada, descrição da alteração (incluindo o prazo/destinação anterior). (e-ARQ Brasil 3.2.7)'**
  String get earqBrasilAlteracaoDefinition;

  /// No description provided for @earqBrasilAlteracaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Alteração'**
  String get earqBrasilAlteracaoLabel;

  /// No description provided for @earqBrasilCodigoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Divisão de um plano ou código de classificação, representada por um conjunto de símbolos, normalmente letras e/ou números convencionados. Refere-se às classes, subclasses, grupos e subgrupos. (e-ARQ Brasil 3.1.2)'**
  String get earqBrasilCodigoDefinition;

  /// No description provided for @earqBrasilCodigoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Código'**
  String get earqBrasilCodigoLabel;

  /// No description provided for @earqBrasilDesativacaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra a desativação de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.5)'**
  String get earqBrasilDesativacaoDefinition;

  /// No description provided for @earqBrasilDesativacaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Desativação'**
  String get earqBrasilDesativacaoLabel;

  /// No description provided for @earqBrasilDeslocamentoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra o deslocamento de uma classe na hierarquia do plano de classificação, ou seja, a mudança de subordinação. Registrar informações tais como: data/hora, responsável e subordinação anterior. (e-ARQ Brasil 3.1.8)'**
  String get earqBrasilDeslocamentoDefinition;

  /// No description provided for @earqBrasilDeslocamentoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Deslocamento'**
  String get earqBrasilDeslocamentoLabel;

  /// No description provided for @earqBrasilDestinacaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Preservação ou eliminação. (e-ARQ Brasil 3.2.6)'**
  String get earqBrasilDestinacaoDefinition;

  /// No description provided for @earqBrasilDestinacaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Destinação Final'**
  String get earqBrasilDestinacaoLabel;

  /// No description provided for @earqBrasilEventoCorrenteDefinition.
  ///
  /// In pt, this message translates to:
  /// **'(e-ARQ Brasil 3.2.3)'**
  String get earqBrasilEventoCorrenteDefinition;

  /// No description provided for @earqBrasilEventoCorrenteLabel.
  ///
  /// In pt, this message translates to:
  /// **'Evento de Contagem na Idade Corrente'**
  String get earqBrasilEventoCorrenteLabel;

  /// No description provided for @earqBrasilEventoIntermediariaDefinition.
  ///
  /// In pt, this message translates to:
  /// **'(e-ARQ Brasil 3.2.5)'**
  String get earqBrasilEventoIntermediariaDefinition;

  /// No description provided for @earqBrasilEventoIntermediariaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Evento de Contagem na Idade Intermediária'**
  String get earqBrasilEventoIntermediariaLabel;

  /// No description provided for @earqBrasilExtincaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra a extinção de uma classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.9)'**
  String get earqBrasilExtincaoDefinition;

  /// No description provided for @earqBrasilExtincaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Extinção'**
  String get earqBrasilExtincaoLabel;

  /// No description provided for @earqBrasilFormDescricaoSectionHeader.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get earqBrasilFormDescricaoSectionHeader;

  /// No description provided for @earqBrasilFormTemporalidadeSectionHeader.
  ///
  /// In pt, this message translates to:
  /// **'Temporalidade'**
  String get earqBrasilFormTemporalidadeSectionHeader;

  /// No description provided for @earqBrasilIndicadorAtivaDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registro de classes inativas. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.10)'**
  String get earqBrasilIndicadorAtivaDefinition;

  /// No description provided for @earqBrasilIndicadorAtivaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Indicador Ativa/Inativa'**
  String get earqBrasilIndicadorAtivaLabel;

  /// No description provided for @earqBrasilMudancaNomeDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra a mudança de nome de uma classe. Registrar informações tais como: data/hora, responsável e nome anterior. (e-ARQ Brasil 3.1.7)'**
  String get earqBrasilMudancaNomeDefinition;

  /// No description provided for @earqBrasilMudancaNomeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Mudança de Nome'**
  String get earqBrasilMudancaNomeLabel;

  /// No description provided for @earqBrasilNomeDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Divisão de um plano ou código de classificação. Refere-se às classes, subclasses, grupos e subgrupos. (e-ARQ Brasil 3.1.1)'**
  String get earqBrasilNomeDefinition;

  /// No description provided for @earqBrasilNomeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get earqBrasilNomeLabel;

  /// No description provided for @earqBrasilObservacoesDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Informações complementares tais como: previsão de conversão de suporte, legislação relativa à justificativa de prazos. (e-ARQ Brasil 3.2.8)'**
  String get earqBrasilObservacoesDefinition;

  /// No description provided for @earqBrasilObservacoesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Observações'**
  String get earqBrasilObservacoesLabel;

  /// No description provided for @earqBrasilPrazoCorrenteDefinition.
  ///
  /// In pt, this message translates to:
  /// **'(e-ARQ Brasil 3.2.2)'**
  String get earqBrasilPrazoCorrenteDefinition;

  /// No description provided for @earqBrasilPrazoCorrenteLabel.
  ///
  /// In pt, this message translates to:
  /// **'Prazo na Idade Corrente'**
  String get earqBrasilPrazoCorrenteLabel;

  /// No description provided for @earqBrasilPrazoIntermediariaDefinition.
  ///
  /// In pt, this message translates to:
  /// **'(e-ARQ Brasil 3.2.4)'**
  String get earqBrasilPrazoIntermediariaDefinition;

  /// No description provided for @earqBrasilPrazoIntermediariaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Prazo na Idade Intermediária'**
  String get earqBrasilPrazoIntermediariaLabel;

  /// No description provided for @earqBrasilReativacaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registro de reativação da classe. Registrar informações tais como: data/hora e responsável. (e-ARQ Brasil 3.1.6)'**
  String get earqBrasilReativacaoDefinition;

  /// No description provided for @earqBrasilReativacaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Registro de Reativação'**
  String get earqBrasilReativacaoLabel;

  /// No description provided for @earqBrasilSubordinacaoDefinition.
  ///
  /// In pt, this message translates to:
  /// **'Registra a subordinação da classe na hierarquia do plano. (e-ARQ Brasil 3.1.3)'**
  String get earqBrasilSubordinacaoDefinition;

  /// No description provided for @earqBrasilSubordinacaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Subordinação'**
  String get earqBrasilSubordinacaoLabel;

  /// No description provided for @emptyClassesExplorerBodyText.
  ///
  /// In pt, this message translates to:
  /// **'Crie uma Classe para começar'**
  String get emptyClassesExplorerBodyText;

  /// No description provided for @exportAtomIsadCsvButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Exportar CSV modelo AtoM ISAD(G)'**
  String get exportAtomIsadCsvButtonText;

  /// No description provided for @exportBackupButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Exportar Backup'**
  String get exportBackupButtonText;

  /// No description provided for @importBackupButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Importar Backup'**
  String get importBackupButtonText;

  /// No description provided for @importButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Importar'**
  String get importButtonText;

  /// No description provided for @institutionCodeTitle.
  ///
  /// In pt, this message translates to:
  /// **'CODEARQ'**
  String get institutionCodeTitle;

  /// No description provided for @newClassButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Nova Classe'**
  String get newClassButtonText;

  /// No description provided for @newSubordinateClassButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Nova Classe Subordinada'**
  String get newSubordinateClassButtonText;

  /// No description provided for @opdsBlogButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Observatório da Preservação Digital Sistêmica'**
  String get opdsBlogButtonText;

  /// No description provided for @saveButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get saveButtonText;

  /// No description provided for @searchClassesButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Buscar Classes'**
  String get searchClassesButtonText;

  /// No description provided for @sourceCodeButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Código Fonte'**
  String get sourceCodeButtonText;

  /// No description provided for @temporalityTableHeaderClassification.
  ///
  /// In pt, this message translates to:
  /// **'Classificação'**
  String get temporalityTableHeaderClassification;

  /// No description provided for @temporalityTableHeaderCurrentAge.
  ///
  /// In pt, this message translates to:
  /// **'Idade Corrente'**
  String get temporalityTableHeaderCurrentAge;

  /// No description provided for @temporalityTableHeaderDisposal.
  ///
  /// In pt, this message translates to:
  /// **'Destinação'**
  String get temporalityTableHeaderDisposal;

  /// No description provided for @temporalityTableHeaderIntermediateAge.
  ///
  /// In pt, this message translates to:
  /// **'Idade Intermediária'**
  String get temporalityTableHeaderIntermediateAge;

  /// No description provided for @temporalityTableHeaderNotes.
  ///
  /// In pt, this message translates to:
  /// **'Observações'**
  String get temporalityTableHeaderNotes;

  /// No description provided for @temporalityTableHeaderRententionPeriod.
  ///
  /// In pt, this message translates to:
  /// **'Prazo de Guarda'**
  String get temporalityTableHeaderRententionPeriod;

  /// No description provided for @themeModeButtonText.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get themeModeButtonText;

  /// No description provided for @unableToSaveClassSnackbarText.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível salvar a Classe'**
  String get unableToSaveClassSnackbarText;

  /// No description provided for @unnamedClass.
  ///
  /// In pt, this message translates to:
  /// **'Classe sem nome'**
  String get unnamedClass;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
