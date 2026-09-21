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

  /// État vide de la corbeille documentaire.
  ///
  /// In fr, this message translates to:
  /// **'Corbeille vide.'**
  String get archivageAucunDansCorbeille;

  /// État vide de la bibliothèque documentaire.
  ///
  /// In fr, this message translates to:
  /// **'Aucun document archivé.'**
  String get archivageAucunDocument;

  /// Titre de l'écran bibliothèque documentaire.
  ///
  /// In fr, this message translates to:
  /// **'Documents archivés'**
  String get archivageBibliothequeTitre;

  /// Libellé du champ référence de fichier lors de l'ajout d'une nouvelle version.
  ///
  /// In fr, this message translates to:
  /// **'Référence du fichier (nom, lien...)'**
  String get archivageChampReferenceFichier;

  /// Titre de l'écran corbeille documentaire.
  ///
  /// In fr, this message translates to:
  /// **'Corbeille'**
  String get archivageCorbeilleTitre;

  /// Titre de l'écran de consultation d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Document archivé'**
  String get archivageDetailTitre;

  /// Message affiché quand le document demandé n'existe pas (ou a été purgé).
  ///
  /// In fr, this message translates to:
  /// **'Ce document est introuvable (ou a été purgé).'**
  String get archivageDocumentIntrouvable;

  /// Bouton de mise en corbeille d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Mettre en corbeille'**
  String get archivageMettreEnCorbeilleBouton;

  /// Date de mise en corbeille d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Mis en corbeille le {date}'**
  String archivageMiseCorbeilleLe(String date);

  /// Libellé du niveau de confidentialité restreint.
  ///
  /// In fr, this message translates to:
  /// **'Restreint'**
  String get archivageNiveauRestreint;

  /// Libellé du niveau de confidentialité standard.
  ///
  /// In fr, this message translates to:
  /// **'Standard'**
  String get archivageNiveauStandard;

  /// Bouton d'ajout d'une nouvelle version d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle version'**
  String get archivageNouvelleVersionBouton;

  /// Titre de la boîte de dialogue d'ajout d'une nouvelle version.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une nouvelle version'**
  String get archivageNouvelleVersionTitre;

  /// Titre de la section origine (module/objet producteur) d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Origine'**
  String get archivageOrigineLabel;

  /// Date à partir de laquelle un document en corbeille devient purgeable.
  ///
  /// In fr, this message translates to:
  /// **'Purgeable à partir du {date}'**
  String archivagePurgeableApres(String date);

  /// Bouton de purge définitive d'un document en corbeille.
  ///
  /// In fr, this message translates to:
  /// **'Purger définitivement'**
  String get archivagePurgerBouton;

  /// Message de confirmation avant la purge définitive d'un document.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible : le document et toutes ses versions seront supprimés.'**
  String get archivagePurgerConfirmationMessage;

  /// Titre de la boîte de dialogue de confirmation de purge définitive.
  ///
  /// In fr, this message translates to:
  /// **'Purger définitivement ce document ?'**
  String get archivagePurgerConfirmationTitre;

  /// Libellé du champ de recherche de la bibliothèque documentaire.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un document (numéro, type)'**
  String get archivageRechercheLabel;

  /// Bouton de restauration d'un document depuis la corbeille.
  ///
  /// In fr, this message translates to:
  /// **'Restaurer'**
  String get archivageRestaurerBouton;

  /// Libellé d'une entrée de l'historique des versions.
  ///
  /// In fr, this message translates to:
  /// **'Version {numero}'**
  String archivageVersionLabel(int numero);

  /// Titre de la section historique des versions d'un document archivé.
  ///
  /// In fr, this message translates to:
  /// **'Historique des versions'**
  String get archivageVersionsTitre;

  /// État vide de l'historique des déplacements d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun déplacement enregistré.'**
  String get deplacementsAucunDeplacement;

  /// État vide de la liste des mutations d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Aucune mutation.'**
  String get deplacementsAucuneMutation;

  /// Libellé du champ fidèle lors de la demande de mutation.
  ///
  /// In fr, this message translates to:
  /// **'Fidèle'**
  String get deplacementsChampFidele;

  /// Libellé du champ motif lors de la demande de mutation.
  ///
  /// In fr, this message translates to:
  /// **'Motif'**
  String get deplacementsChampMotif;

  /// Libellé du champ motif de refus d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Motif du refus (optionnel)'**
  String get deplacementsChampMotifRefus;

  /// Libellé du champ nœud de destination lors de la demande de mutation.
  ///
  /// In fr, this message translates to:
  /// **'Église de destination'**
  String get deplacementsChampNoeudDestination;

  /// Libellé de la section église de destination d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Église de destination'**
  String get deplacementsCoteDestinationLabel;

  /// Libellé de la section église d'origine d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Église d\'origine'**
  String get deplacementsCoteOrigineLabel;

  /// Libellé de la date de demande d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Demandée le'**
  String get deplacementsDateDemandeLabel;

  /// Libellé de la date de validation d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Validée le'**
  String get deplacementsDateValidationLabel;

  /// Titre de la boîte de dialogue de demande de mutation.
  ///
  /// In fr, this message translates to:
  /// **'Demander une mutation'**
  String get deplacementsDemanderTitre;

  /// Titre de l'écran de détail d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Mutation'**
  String get deplacementsDetailTitre;

  /// Titre de l'écran historique des déplacements d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Historique des déplacements'**
  String get deplacementsHistoriqueTitre;

  /// Message affiché quand la mutation demandée n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Cette mutation est introuvable.'**
  String get deplacementsIntrouvable;

  /// Libellé affichant le motif d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Motif'**
  String get deplacementsMotifLabel;

  /// Bouton de refus d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get deplacementsRefuserBouton;

  /// Titre de la boîte de dialogue de refus d'une mutation.
  ///
  /// In fr, this message translates to:
  /// **'Refuser cette mutation ?'**
  String get deplacementsRefuserTitre;

  /// Libellé du statut de mutation en attente.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get deplacementsStatutEnAttente;

  /// Libellé du statut de mutation refusée.
  ///
  /// In fr, this message translates to:
  /// **'Refusée'**
  String get deplacementsStatutRefusee;

  /// Libellé du statut de mutation validée.
  ///
  /// In fr, this message translates to:
  /// **'Validée'**
  String get deplacementsStatutValidee;

  /// Titre de l'écran liste des mutations d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Mutations'**
  String get deplacementsTitre;

  /// Bouton de validation pastorale côté destination.
  ///
  /// In fr, this message translates to:
  /// **'Valider (destination)'**
  String get deplacementsValiderDestinationBouton;

  /// Bouton de validation pastorale côté origine.
  ///
  /// In fr, this message translates to:
  /// **'Valider (origine)'**
  String get deplacementsValiderOrigineBouton;

  /// Bouton d'accès à la lettre de recommandation archivée d'une mutation validée.
  ///
  /// In fr, this message translates to:
  /// **'Voir la lettre de recommandation'**
  String get deplacementsVoirLettreBouton;

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
  /// **'Cette séance n\'existe pas (ou plus).'**
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

  /// Bouton d'ajout d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une séquence'**
  String get culteAjouterSequenceBouton;

  /// Titre de la boîte de dialogue d'ajout d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une séquence'**
  String get culteAjouterSequenceTitre;

  /// Option « aucun » du sélecteur de prédicateur.
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get culteAucunPredicateur;

  /// État vide de la liste des séquences liturgiques.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séquence.'**
  String get culteAucuneSequence;

  /// Libellé du champ lien audio de la publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Lien audio'**
  String get culteChampAudioUrl;

  /// Libellé du champ compte global de présence d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Compte global de présence'**
  String get culteChampCompteGlobal;

  /// Libellé du champ date et heure d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Date et heure'**
  String get culteChampDateHeure;

  /// Libellé du champ durée prévue en minutes d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Durée prévue (minutes)'**
  String get culteChampDureeMinutes;

  /// Libellé du champ libellé d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Libellé (ex. Louange, Prédication)'**
  String get culteChampLibelleSequence;

  /// Libellé du champ mode de présence d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Mode de présence'**
  String get culteChampModePresence;

  /// Libellé du champ nombre d'occurrences d'une série récurrente.
  ///
  /// In fr, this message translates to:
  /// **'Nombre d\'occurrences'**
  String get culteChampNombreOccurrences;

  /// Libellé du champ ordre d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Ordre'**
  String get culteChampOrdre;

  /// Libellé du champ lien PDF de la publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Lien PDF'**
  String get culteChampPdfUrl;

  /// Libellé du champ prédicateur (optionnel) d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Prédicateur (optionnel)'**
  String get culteChampPredicateur;

  /// Libellé de la case à cocher série récurrente d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Créer une série récurrente (hebdomadaire)'**
  String get culteChampRecurrent;

  /// Libellé du champ responsable (optionnel) d'une séquence liturgique.
  ///
  /// In fr, this message translates to:
  /// **'Responsable (optionnel)'**
  String get culteChampResponsable;

  /// Libellé du champ texte biblique de la publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Texte biblique'**
  String get culteChampTexteBiblique;

  /// Libellé du champ thème (optionnel) d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Thème (optionnel)'**
  String get culteChampTheme;

  /// Libellé du champ type de culte.
  ///
  /// In fr, this message translates to:
  /// **'Type de culte (ex. Culte dominical)'**
  String get culteChampType;

  /// Message de validation du champ type de culte.
  ///
  /// In fr, this message translates to:
  /// **'Le type de culte est requis.'**
  String get culteChampTypeErreur;

  /// Libellé du champ lien vidéo de la publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Lien vidéo'**
  String get culteChampVideoUrl;

  /// Libellé du champ date/heure avant sélection.
  ///
  /// In fr, this message translates to:
  /// **'Choisir la date et l\'heure'**
  String get culteDateHeureChoisir;

  /// Bouton d'enregistrement du compte global de présence.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer le compte'**
  String get culteEnregistrerCompte;

  /// Titre de la section liturgie (séquences) d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Liturgie'**
  String get culteLiturgieTitre;

  /// Libellé de l'option de mode de présence globale.
  ///
  /// In fr, this message translates to:
  /// **'Global (compte total)'**
  String get culteModePresenceGlobal;

  /// Libellé de l'option de mode de présence nominal.
  ///
  /// In fr, this message translates to:
  /// **'Nominal (par fidèle)'**
  String get culteModePresenceNominal;

  /// État indiquant qu'aucune publication post-culte n'existe encore.
  ///
  /// In fr, this message translates to:
  /// **'Aucune publication pour ce culte.'**
  String get culteNonPublie;

  /// Titre de la section présences d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Présences'**
  String get cultePresencesTitre;

  /// Titre de la section publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Publication post-culte'**
  String get cultePublicationTitre;

  /// Note indiquant la date de publication post-culte, avec la date.
  ///
  /// In fr, this message translates to:
  /// **'Publié le {date}'**
  String cultePublieLe(String date);

  /// Bouton de publication post-culte.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get cultePublierBouton;

  /// Titre de la section statut d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get culteStatutTitre;

  /// État vide de la liste des cultes.
  ///
  /// In fr, this message translates to:
  /// **'Aucun culte enregistré.'**
  String get cultesAucun;

  /// Infobulle du bouton flottant de création d'un culte.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau culte'**
  String get cultesNouveauTooltip;

  /// Titre de l'écran liste des cultes.
  ///
  /// In fr, this message translates to:
  /// **'Cultes'**
  String get cultesTitre;

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
  /// **'Groupes de l\'Église'**
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
  /// **'Nœud d\'appartenance'**
  String get fideleChampNoeud;

  /// Message de validation du champ nœud d'appartenance.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un nœud d\'appartenance.'**
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
  /// **'Ce fidèle n\'existe pas (ou plus).'**
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
  /// **'Groupes de l\'Église'**
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

  /// Libellé du champ explication (optionnelle) d'une proposition de thème.
  ///
  /// In fr, this message translates to:
  /// **'Brève explication (optionnelle)'**
  String get propositionChampExplication;

  /// Libellé du champ titre d'une proposition de thème.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get propositionChampTitre;

  /// Titre de la boîte de dialogue de soumission d'une proposition de thème.
  ///
  /// In fr, this message translates to:
  /// **'Soumettre une proposition de thème'**
  String get propositionSoumettreTitre;

  /// Infobulle du bouton flottant de soumission d'une proposition de thème.
  ///
  /// In fr, this message translates to:
  /// **'Soumettre une proposition'**
  String get propositionSoumettreTooltip;

  /// État vide de la liste des propositions de thème.
  ///
  /// In fr, this message translates to:
  /// **'Aucune proposition soumise.'**
  String get propositionsAucune;

  /// Titre de l'écran des propositions de thème de culte.
  ///
  /// In fr, this message translates to:
  /// **'Propositions de thème'**
  String get propositionsThemeTitre;

  /// Libellé du sélecteur de fidèle actif pour soumettre/voter (pas de session réelle, RG-SEC-01 non construit).
  ///
  /// In fr, this message translates to:
  /// **'Voter/soumettre en tant que'**
  String get propositionsVoterEnTantQue;

  /// Titre de l'écran de liste des dossiers disciplinaires d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Dossiers disciplinaires'**
  String get disciplineTitre;

  /// Titre de l'écran d'historique des dossiers disciplinaires d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Historique disciplinaire confidentiel'**
  String get disciplineHistoriqueTitre;

  /// État vide de la liste des dossiers disciplinaires d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Aucun dossier disciplinaire.'**
  String get disciplineAucunDossier;

  /// État vide de l'historique disciplinaire d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun dossier disciplinaire pour ce fidèle.'**
  String get disciplineAucunDossierFidele;

  /// Infobulle du bouton flottant d'ouverture d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir un dossier'**
  String get disciplineOuvrirTooltip;

  /// Titre du dialogue d'ouverture d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir un dossier disciplinaire'**
  String get disciplineOuvrirTitre;

  /// Libellé du champ fidèle lors de l'ouverture d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Fidèle mis en cause'**
  String get disciplineChampFideleMisEnCause;

  /// Libellé du champ nature de la faute d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Nature de la faute'**
  String get disciplineChampNatureFaute;

  /// Libellé du sélecteur de rôle agissant à l'ouverture d'un dossier (RG-X-01, pas de session réelle).
  ///
  /// In fr, this message translates to:
  /// **'Rôle agissant'**
  String get disciplineChampRoleActeur;

  /// Libellé du sélecteur de fidèle acteur à l'ouverture d'un dossier (RG-X-01).
  ///
  /// In fr, this message translates to:
  /// **'Ouvert par (optionnel — membre de commission)'**
  String get disciplineChampActeur;

  /// Valeur par défaut du sélecteur de fidèle acteur (aucun acteur désigné).
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get disciplineActeurAucun;

  /// Libellé du statut de dossier disciplinaire « en instruction ».
  ///
  /// In fr, this message translates to:
  /// **'En instruction'**
  String get disciplineStatutEnInstruction;

  /// Libellé du statut de dossier disciplinaire « sanctionné ».
  ///
  /// In fr, this message translates to:
  /// **'Sanctionné'**
  String get disciplineStatutSanctionne;

  /// Libellé du statut de dossier disciplinaire « clos ».
  ///
  /// In fr, this message translates to:
  /// **'Clos'**
  String get disciplineStatutClos;

  /// Alerte de fin de période de sanction déterminée (RG-X-04).
  ///
  /// In fr, this message translates to:
  /// **'Réintégration prévue le {date}'**
  String disciplineAlerteFinDePeriode(String date);

  /// Alerte de revue périodique pour une sanction à durée indéterminée (RG-X-04).
  ///
  /// In fr, this message translates to:
  /// **'Revue périodique nécessaire'**
  String get disciplineAlerteRevuePeriodique;

  /// Titre de l'écran fiche d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Dossier disciplinaire'**
  String get disciplineDetailTitre;

  /// Corps de l'écran fiche quand le dossier n'existe pas (ou plus).
  ///
  /// In fr, this message translates to:
  /// **'Ce dossier disciplinaire est introuvable.'**
  String get disciplineIntrouvable;

  /// Date d'ouverture d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ouvert le {date}'**
  String disciplineOuvertLe(String date);

  /// Titre de la section commission de la fiche d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Commission instructrice'**
  String get disciplineCommissionTitre;

  /// État vide de la section commission d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Aucune commission assignée.'**
  String get disciplineCommissionAucune;

  /// Bouton d'assignation d'une commission à un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Assigner une commission'**
  String get disciplineCommissionAssignerBouton;

  /// Titre du dialogue d'assignation d'une commission.
  ///
  /// In fr, this message translates to:
  /// **'Assigner une commission'**
  String get disciplineCommissionAssignerTitre;

  /// Bouton de création d'une nouvelle commission depuis le dialogue d'assignation.
  ///
  /// In fr, this message translates to:
  /// **'Créer une nouvelle commission'**
  String get disciplineCommissionCreerBouton;

  /// Titre du dialogue de création d'une commission disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Créer une commission'**
  String get disciplineCommissionCreerTitre;

  /// Libellé du champ nom lors de la création d'une commission disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la commission'**
  String get disciplineChampNomCommission;

  /// Titre de la section membres d'une commission disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Membres de la commission'**
  String get disciplineCommissionMembresTitre;

  /// Infobulle du bouton d'ajout d'un membre à une commission disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un membre'**
  String get disciplineCommissionAjouterMembreTooltip;

  /// Titre de la section pièces d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Pièces du dossier'**
  String get disciplinePiecesTitre;

  /// État vide de la section pièces d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Aucune pièce versée.'**
  String get disciplinePiecesAucune;

  /// Infobulle du bouton d'ajout d'une pièce à un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une pièce'**
  String get disciplinePieceAjouterTooltip;

  /// Titre du dialogue d'ajout d'une pièce à un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une pièce'**
  String get disciplinePieceAjouterTitre;

  /// Libellé du sélecteur de nature d'une pièce de dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Nature de la pièce'**
  String get disciplinePieceChampNature;

  /// Libellé de la nature de pièce « témoignage ».
  ///
  /// In fr, this message translates to:
  /// **'Témoignage'**
  String get disciplinePieceNatureTemoignage;

  /// Libellé de la nature de pièce « preuve ».
  ///
  /// In fr, this message translates to:
  /// **'Preuve'**
  String get disciplinePieceNaturePreuve;

  /// Libellé du champ contenu textuel d'une pièce de dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Contenu (texte)'**
  String get disciplinePieceChampContenu;

  /// Titre de la section décision d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Décision'**
  String get disciplineDecisionTitre;

  /// Libellé du champ décision motivée d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Décision motivée'**
  String get disciplineChampDecision;

  /// Libellé du champ durée de sanction, en jours, lors du prononcé d'une décision.
  ///
  /// In fr, this message translates to:
  /// **'Durée de la sanction en jours (vide = indéterminée)'**
  String get disciplineChampDureeSanction;

  /// Libellé de la case à cocher de suspension des ministères (RG-X-03).
  ///
  /// In fr, this message translates to:
  /// **'Suspendre les affectations ministérielles actives'**
  String get disciplineChampSuspendreMinisteres;

  /// Bouton de prononcé de la décision d'un dossier disciplinaire.
  ///
  /// In fr, this message translates to:
  /// **'Prononcer la décision'**
  String get disciplinePrononcerBouton;

  /// Date à laquelle la décision d'un dossier disciplinaire a été rendue.
  ///
  /// In fr, this message translates to:
  /// **'Décision rendue le {date}'**
  String disciplineDecisionRendueLe(String date);

  /// Bouton de clôture et réintégration d'un dossier disciplinaire sanctionné (RG-X-04).
  ///
  /// In fr, this message translates to:
  /// **'Clôturer / Réintégrer'**
  String get disciplineCloturerBouton;

  /// Note affichée sur un dossier disciplinaire clos.
  ///
  /// In fr, this message translates to:
  /// **'Dossier clos — le fidèle a retrouvé son statut antérieur.'**
  String get disciplineDossierClosNote;

  /// Libellé affiché quand une sanction n'a pas de durée déterminée.
  ///
  /// In fr, this message translates to:
  /// **'Durée indéterminée'**
  String get disciplineDureeIndeterminee;

  /// Durée d'une sanction en jours.
  ///
  /// In fr, this message translates to:
  /// **'{jours} jour(s)'**
  String disciplineDureeJours(int jours);

  /// Titre de l'écran de liste des contributions d'un nœud (Module XI).
  ///
  /// In fr, this message translates to:
  /// **'Contributions'**
  String get financesTitre;

  /// Titre de l'écran d'historique des contributions d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Historique des contributions'**
  String get financesHistoriqueTitre;

  /// État vide de la liste des contributions d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Aucune contribution saisie.'**
  String get financesAucuneContribution;

  /// État vide de l'historique des contributions d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune contribution pour ce fidèle.'**
  String get financesAucuneContributionFidele;

  /// Infobulle du bouton flottant de saisie rapide d'une offrande (RG-XI-01).
  ///
  /// In fr, this message translates to:
  /// **'Saisir une offrande'**
  String get financesSaisirTooltip;

  /// Titre du dialogue de saisie rapide d'une offrande.
  ///
  /// In fr, this message translates to:
  /// **'Saisir une offrande'**
  String get financesSaisirTitre;

  /// Libellé du sélecteur de donateur lors de la saisie d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Donateur'**
  String get financesChampDonateur;

  /// Valeur du sélecteur de donateur pour un don anonyme identifié techniquement (RG-XI-01).
  ///
  /// In fr, this message translates to:
  /// **'Donateur anonyme'**
  String get financesDonateurAnonyme;

  /// Libellé du champ texte libre pour un donateur anonyme.
  ///
  /// In fr, this message translates to:
  /// **'Libellé du donateur anonyme (optionnel)'**
  String get financesChampLibelleDonateurAnonyme;

  /// Libellé du sélecteur de type d'offrande lors de la saisie d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'offrande'**
  String get financesChampTypeOffrande;

  /// Libellé du champ montant d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get financesChampMontant;

  /// Libellé du sélecteur de mode de paiement d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Mode de paiement'**
  String get financesChampModePaiement;

  /// Libellé du mode de paiement « espèces ».
  ///
  /// In fr, this message translates to:
  /// **'Espèces'**
  String get financesModePaiementEspeces;

  /// Libellé du mode de paiement « mobile money ».
  ///
  /// In fr, this message translates to:
  /// **'Mobile money'**
  String get financesModePaiementMobileMoney;

  /// Libellé du mode de paiement « virement ».
  ///
  /// In fr, this message translates to:
  /// **'Virement'**
  String get financesModePaiementVirement;

  /// Bouton de confirmation de la saisie d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Saisir'**
  String get financesSaisirBouton;

  /// Titre du rapport rapide par type d'offrande (contributions validées affichées).
  ///
  /// In fr, this message translates to:
  /// **'Répartition par type d\'offrande'**
  String get financesRapportParTypeTitre;

  /// Libellé du statut de contribution « en attente ».
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get financesStatutEnAttente;

  /// Libellé du statut de contribution « validée ».
  ///
  /// In fr, this message translates to:
  /// **'Validée'**
  String get financesStatutValidee;

  /// Libellé du statut de contribution « rejetée ».
  ///
  /// In fr, this message translates to:
  /// **'Rejetée'**
  String get financesStatutRejetee;

  /// Titre de l'écran de gestion des trésoriers désignés d'un nœud (RG-XI-02).
  ///
  /// In fr, this message translates to:
  /// **'Trésoriers désignés'**
  String get financesTresoriersTitre;

  /// État vide de la liste des trésoriers désignés d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Aucun trésorier désigné.'**
  String get financesTresoriersAucun;

  /// Titre du dialogue de désignation d'un trésorier.
  ///
  /// In fr, this message translates to:
  /// **'Désigner un trésorier'**
  String get financesTresorierDesignerTitre;

  /// Bouton de confirmation de la désignation d'un trésorier.
  ///
  /// In fr, this message translates to:
  /// **'Désigner'**
  String get financesTresorierDesignerBouton;

  /// Infobulle du bouton flottant de désignation d'un trésorier.
  ///
  /// In fr, this message translates to:
  /// **'Désigner un trésorier'**
  String get financesTresorierDesignerTooltip;

  /// Date de début de désignation d'un trésorier.
  ///
  /// In fr, this message translates to:
  /// **'Trésorier depuis le {date}'**
  String financesTresorierDepuis(String date);

  /// Infobulle du bouton de retrait de la désignation d'un trésorier.
  ///
  /// In fr, this message translates to:
  /// **'Retirer la désignation'**
  String get financesTresorierRetirerTooltip;

  /// Titre de l'écran fiche d'une contribution (sert aussi de reçu).
  ///
  /// In fr, this message translates to:
  /// **'Reçu de contribution'**
  String get financesRecuTitre;

  /// Corps de l'écran fiche quand la contribution n'existe pas (ou plus).
  ///
  /// In fr, this message translates to:
  /// **'Cette contribution est introuvable.'**
  String get financesIntrouvable;

  /// Titre du dialogue de validation comptable d'une contribution (RG-XI-02).
  ///
  /// In fr, this message translates to:
  /// **'Valider la contribution'**
  String get financesValiderTitre;

  /// Libellé du sélecteur de rôle agissant lors de la validation (pas de session réelle, RG-SEC-01 non construit).
  ///
  /// In fr, this message translates to:
  /// **'Rôle agissant'**
  String get financesChampRoleActeur;

  /// Libellé du sélecteur de fidèle qui valide (RG-XI-02, trace l'auteur).
  ///
  /// In fr, this message translates to:
  /// **'Validé par'**
  String get financesChampValidePar;

  /// Bouton de validation comptable d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get financesValiderBouton;

  /// Titre du dialogue de rejet d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Rejeter la contribution'**
  String get financesRejeterTitre;

  /// Libellé du champ motif (rejet ou contre-passation d'une contribution, ou dérogation de dépense).
  ///
  /// In fr, this message translates to:
  /// **'Motif'**
  String get financesChampMotif;

  /// Bouton de rejet d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Rejeter'**
  String get financesRejeterBouton;

  /// Titre du dialogue de contre-passation d'une contribution validée (RG-XI-05).
  ///
  /// In fr, this message translates to:
  /// **'Contre-passer la contribution'**
  String get financesContrePasserTitre;

  /// Bouton de contre-passation d'une contribution validée.
  ///
  /// In fr, this message translates to:
  /// **'Contre-passer'**
  String get financesContrePasserBouton;

  /// Date de saisie d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Saisie le {date}'**
  String financesSaisieLe(String date);

  /// Date de validation comptable d'une contribution.
  ///
  /// In fr, this message translates to:
  /// **'Validée le {date}'**
  String financesValideeLe(String date);

  /// Note affichée sur une contribution de contre-passation (RG-XI-05).
  ///
  /// In fr, this message translates to:
  /// **'Cette contribution est une contre-passation.'**
  String get financesEstContrePassation;

  /// Titre de l'écran de liste des projets d'un nœud (RG-XI-03).
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get financesProjetsTitre;

  /// État vide de la liste des projets d'un nœud.
  ///
  /// In fr, this message translates to:
  /// **'Aucun projet.'**
  String get financesProjetsAucun;

  /// Titre du dialogue de création d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Créer un projet'**
  String get financesProjetCreerTitre;

  /// Infobulle du bouton flottant de création d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Créer un projet'**
  String get financesProjetCreerTooltip;

  /// Libellé du champ nom lors de la création d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Nom du projet'**
  String get financesChampNomProjet;

  /// Libellé du champ budget prévisionnel lors de la création d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Budget prévisionnel'**
  String get financesChampBudgetPrevisionnel;

  /// Solde recalculé d'un projet rapporté à son budget prévisionnel (RG-XI-03, jamais une colonne stockée).
  ///
  /// In fr, this message translates to:
  /// **'Solde : {solde} {devise} / budget {budget} {devise}'**
  String financesProjetSoldeSurBudget(int solde, int budget, String devise);

  /// Titre de l'écran fiche d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Fiche projet'**
  String get financesProjetDetailTitre;

  /// Corps de l'écran fiche quand le projet n'existe pas (ou plus).
  ///
  /// In fr, this message translates to:
  /// **'Ce projet est introuvable.'**
  String get financesProjetIntrouvable;

  /// Titre du dialogue d'ajout d'une dépense à un projet (RG-XI-03).
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une dépense'**
  String get financesDepenseAjouterTitre;

  /// Bouton d'ouverture du dialogue d'ajout d'une dépense.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une dépense'**
  String get financesDepenseAjouterBouton;

  /// Libellé du champ libellé lors de l'ajout d'une dépense.
  ///
  /// In fr, this message translates to:
  /// **'Libellé de la dépense'**
  String get financesChampLibelleDepense;

  /// Libellé de la case à cocher de dérogation tracée lors de l'ajout d'une dépense (RG-XI-03).
  ///
  /// In fr, this message translates to:
  /// **'Dérogation tracée (dépasse le solde disponible)'**
  String get financesChampDerogationTracee;

  /// Titre de la section dépenses de la fiche d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Dépenses'**
  String get financesDepensesTitre;

  /// État vide de la section dépenses de la fiche d'un projet.
  ///
  /// In fr, this message translates to:
  /// **'Aucune dépense engagée.'**
  String get financesDepensesAucune;

  /// Note affichée sur une dépense engagée au-delà du solde disponible avec dérogation tracée.
  ///
  /// In fr, this message translates to:
  /// **'{date} — dérogation tracée'**
  String financesDepenseDerogation(String date);

  /// Titre de l'écran des engagements et échéances d'un fidèle (RG-XI-04).
  ///
  /// In fr, this message translates to:
  /// **'Engagements et échéances'**
  String get financesEngagementsTitre;

  /// État vide de la liste des engagements d'un fidèle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun engagement.'**
  String get financesEngagementsAucun;

  /// Titre du dialogue de création d'un engagement récurrent.
  ///
  /// In fr, this message translates to:
  /// **'Créer un engagement'**
  String get financesEngagementCreerTitre;

  /// Infobulle du bouton flottant de création d'un engagement.
  ///
  /// In fr, this message translates to:
  /// **'Créer un engagement'**
  String get financesEngagementCreerTooltip;

  /// Libellé du sélecteur de type d'engagement.
  ///
  /// In fr, this message translates to:
  /// **'Type d\'engagement'**
  String get financesChampTypeEngagement;

  /// Libellé du type d'engagement « dîme ».
  ///
  /// In fr, this message translates to:
  /// **'Dîme'**
  String get financesTypeEngagementDime;

  /// Libellé du type d'engagement « promesse de don ».
  ///
  /// In fr, this message translates to:
  /// **'Promesse de don'**
  String get financesTypeEngagementPromesseDon;

  /// Libellé du champ montant prévu lors de la création d'un engagement.
  ///
  /// In fr, this message translates to:
  /// **'Montant prévu'**
  String get financesChampMontantPrevu;

  /// Libellé du sélecteur de périodicité lors de la création d'un engagement.
  ///
  /// In fr, this message translates to:
  /// **'Périodicité'**
  String get financesChampPeriodicite;

  /// Libellé de la périodicité « hebdomadaire ».
  ///
  /// In fr, this message translates to:
  /// **'Hebdomadaire'**
  String get financesPeriodiciteHebdomadaire;

  /// Libellé de la périodicité « mensuelle ».
  ///
  /// In fr, this message translates to:
  /// **'Mensuelle'**
  String get financesPeriodiciteMensuelle;

  /// Libellé de la périodicité « trimestrielle ».
  ///
  /// In fr, this message translates to:
  /// **'Trimestrielle'**
  String get financesPeriodiciteTrimestrielle;

  /// Libellé de la périodicité « annuelle ».
  ///
  /// In fr, this message translates to:
  /// **'Annuelle'**
  String get financesPeriodiciteAnnuelle;

  /// Périodicité affichée sur la carte d'un engagement.
  ///
  /// In fr, this message translates to:
  /// **'Périodicité : {periodicite}'**
  String financesEngagementPeriodicite(String periodicite);

  /// Libellé du statut d'échéance « en attente ».
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get financesEcheanceEnAttente;

  /// Libellé du statut d'échéance « honorée ».
  ///
  /// In fr, this message translates to:
  /// **'Honorée'**
  String get financesEcheanceHonoree;

  /// Libellé du statut d'échéance « en retard ».
  ///
  /// In fr, this message translates to:
  /// **'En retard'**
  String get financesEcheanceEnRetard;

  /// Bouton d'honoration d'une échéance (saisit la contribution correspondante et la lie).
  ///
  /// In fr, this message translates to:
  /// **'Honorer'**
  String get financesEcheanceHonorerBouton;

  /// Titre de l'écran d'inventaire des biens, et libellé du bouton d'accès depuis la fiche nœud (Module XX).
  ///
  /// In fr, this message translates to:
  /// **'Biens'**
  String get patrimoineTitre;

  /// Titre de l'écran de liste des campagnes d'inventaire et tooltip d'accès depuis l'écran des biens (Module XX, RG-XX-04).
  ///
  /// In fr, this message translates to:
  /// **'Campagnes d\'inventaire'**
  String get patrimoineCampagnesTitre;

  /// Tooltip du bouton d'ajout d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un bien'**
  String get patrimoineAjouterTooltip;

  /// Message affiché quand la liste des biens d'un nœud est vide.
  ///
  /// In fr, this message translates to:
  /// **'Aucun bien enregistré.'**
  String get patrimoineAucunBien;

  /// Titre de la section des biens dont la quantité en stock est sous le seuil d'alerte (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Biens sous le seuil d\'alerte de stock'**
  String get patrimoineAlerteSeuilTitre;

  /// Titre de la boîte de dialogue d'ajout d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un bien'**
  String get patrimoineAjouterTitre;

  /// Libellé du champ identifiant d'inventaire d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Identifiant d\'inventaire'**
  String get patrimoineChampIdInventaire;

  /// Libellé du champ catégorie d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Catégorie'**
  String get patrimoineChampCategorie;

  /// Libellé du champ désignation d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Désignation'**
  String get patrimoineChampDesignation;

  /// Libellé du champ valeur d'acquisition d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Valeur d\'acquisition'**
  String get patrimoineChampValeurAcquisition;

  /// Libellé du champ valeur vénale d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Valeur vénale'**
  String get patrimoineChampValeurVenale;

  /// Libellé du champ date d'acquisition d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Date d\'acquisition'**
  String get patrimoineChampDateAcquisition;

  /// Libellé du champ seuil d'alerte de stock d'un bien à gestion de stock (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Seuil d\'alerte de stock'**
  String get patrimoineChampSeuilAlerteStock;

  /// Libellé de l'état d'un bien « neuf ».
  ///
  /// In fr, this message translates to:
  /// **'Neuf'**
  String get patrimoineEtatNeuf;

  /// Libellé de l'état d'un bien « bon ».
  ///
  /// In fr, this message translates to:
  /// **'Bon'**
  String get patrimoineEtatBon;

  /// Libellé de l'état d'un bien « à réparer ».
  ///
  /// In fr, this message translates to:
  /// **'À réparer'**
  String get patrimoineEtatAReparer;

  /// Libellé de l'état d'un bien « hors service ».
  ///
  /// In fr, this message translates to:
  /// **'Hors service'**
  String get patrimoineEtatHorsService;

  /// Libellé de l'état d'un bien sorti définitivement du patrimoine (RG-XX-02).
  ///
  /// In fr, this message translates to:
  /// **'Cédé'**
  String get patrimoineEtatCede;

  /// Titre de l'écran de fiche d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Fiche du bien'**
  String get patrimoineFicheTitre;

  /// Message affiché quand le bien demandé n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Bien introuvable.'**
  String get patrimoineIntrouvable;

  /// Titre de la boîte de dialogue de signalement d'état d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Signaler l\'état du bien'**
  String get patrimoineSignalerEtatTitre;

  /// Libellé du champ état d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'État'**
  String get patrimoineChampEtat;

  /// Bouton de signalement d'état d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Signaler l\'état'**
  String get patrimoineSignalerEtatBouton;

  /// Titre de la boîte de dialogue de sortie définitive d'un bien (RG-XX-02).
  ///
  /// In fr, this message translates to:
  /// **'Sortir le bien du patrimoine'**
  String get patrimoineSortirTitre;

  /// Libellé du champ type de sortie d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Type de sortie'**
  String get patrimoineChampTypeSortie;

  /// Libellé du type de sortie « cession ».
  ///
  /// In fr, this message translates to:
  /// **'Cession'**
  String get patrimoineTypeSortieCession;

  /// Libellé du type de sortie « don ».
  ///
  /// In fr, this message translates to:
  /// **'Don'**
  String get patrimoineTypeSortieDon;

  /// Libellé du type de sortie « mise au rebut ».
  ///
  /// In fr, this message translates to:
  /// **'Mise au rebut'**
  String get patrimoineTypeSortieMiseAuRebut;

  /// Libellé du champ rôle de l'acteur validant une sortie de bien.
  ///
  /// In fr, this message translates to:
  /// **'Rôle de l\'acteur'**
  String get patrimoineChampRoleActeur;

  /// Libellé du champ fidèle validant une sortie de bien.
  ///
  /// In fr, this message translates to:
  /// **'Validé par'**
  String get patrimoineChampValidePar;

  /// Libellé du champ motif.
  ///
  /// In fr, this message translates to:
  /// **'Motif'**
  String get patrimoineChampMotif;

  /// Bouton de confirmation de sortie d'un bien du patrimoine.
  ///
  /// In fr, this message translates to:
  /// **'Sortir le bien'**
  String get patrimoineSortirBouton;

  /// Titre de la boîte de dialogue de réservation d'un bien (RG-XX-03).
  ///
  /// In fr, this message translates to:
  /// **'Réserver le bien'**
  String get patrimoineReserverTitre;

  /// Libellé du champ objet d'une réservation de bien.
  ///
  /// In fr, this message translates to:
  /// **'Objet de la réservation'**
  String get patrimoineChampObjetReservation;

  /// Libellé de l'objet de réservation « culte ».
  ///
  /// In fr, this message translates to:
  /// **'Culte'**
  String get patrimoineObjetCulte;

  /// Libellé de l'objet de réservation « événement ».
  ///
  /// In fr, this message translates to:
  /// **'Événement'**
  String get patrimoineObjetEvenement;

  /// Libellé de l'objet de réservation « autre ».
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get patrimoineObjetAutre;

  /// Message affiché quand aucun culte n'existe pour lier une réservation de type culte.
  ///
  /// In fr, this message translates to:
  /// **'Aucun culte disponible pour ce nœud.'**
  String get patrimoineAucunCultePourReservation;

  /// Libellé du champ culte lié à une réservation.
  ///
  /// In fr, this message translates to:
  /// **'Culte'**
  String get patrimoineChampCulte;

  /// Libellé du champ description libre d'une réservation (événement ou autre).
  ///
  /// In fr, this message translates to:
  /// **'Description de l\'objet'**
  String get patrimoineChampObjetLibre;

  /// Libellé du champ date de début d'une réservation.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get patrimoineChampDateDebut;

  /// Libellé du champ date de fin d'une réservation.
  ///
  /// In fr, this message translates to:
  /// **'Date de fin'**
  String get patrimoineChampDateFin;

  /// Bouton de confirmation d'une réservation de bien.
  ///
  /// In fr, this message translates to:
  /// **'Réserver'**
  String get patrimoineReserverBouton;

  /// Titre de la boîte de dialogue d'ajout d'un mouvement de stock (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un mouvement de stock'**
  String get patrimoineMouvementAjouterTitre;

  /// Libellé du champ type d'un mouvement de stock.
  ///
  /// In fr, this message translates to:
  /// **'Type de mouvement'**
  String get patrimoineChampTypeMouvement;

  /// Libellé du type de mouvement de stock « entrée ».
  ///
  /// In fr, this message translates to:
  /// **'Entrée'**
  String get patrimoineMouvementEntree;

  /// Libellé du type de mouvement de stock « sortie ».
  ///
  /// In fr, this message translates to:
  /// **'Sortie'**
  String get patrimoineMouvementSortie;

  /// Libellé du champ quantité d'un mouvement de stock.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get patrimoineChampQuantite;

  /// Titre de la section de gestion de stock d'un bien (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Gestion de stock'**
  String get patrimoineStockTitre;

  /// Bouton d'ouverture de la boîte de dialogue d'ajout d'un mouvement de stock.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un mouvement'**
  String get patrimoineMouvementAjouterBouton;

  /// Titre de la section des réservations d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Réservations'**
  String get patrimoineReservationsTitre;

  /// Message affiché quand aucune réservation n'existe pour un bien.
  ///
  /// In fr, this message translates to:
  /// **'Aucune réservation enregistrée.'**
  String get patrimoineReservationsAucune;

  /// Tooltip du bouton de démarrage d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer une campagne'**
  String get patrimoineCampagneDemarrerTooltip;

  /// Message affiché quand la liste des campagnes d'inventaire d'un nœud est vide.
  ///
  /// In fr, this message translates to:
  /// **'Aucune campagne d\'inventaire enregistrée.'**
  String get patrimoineCampagnesAucune;

  /// Libellé du statut d'une campagne d'inventaire en cours.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get patrimoineCampagneEnCours;

  /// Libellé du statut d'une campagne d'inventaire clôturée.
  ///
  /// In fr, this message translates to:
  /// **'Clôturée'**
  String get patrimoineCampagneCloturee;

  /// Titre de la boîte de dialogue de démarrage d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer une campagne d\'inventaire'**
  String get patrimoineCampagneDemarrerTitre;

  /// Libellé du champ libellé d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Libellé de la campagne'**
  String get patrimoineChampLibelleCampagne;

  /// Bouton de confirmation de démarrage d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer'**
  String get patrimoineCampagneDemarrerBouton;

  /// Titre de l'écran de fiche d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Fiche de la campagne'**
  String get patrimoineCampagneFicheTitre;

  /// Message affiché quand la campagne d'inventaire demandée n'existe pas.
  ///
  /// In fr, this message translates to:
  /// **'Campagne introuvable.'**
  String get patrimoineCampagneIntrouvable;

  /// Titre de la boîte de dialogue de clôture d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Clôturer la campagne'**
  String get patrimoineCampagneCloturerTitre;

  /// Message de confirmation avant clôture d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible : aucun nouveau pointage ne pourra être enregistré.'**
  String get patrimoineCampagneCloturerConfirmation;

  /// Bouton de clôture d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Clôturer la campagne'**
  String get patrimoineCampagneCloturerBouton;

  /// Titre de la boîte de dialogue d'ajout d'un pointage d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un pointage'**
  String get patrimoineCampagneAjouterPointageTitre;

  /// Libellé du champ bien pointé lors d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Bien'**
  String get patrimoineChampBien;

  /// Libellé du champ état constaté lors d'un pointage d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'État constaté'**
  String get patrimoineChampEtatConstate;

  /// Libellé du champ quantité constatée lors d'un pointage d'inventaire (biens à gestion de stock).
  ///
  /// In fr, this message translates to:
  /// **'Quantité constatée'**
  String get patrimoineChampQuantiteConstatee;

  /// Libellé du champ commentaire d'un pointage d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Commentaire'**
  String get patrimoineChampCommentaire;

  /// Bouton d'enregistrement d'un pointage d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer le pointage'**
  String get patrimoineCampagneAjouterPointageBouton;

  /// Tooltip du bouton d'ajout d'un pointage d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un pointage'**
  String get patrimoineCampagneAjouterPointageTooltip;

  /// Titre de la section des pointages d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Pointages'**
  String get patrimoineCampagnePointagesTitre;

  /// Message affiché quand aucun pointage n'existe pour une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Aucun pointage enregistré.'**
  String get patrimoineCampagnePointagesAucun;

  /// Date d'acquisition affichée sur la fiche d'un bien.
  ///
  /// In fr, this message translates to:
  /// **'Acquis le {date}'**
  String patrimoineAcquisLe(String date);

  /// Date de sortie définitive affichée sur la fiche d'un bien sorti (RG-XX-02).
  ///
  /// In fr, this message translates to:
  /// **'Sorti le {date}'**
  String patrimoineSortiLe(String date);

  /// Quantité en stock actuelle d'un bien, recalculée à la lecture (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Quantité actuelle : {quantite}'**
  String patrimoineQuantiteActuelle(int quantite);

  /// Seuil d'alerte de stock configuré pour un bien (RG-XX-05).
  ///
  /// In fr, this message translates to:
  /// **'Seuil d\'alerte : {seuil}'**
  String patrimoineSeuilAlerte(int seuil);

  /// Date de démarrage affichée sur la fiche d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Démarrée le {date}'**
  String patrimoineCampagneDemarreeLe(String date);

  /// Date de clôture affichée sur la fiche d'une campagne d'inventaire.
  ///
  /// In fr, this message translates to:
  /// **'Clôturée le {date}'**
  String patrimoineCampagneClotureeLe(String date);

  /// Titre de l'écran de consultation comptable (Module XXI) et libellé du bouton d'accès depuis la fiche nœud.
  ///
  /// In fr, this message translates to:
  /// **'Comptabilité'**
  String get comptabiliteTitre;

  /// Onglet de consultation du solde de caisse du jour (écran mobile 1 du Cahier, RG-XXI-01).
  ///
  /// In fr, this message translates to:
  /// **'Caisse'**
  String get comptabiliteOngletCaisse;

  /// Onglet du journal des écritures récentes (écran mobile 2 du Cahier, RG-XXI-01/02).
  ///
  /// In fr, this message translates to:
  /// **'Écritures'**
  String get comptabiliteOngletEcritures;

  /// Onglet du rapport financier rapide (écran mobile 3 du Cahier, RG-XXI-06).
  ///
  /// In fr, this message translates to:
  /// **'Rapport'**
  String get comptabiliteOngletRapport;

  /// Étiquette du solde de caisse affiché dans l'onglet Caisse.
  ///
  /// In fr, this message translates to:
  /// **'Solde de caisse du jour'**
  String get comptabiliteSoldeCaisseDuJour;

  /// Message affiché quand le journal des écritures d'un nœud est vide.
  ///
  /// In fr, this message translates to:
  /// **'Aucune écriture enregistrée.'**
  String get comptabiliteAucuneEcriture;

  /// Message affiché dans le rapport financier rapide quand toutes les périodes comptables sont clôturées.
  ///
  /// In fr, this message translates to:
  /// **'Aucune période comptable ouverte.'**
  String get comptabiliteAucunePeriodeOuverte;

  /// Étiquette précédant le montant débité d'une ligne d'écriture comptable.
  ///
  /// In fr, this message translates to:
  /// **'Débit'**
  String get comptabiliteDebit;

  /// Étiquette précédant le montant crédité d'une ligne d'écriture comptable.
  ///
  /// In fr, this message translates to:
  /// **'Crédit'**
  String get comptabiliteCredit;

  /// Étiquette du total des recettes dans le rapport financier rapide.
  ///
  /// In fr, this message translates to:
  /// **'Recettes'**
  String get comptabiliteRapportRecettes;

  /// Étiquette du total des dépenses dans le rapport financier rapide.
  ///
  /// In fr, this message translates to:
  /// **'Dépenses'**
  String get comptabiliteRapportDepenses;

  /// Étiquette du solde net (recettes moins dépenses) dans le rapport financier rapide.
  ///
  /// In fr, this message translates to:
  /// **'Solde net'**
  String get comptabiliteRapportSoldeNet;

  /// Titre de l'écran Catalogue médiathèque (Module XIII) et libellé de la tuile du tableau de bord.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue médiathèque'**
  String get mediathequeCatalogueTitre;

  /// Libellé du champ de recherche thématique du catalogue médiathèque (RG-XIII-01).
  ///
  /// In fr, this message translates to:
  /// **'Rechercher par thème'**
  String get mediathequeRechercheTheme;

  /// Message affiché quand le catalogue médiathèque est vide.
  ///
  /// In fr, this message translates to:
  /// **'Aucun contenu publié pour le moment.'**
  String get mediathequeAucunContenu;

  /// Message affiché quand la recherche par thème (RG-XIII-01) ne retourne aucun contenu.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat pour cette recherche.'**
  String get mediathequeAucunResultat;

  /// Titre de l'écran de fiche détaillée d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Fiche contenu'**
  String get mediathequeFicheTitre;

  /// Message affiché quand la fiche d'un contenu médiathèque référence un identifiant inexistant.
  ///
  /// In fr, this message translates to:
  /// **'Ce contenu est introuvable (ou plus disponible).'**
  String get mediathequeContenuIntrouvable;

  /// Étiquette du type d'un contenu médiathèque (audio, vidéo, podcast, e-book, magazine, document).
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get mediathequeChampType;

  /// Étiquette du thème d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get mediathequeChampTheme;

  /// Étiquette des mots-clés d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Mots-clés'**
  String get mediathequeChampMotsCles;

  /// Étiquette de l'intervenant d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Intervenant'**
  String get mediathequeChampIntervenant;

  /// Étiquette de la date d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get mediathequeChampDate;

  /// Étiquette de la référence texte (URL) vers le fichier d'un contenu médiathèque — aucun fichier réel n'est géré dans cette itération.
  ///
  /// In fr, this message translates to:
  /// **'Lien du fichier'**
  String get mediathequeChampFichier;

  /// Étiquette du compteur de consultations d'un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Consultations'**
  String get mediathequeChampConsultations;

  /// Libellé du sélecteur de fidèle actif pour les favoris/commentaires/signalements de la médiathèque, en l'absence de session réelle (RG-SEC-01 non construit).
  ///
  /// In fr, this message translates to:
  /// **'Agir en tant que'**
  String get mediathequeEnTantQue;

  /// Libellé du bouton pour ajouter un contenu médiathèque aux favoris (RG-XIII-04).
  ///
  /// In fr, this message translates to:
  /// **'Ajouter aux favoris'**
  String get mediathequeAjouterFavori;

  /// Libellé du bouton pour retirer un contenu médiathèque des favoris (RG-XIII-04).
  ///
  /// In fr, this message translates to:
  /// **'Retirer des favoris'**
  String get mediathequeRetirerFavori;

  /// Titre de la section commentaires d'un contenu médiathèque (RG-XIII-03).
  ///
  /// In fr, this message translates to:
  /// **'Commentaires'**
  String get mediathequeCommentairesTitre;

  /// Message affiché quand aucun commentaire visible n'existe encore sur un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Aucun commentaire pour le moment.'**
  String get mediathequeAucunCommentaire;

  /// Étiquette affichée sur un commentaire dont le statut est en attente de modération a priori (RG-XIII-03).
  ///
  /// In fr, this message translates to:
  /// **'En attente de modération'**
  String get mediathequeCommentaireEnAttente;

  /// Infobulle du bouton de signalement d'un commentaire de la médiathèque (RG-XIII-03).
  ///
  /// In fr, this message translates to:
  /// **'Signaler'**
  String get mediathequeSignalerCommentaire;

  /// Étiquette du champ de saisie d'un nouveau commentaire sur un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Votre commentaire'**
  String get mediathequeChampCommentaire;

  /// Libellé du bouton de dépôt d'un commentaire sur un contenu médiathèque.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get mediathequeCommentaireAjouterBouton;

  /// Titre de l'écran des favoris médiathèque d'un fidèle (écran mobile 4, RG-XIII-04) et libellé du bouton d'accès depuis sa fiche.
  ///
  /// In fr, this message translates to:
  /// **'Favoris médiathèque'**
  String get mediathequeFavorisTitre;

  /// Message affiché quand la liste des favoris médiathèque d'un fidèle est vide.
  ///
  /// In fr, this message translates to:
  /// **'Aucun contenu favori pour le moment.'**
  String get mediathequeFavorisAucun;
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
