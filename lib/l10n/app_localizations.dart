import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
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
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr'),
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Nom de l'application affiché dans le titre de la fenêtre/tâche.
  ///
  /// In fr, this message translates to:
  /// **'Ecclésias360'**
  String get appTitle;

  /// Message d'accueil de l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue sur Ecclésias360'**
  String get homeWelcome;

  /// Titre de la boîte de dialogue d'ajout d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une décision'**
  String get comiteAjouterDecisionTitre;

  /// Bouton d'ajout d'un erratum.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un erratum'**
  String get comiteAjouterErratumBouton;

  /// Bouton d'ajout d'une tâche de suivi.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une tâche'**
  String get comiteAjouterTacheBouton;

  /// Titre de la boîte de dialogue d'ajout d'une tâche de suivi.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une tâche de suivi'**
  String get comiteAjouterTacheTitre;

  /// État vide de la liste des membres du comité.
  ///
  /// In fr, this message translates to:
  /// **'Aucun membre nommé.'**
  String get comiteAucunMembre;

  /// État vide de la liste des décisions d'une séance.
  ///
  /// In fr, this message translates to:
  /// **'Aucune décision.'**
  String get comiteAucuneDecision;

  /// État vide de la liste des séances.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séance enregistrée.'**
  String get comiteAucuneSeance;

  /// Bouton de confirmation de nomination.
  ///
  /// In fr, this message translates to:
  /// **'Nommer'**
  String get comiteBoutonNommer;

  /// Libellé du champ assignation d'une tâche.
  ///
  /// In fr, this message translates to:
  /// **'Assignée à'**
  String get comiteChampAssigneA;

  /// Libellé du champ brouillon d'un procès-verbal.
  ///
  /// In fr, this message translates to:
  /// **'Brouillon du procès-verbal'**
  String get comiteChampBrouillonPv;

  /// Libellé du champ date d'une séance.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get comiteChampDate;

  /// Libellé du champ fonction d'un membre du comité.
  ///
  /// In fr, this message translates to:
  /// **'Fonction (ex. Pasteur, Diacre)'**
  String get comiteChampFonction;

  /// Libellé du champ libellé d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Libellé'**
  String get comiteChampLibelle;

  /// Libellé du champ nouvel erratum.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel erratum'**
  String get comiteChampNouvelErratum;

  /// Libellé du champ ordre du jour.
  ///
  /// In fr, this message translates to:
  /// **'Ordre du jour'**
  String get comiteChampOrdreDuJour;

  /// Libellé de la case à cocher portée disciplinaire d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Portée disciplinaire (Module X)'**
  String get comiteChampPorteeDisciplinaire;

  /// Libellé du champ résultat du vote d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Résultat du vote (ex. 5 pour, 1 contre)'**
  String get comiteChampResultatVote;

  /// Infobulle du bouton de clôture d'un mandat.
  ///
  /// In fr, this message translates to:
  /// **'Clore le mandat'**
  String get comiteCloreMandatTooltip;

  /// Titre de la section des décisions d'une séance.
  ///
  /// In fr, this message translates to:
  /// **'Décisions'**
  String get comiteDecisionsTitre;

  /// Bouton d'enregistrement du brouillon d'un procès-verbal.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer le brouillon'**
  String get comiteEnregistrerBrouillon;

  /// Bouton d'enregistrement d'une nouvelle séance.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer la séance'**
  String get comiteEnregistrerSeance;

  /// Titre de la section des erratums d'un procès-verbal.
  ///
  /// In fr, this message translates to:
  /// **'Erratums'**
  String get comiteErratumsTitre;

  /// Sous-titre d'un membre du comité en mandat actif, avec sa fonction et la date de début.
  ///
  /// In fr, this message translates to:
  /// **'{fonction} — depuis le {date}'**
  String comiteMembreActif(String fonction, String date);

  /// Sous-titre d'un membre du comité dont le mandat est clos.
  ///
  /// In fr, this message translates to:
  /// **'{fonction} (mandat clos)'**
  String comiteMembreClos(String fonction);

  /// Titre de l'écran des membres du comité.
  ///
  /// In fr, this message translates to:
  /// **'Membres du comité'**
  String get comiteMembresTitre;

  /// Titre de la boîte de dialogue de nomination d'un membre du comité.
  ///
  /// In fr, this message translates to:
  /// **'Nommer un membre du comité'**
  String get comiteNommerMembreTitre;

  /// Infobulle du bouton flottant de nomination d'un membre.
  ///
  /// In fr, this message translates to:
  /// **'Nommer un membre'**
  String get comiteNommerMembreTooltip;

  /// Action de création d'une nouvelle séance (infobulle et titre d'écran).
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle séance'**
  String get comiteNouvelleSeanceTitre;

  /// Titre de la section des présents à une séance.
  ///
  /// In fr, this message translates to:
  /// **'Présents'**
  String get comitePresentsTitre;

  /// Titre de la section procès-verbal d'une séance.
  ///
  /// In fr, this message translates to:
  /// **'Procès-verbal'**
  String get comiteProcesVerbalTitre;

  /// Note indiquant qu'un procès-verbal est validé et immuable.
  ///
  /// In fr, this message translates to:
  /// **'Ce procès-verbal est validé et immuable.'**
  String get comitePvValideEtImmuable;

  /// Étiquette de quorum atteint pour une séance.
  ///
  /// In fr, this message translates to:
  /// **'Quorum atteint'**
  String get comiteQuorumAtteint;

  /// Étiquette de quorum non atteint pour une séance.
  ///
  /// In fr, this message translates to:
  /// **'Quorum non atteint'**
  String get comiteQuorumNonAtteint;

  /// Étiquette de quorum non configuré pour une séance.
  ///
  /// In fr, this message translates to:
  /// **'Quorum non configuré'**
  String get comiteQuorumNonConfigure;

  /// Corps du message quand la séance demandée n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Cette séance n'existe pas (ou plus).'**
  String get comiteSeanceIntrouvableCorps;

  /// Titre de l'écran de détail d'une séance.
  ///
  /// In fr, this message translates to:
  /// **'Séance'**
  String get comiteSeanceTitre;

  /// Titre de l'écran des séances du comité.
  ///
  /// In fr, this message translates to:
  /// **'Séances du comité'**
  String get comiteSeancesTitre;

  /// Titre de la section des tâches de suivi d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Tâches de suivi'**
  String get comiteTachesDeSuiviTitre;

  /// Bouton de validation (immuable) d'un procès-verbal.
  ///
  /// In fr, this message translates to:
  /// **'Valider (immuable)'**
  String get comiteValiderPv;

  /// Bouton Ajouter, commun aux boîtes de dialogue.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get commonAjouter;

  /// Bouton Annuler, commun aux boîtes de dialogue.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonAnnuler;

  /// Bouton Créer, commun aux formulaires de création.
  ///
  /// In fr, this message translates to:
  /// **'Créer'**
  String get commonCreer;

  /// Libellé de champ Description, commun aux formulaires.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get commonDescription;

  /// Bouton Enregistrer, commun aux formulaires.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get commonEnregistrer;

  /// Libellé de champ désignant un fidèle (ex. sélecteur).
  ///
  /// In fr, this message translates to:
  /// **'Fidèle'**
  String get commonFidele;

  /// Valeur affichée pour un champ booléen vrai.
  ///
  /// In fr, this message translates to:
  /// **'oui'**
  String get commonOui;

  /// Titre de la section des tuiles de modules sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Modules'**
  String get dashboardModulesTitre;

  /// Bouton d'archivage d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Archiver (RG-II-08)'**
  String get fideleActionArchiver;

  /// Bouton d'accès aux compétences professionnelles d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Compétences professionnelles'**
  String get fideleActionCompetences;

  /// Bouton d'accès aux dons spirituels d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Dons spirituels'**
  String get fideleActionDons;

  /// Bouton d'accès aux groupes de l'Église d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Groupes de l'Église'**
  String get fideleActionGroupes;

  /// Bouton d'ajout d'un lien familial dans la liste.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un lien'**
  String get fideleAjouterLienBouton;

  /// Titre de la boîte de dialogue d'ajout d'un lien familial.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un lien familial'**
  String get fideleAjouterLienTitre;

  /// Bouton d'ajout d'un tuteur dans la liste.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un tuteur'**
  String get fideleAjouterTuteurBouton;

  /// Titre de la boîte de dialogue d'ajout d'un tuteur tiers.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un tuteur (tiers)'**
  String get fideleAjouterTuteurTitre;

  /// Libellé du champ adresse.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get fideleChampAdresse;

  /// Libellé du champ date de naissance (valeur non renseignée).
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance'**
  String get fideleChampDateNaissance;

  /// Libellé du champ email.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get fideleChampEmail;

  /// Libellé du champ lien avec le tuteur.
  ///
  /// In fr, this message translates to:
  /// **'Lien (ex. père)'**
  String get fideleChampLienTuteur;

  /// Libellé indiquant qu'un fidèle est mineur.
  ///
  /// In fr, this message translates to:
  /// **'Mineur'**
  String get fideleChampMineur;

  /// Libellé du champ nœud d'appartenance.
  ///
  /// In fr, this message translates to:
  /// **'Nœud d'appartenance'**
  String get fideleChampNoeud;

  /// Message de validation du champ nœud d'appartenance.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un nœud d'appartenance.'**
  String get fideleChampNoeudErreur;

  /// Libellé du champ nom de famille.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get fideleChampNom;

  /// Message de validation du champ nom.
  ///
  /// In fr, this message translates to:
  /// **'Le nom est requis.'**
  String get fideleChampNomErreur;

  /// Libellé du champ nom du tuteur.
  ///
  /// In fr, this message translates to:
  /// **'Nom du tuteur'**
  String get fideleChampNomTuteur;

  /// Libellé du champ prénoms.
  ///
  /// In fr, this message translates to:
  /// **'Prénoms'**
  String get fideleChampPrenoms;

  /// Message de validation du champ prénoms.
  ///
  /// In fr, this message translates to:
  /// **'Les prénoms sont requis.'**
  String get fideleChampPrenomsErreur;

  /// Libellé du champ sexe.
  ///
  /// In fr, this message translates to:
  /// **'Sexe'**
  String get fideleChampSexe;

  /// Message de validation du champ sexe.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un sexe.'**
  String get fideleChampSexeErreur;

  /// Libellé du champ statut civil.
  ///
  /// In fr, this message translates to:
  /// **'Statut civil'**
  String get fideleChampStatutCivil;

  /// Message de validation du champ statut civil.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un statut civil.'**
  String get fideleChampStatutCivilErreur;

  /// Libellé du champ téléphone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get fideleChampTelephone;

  /// Titre de la section cheminement spirituel.
  ///
  /// In fr, this message translates to:
  /// **'Cheminement spirituel'**
  String get fideleCheminementTitre;

  /// Champ date de naissance une fois une date choisie.
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance : {date}'**
  String fideleDateNaissanceValeur(String date);

  /// État vide de l'historique d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune modification historisée.'**
  String get fideleHistoriqueAucune;

  /// Titre de l'écran d'historique d'un fidèle, avec son nom.
  ///
  /// In fr, this message translates to:
  /// **'Historique — {nom}'**
  String fideleHistoriqueTitre(String nom);

  /// Infobulle du bouton d'accès à l'historique d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Historique des modifications'**
  String get fideleHistoriqueTooltip;

  /// Corps du message quand le fidèle demandé n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Ce fidèle n'existe pas (ou plus).'**
  String get fideleIntrouvableCorps;

  /// Titre affiché quand le fidèle demandé n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Fidèle introuvable'**
  String get fideleIntrouvableTitre;

  /// Titre de la section liens familiaux.
  ///
  /// In fr, this message translates to:
  /// **'Liens familiaux'**
  String get fideleLiensFamiliauxTitre;

  /// Action de modification des coordonnées (infobulle et titre de boîte de dialogue).
  ///
  /// In fr, this message translates to:
  /// **'Modifier les coordonnées'**
  String get fideleModifierCoordonnees;

  /// Libellé du statut spirituel actuel.
  ///
  /// In fr, this message translates to:
  /// **'Statut actuel'**
  String get fideleStatutActuel;

  /// Note affichée quand le statut spirituel est verrouillé par le module Discipline.
  ///
  /// In fr, this message translates to:
  /// **'Ce statut ne peut être modifié que depuis le module Discipline (RG-II-03).'**
  String get fideleStatutDisciplineNote;

  /// Libellé d'un bouton de transition vers un nouveau statut spirituel.
  ///
  /// In fr, this message translates to:
  /// **'→ {cible}'**
  String fideleTransitionVers(String cible);

  /// Titre de la section tuteur légal.
  ///
  /// In fr, this message translates to:
  /// **'Tuteur légal (RG-II-06)'**
  String get fideleTuteurLegalTitre;

  /// État vide de la liste des fidèles.
  ///
  /// In fr, this message translates to:
  /// **'Aucun fidèle enregistré.'**
  String get fidelesAucun;

  /// Action de création d'un fidèle (infobulle et titre d'écran).
  ///
  /// In fr, this message translates to:
  /// **'Créer un fidèle'**
  String get fidelesCreerAction;

  /// Indice du champ de recherche de la liste des fidèles.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un fidèle (nom ou prénoms)'**
  String get fidelesRechercherIndice;

  /// Titre de l'écran liste des fidèles.
  ///
  /// In fr, this message translates to:
  /// **'Fidèles'**
  String get fidelesTitre;

  /// Libellé de la tuile de module Référentiel des dons spirituels sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Référentiel des dons spirituels'**
  String get moduleDonsReferentiel;

  /// Libellé de la tuile de module Groupes de l'Église sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Groupes de l'Église'**
  String get moduleGroupesEglise;

  /// Libellé de la tuile de module Mandats arrivant à échéance sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Mandats arrivant à échéance'**
  String get moduleMandatsEcheance;

  /// Libellé de la tuile de module Organisation sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Organisation'**
  String get moduleOrganisation;

  /// Libellé de la tuile de module Groupes professionnels sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Groupes professionnels'**
  String get moduleProfessions;

  /// Libellé de la tuile de module Rôles sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Rôles'**
  String get moduleRoles;

  /// Libellé de la tuile de module Zones géographiques sur l'écran d'accueil.
  ///
  /// In fr, this message translates to:
  /// **'Zones géographiques'**
  String get moduleZonesGeographiques;

  /// Libellé de l'onglet Accueil dans la navigation principale (AppShell).
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navAccueil;

  /// Titre de l'écran Paramètres.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get parametresTitre;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
