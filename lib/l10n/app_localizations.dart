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
