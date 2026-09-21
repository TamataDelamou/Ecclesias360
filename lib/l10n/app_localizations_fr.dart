// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Ecclésias360';

  @override
  String get homeWelcome => 'Bienvenue sur Ecclésias360';

  @override
  String get archivageAucunDansCorbeille => 'Corbeille vide.';

  @override
  String get archivageAucunDocument => 'Aucun document archivé.';

  @override
  String get archivageBibliothequeTitre => 'Documents archivés';

  @override
  String get archivageChampReferenceFichier =>
      'Référence du fichier (nom, lien...)';

  @override
  String get archivageCorbeilleTitre => 'Corbeille';

  @override
  String get archivageDetailTitre => 'Document archivé';

  @override
  String get archivageDocumentIntrouvable =>
      'Ce document est introuvable (ou a été purgé).';

  @override
  String get archivageMettreEnCorbeilleBouton => 'Mettre en corbeille';

  @override
  String archivageMiseCorbeilleLe(String date) {
    return 'Mis en corbeille le $date';
  }

  @override
  String get archivageNiveauRestreint => 'Restreint';

  @override
  String get archivageNiveauStandard => 'Standard';

  @override
  String get archivageNouvelleVersionBouton => 'Nouvelle version';

  @override
  String get archivageNouvelleVersionTitre => 'Ajouter une nouvelle version';

  @override
  String get archivageOrigineLabel => 'Origine';

  @override
  String archivagePurgeableApres(String date) {
    return 'Purgeable à partir du $date';
  }

  @override
  String get archivagePurgerBouton => 'Purger définitivement';

  @override
  String get archivagePurgerConfirmationMessage =>
      'Cette action est irréversible : le document et toutes ses versions seront supprimés.';

  @override
  String get archivagePurgerConfirmationTitre =>
      'Purger définitivement ce document ?';

  @override
  String get archivageRechercheLabel => 'Rechercher un document (numéro, type)';

  @override
  String get archivageRestaurerBouton => 'Restaurer';

  @override
  String archivageVersionLabel(int numero) {
    return 'Version $numero';
  }

  @override
  String get archivageVersionsTitre => 'Historique des versions';

  @override
  String get deplacementsAucunDeplacement => 'Aucun déplacement enregistré.';

  @override
  String get deplacementsAucuneMutation => 'Aucune mutation.';

  @override
  String get deplacementsChampFidele => 'Fidèle';

  @override
  String get deplacementsChampMotif => 'Motif';

  @override
  String get deplacementsChampMotifRefus => 'Motif du refus (optionnel)';

  @override
  String get deplacementsChampNoeudDestination => 'Église de destination';

  @override
  String get deplacementsCoteDestinationLabel => 'Église de destination';

  @override
  String get deplacementsCoteOrigineLabel => 'Église d\'origine';

  @override
  String get deplacementsDateDemandeLabel => 'Demandée le';

  @override
  String get deplacementsDateValidationLabel => 'Validée le';

  @override
  String get deplacementsDemanderTitre => 'Demander une mutation';

  @override
  String get deplacementsDetailTitre => 'Mutation';

  @override
  String get deplacementsHistoriqueTitre => 'Historique des déplacements';

  @override
  String get deplacementsIntrouvable => 'Cette mutation est introuvable.';

  @override
  String get deplacementsMotifLabel => 'Motif';

  @override
  String get deplacementsRefuserBouton => 'Refuser';

  @override
  String get deplacementsRefuserTitre => 'Refuser cette mutation ?';

  @override
  String get deplacementsStatutEnAttente => 'En attente';

  @override
  String get deplacementsStatutRefusee => 'Refusée';

  @override
  String get deplacementsStatutValidee => 'Validée';

  @override
  String get deplacementsTitre => 'Mutations';

  @override
  String get deplacementsValiderDestinationBouton => 'Valider (destination)';

  @override
  String get deplacementsValiderOrigineBouton => 'Valider (origine)';

  @override
  String get deplacementsVoirLettreBouton => 'Voir la lettre de recommandation';

  @override
  String get comiteAjouterDecisionTitre => 'Ajouter une décision';

  @override
  String get comiteAjouterErratumBouton => 'Ajouter un erratum';

  @override
  String get comiteAjouterTacheBouton => 'Ajouter une tâche';

  @override
  String get comiteAjouterTacheTitre => 'Ajouter une tâche de suivi';

  @override
  String get comiteAucunMembre => 'Aucun membre nommé.';

  @override
  String get comiteAucuneDecision => 'Aucune décision.';

  @override
  String get comiteAucuneSeance => 'Aucune séance enregistrée.';

  @override
  String get comiteBoutonNommer => 'Nommer';

  @override
  String get comiteChampAssigneA => 'Assignée à';

  @override
  String get comiteChampBrouillonPv => 'Brouillon du procès-verbal';

  @override
  String get comiteChampDate => 'Date';

  @override
  String get comiteChampFonction => 'Fonction (ex. Pasteur, Diacre)';

  @override
  String get comiteChampLibelle => 'Libellé';

  @override
  String get comiteChampNouvelErratum => 'Nouvel erratum';

  @override
  String get comiteChampOrdreDuJour => 'Ordre du jour';

  @override
  String get comiteChampPorteeDisciplinaire =>
      'Portée disciplinaire (Module X)';

  @override
  String get comiteChampResultatVote =>
      'Résultat du vote (ex. 5 pour, 1 contre)';

  @override
  String get comiteCloreMandatTooltip => 'Clore le mandat';

  @override
  String get comiteDecisionsTitre => 'Décisions';

  @override
  String get comiteEnregistrerBrouillon => 'Enregistrer le brouillon';

  @override
  String get comiteEnregistrerSeance => 'Enregistrer la séance';

  @override
  String get comiteErratumsTitre => 'Erratums';

  @override
  String comiteMembreActif(String fonction, String date) {
    return '$fonction — depuis le $date';
  }

  @override
  String comiteMembreClos(String fonction) {
    return '$fonction (mandat clos)';
  }

  @override
  String get comiteMembresTitre => 'Membres du comité';

  @override
  String get comiteNommerMembreTitre => 'Nommer un membre du comité';

  @override
  String get comiteNommerMembreTooltip => 'Nommer un membre';

  @override
  String get comiteNouvelleSeanceTitre => 'Nouvelle séance';

  @override
  String get comitePresentsTitre => 'Présents';

  @override
  String get comiteProcesVerbalTitre => 'Procès-verbal';

  @override
  String get comitePvValideEtImmuable =>
      'Ce procès-verbal est validé et immuable.';

  @override
  String get comiteQuorumAtteint => 'Quorum atteint';

  @override
  String get comiteQuorumNonAtteint => 'Quorum non atteint';

  @override
  String get comiteQuorumNonConfigure => 'Quorum non configuré';

  @override
  String get comiteSeanceIntrouvableCorps =>
      'Cette séance n\'existe pas (ou plus).';

  @override
  String get comiteSeanceTitre => 'Séance';

  @override
  String get comiteSeancesTitre => 'Séances du comité';

  @override
  String get comiteTachesDeSuiviTitre => 'Tâches de suivi';

  @override
  String get comiteValiderPv => 'Valider (immuable)';

  @override
  String get commonAjouter => 'Ajouter';

  @override
  String get commonAnnuler => 'Annuler';

  @override
  String get commonCreer => 'Créer';

  @override
  String get commonDescription => 'Description';

  @override
  String get commonEnregistrer => 'Enregistrer';

  @override
  String get commonFidele => 'Fidèle';

  @override
  String get commonOui => 'oui';

  @override
  String get culteAjouterSequenceBouton => 'Ajouter une séquence';

  @override
  String get culteAjouterSequenceTitre => 'Ajouter une séquence';

  @override
  String get culteAucunPredicateur => 'Aucun';

  @override
  String get culteAucuneSequence => 'Aucune séquence.';

  @override
  String get culteChampAudioUrl => 'Lien audio';

  @override
  String get culteChampCompteGlobal => 'Compte global de présence';

  @override
  String get culteChampDateHeure => 'Date et heure';

  @override
  String get culteChampDureeMinutes => 'Durée prévue (minutes)';

  @override
  String get culteChampLibelleSequence => 'Libellé (ex. Louange, Prédication)';

  @override
  String get culteChampModePresence => 'Mode de présence';

  @override
  String get culteChampNombreOccurrences => 'Nombre d\'occurrences';

  @override
  String get culteChampOrdre => 'Ordre';

  @override
  String get culteChampPdfUrl => 'Lien PDF';

  @override
  String get culteChampPredicateur => 'Prédicateur (optionnel)';

  @override
  String get culteChampRecurrent => 'Créer une série récurrente (hebdomadaire)';

  @override
  String get culteChampResponsable => 'Responsable (optionnel)';

  @override
  String get culteChampTexteBiblique => 'Texte biblique';

  @override
  String get culteChampTheme => 'Thème (optionnel)';

  @override
  String get culteChampType => 'Type de culte (ex. Culte dominical)';

  @override
  String get culteChampTypeErreur => 'Le type de culte est requis.';

  @override
  String get culteChampVideoUrl => 'Lien vidéo';

  @override
  String get culteDateHeureChoisir => 'Choisir la date et l\'heure';

  @override
  String get culteEnregistrerCompte => 'Enregistrer le compte';

  @override
  String get culteLiturgieTitre => 'Liturgie';

  @override
  String get culteModePresenceGlobal => 'Global (compte total)';

  @override
  String get culteModePresenceNominal => 'Nominal (par fidèle)';

  @override
  String get culteNonPublie => 'Aucune publication pour ce culte.';

  @override
  String get cultePresencesTitre => 'Présences';

  @override
  String get cultePublicationTitre => 'Publication post-culte';

  @override
  String cultePublieLe(String date) {
    return 'Publié le $date';
  }

  @override
  String get cultePublierBouton => 'Publier';

  @override
  String get culteStatutTitre => 'Statut';

  @override
  String get cultesAucun => 'Aucun culte enregistré.';

  @override
  String get cultesNouveauTooltip => 'Nouveau culte';

  @override
  String get cultesTitre => 'Cultes';

  @override
  String get dashboardModulesTitre => 'Modules';

  @override
  String get fideleActionArchiver => 'Archiver (RG-II-08)';

  @override
  String get fideleActionCompetences => 'Compétences professionnelles';

  @override
  String get fideleActionDons => 'Dons spirituels';

  @override
  String get fideleActionGroupes => 'Groupes de l\'Église';

  @override
  String get fideleAjouterLienBouton => 'Ajouter un lien';

  @override
  String get fideleAjouterLienTitre => 'Ajouter un lien familial';

  @override
  String get fideleAjouterTuteurBouton => 'Ajouter un tuteur';

  @override
  String get fideleAjouterTuteurTitre => 'Ajouter un tuteur (tiers)';

  @override
  String get fideleChampAdresse => 'Adresse';

  @override
  String get fideleChampDateNaissance => 'Date de naissance';

  @override
  String get fideleChampEmail => 'Email';

  @override
  String get fideleChampLienTuteur => 'Lien (ex. père)';

  @override
  String get fideleChampMineur => 'Mineur';

  @override
  String get fideleChampNoeud => 'Nœud d\'appartenance';

  @override
  String get fideleChampNoeudErreur => 'Choisissez un nœud d\'appartenance.';

  @override
  String get fideleChampNom => 'Nom';

  @override
  String get fideleChampNomErreur => 'Le nom est requis.';

  @override
  String get fideleChampNomTuteur => 'Nom du tuteur';

  @override
  String get fideleChampPrenoms => 'Prénoms';

  @override
  String get fideleChampPrenomsErreur => 'Les prénoms sont requis.';

  @override
  String get fideleChampSexe => 'Sexe';

  @override
  String get fideleChampSexeErreur => 'Choisissez un sexe.';

  @override
  String get fideleChampStatutCivil => 'Statut civil';

  @override
  String get fideleChampStatutCivilErreur => 'Choisissez un statut civil.';

  @override
  String get fideleChampTelephone => 'Téléphone';

  @override
  String get fideleCheminementTitre => 'Cheminement spirituel';

  @override
  String fideleDateNaissanceValeur(String date) {
    return 'Date de naissance : $date';
  }

  @override
  String get fideleHistoriqueAucune => 'Aucune modification historisée.';

  @override
  String fideleHistoriqueTitre(String nom) {
    return 'Historique — $nom';
  }

  @override
  String get fideleHistoriqueTooltip => 'Historique des modifications';

  @override
  String get fideleIntrouvableCorps => 'Ce fidèle n\'existe pas (ou plus).';

  @override
  String get fideleIntrouvableTitre => 'Fidèle introuvable';

  @override
  String get fideleLiensFamiliauxTitre => 'Liens familiaux';

  @override
  String get fideleModifierCoordonnees => 'Modifier les coordonnées';

  @override
  String get fideleStatutActuel => 'Statut actuel';

  @override
  String get fideleStatutDisciplineNote =>
      'Ce statut ne peut être modifié que depuis le module Discipline (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) {
    return '→ $cible';
  }

  @override
  String get fideleTuteurLegalTitre => 'Tuteur légal (RG-II-06)';

  @override
  String get fidelesAucun => 'Aucun fidèle enregistré.';

  @override
  String get fidelesCreerAction => 'Créer un fidèle';

  @override
  String get fidelesRechercherIndice => 'Rechercher un fidèle (nom ou prénoms)';

  @override
  String get fidelesTitre => 'Fidèles';

  @override
  String get moduleDonsReferentiel => 'Référentiel des dons spirituels';

  @override
  String get moduleGroupesEglise => 'Groupes de l\'Église';

  @override
  String get moduleMandatsEcheance => 'Mandats arrivant à échéance';

  @override
  String get moduleOrganisation => 'Organisation';

  @override
  String get moduleProfessions => 'Groupes professionnels';

  @override
  String get moduleRoles => 'Rôles';

  @override
  String get moduleZonesGeographiques => 'Zones géographiques';

  @override
  String get navAccueil => 'Accueil';

  @override
  String get parametresTitre => 'Paramètres';

  @override
  String get propositionChampExplication => 'Brève explication (optionnelle)';

  @override
  String get propositionChampTitre => 'Titre';

  @override
  String get propositionSoumettreTitre => 'Soumettre une proposition de thème';

  @override
  String get propositionSoumettreTooltip => 'Soumettre une proposition';

  @override
  String get propositionsAucune => 'Aucune proposition soumise.';

  @override
  String get propositionsThemeTitre => 'Propositions de thème';

  @override
  String get propositionsVoterEnTantQue => 'Voter/soumettre en tant que';

  @override
  String get disciplineTitre => 'Dossiers disciplinaires';

  @override
  String get disciplineHistoriqueTitre =>
      'Historique disciplinaire confidentiel';

  @override
  String get disciplineAucunDossier => 'Aucun dossier disciplinaire.';

  @override
  String get disciplineAucunDossierFidele =>
      'Aucun dossier disciplinaire pour ce fidèle.';

  @override
  String get disciplineOuvrirTooltip => 'Ouvrir un dossier';

  @override
  String get disciplineOuvrirTitre => 'Ouvrir un dossier disciplinaire';

  @override
  String get disciplineChampFideleMisEnCause => 'Fidèle mis en cause';

  @override
  String get disciplineChampNatureFaute => 'Nature de la faute';

  @override
  String get disciplineChampRoleActeur => 'Rôle agissant';

  @override
  String get disciplineChampActeur =>
      'Ouvert par (optionnel — membre de commission)';

  @override
  String get disciplineActeurAucun => 'Aucun';

  @override
  String get disciplineStatutEnInstruction => 'En instruction';

  @override
  String get disciplineStatutSanctionne => 'Sanctionné';

  @override
  String get disciplineStatutClos => 'Clos';

  @override
  String disciplineAlerteFinDePeriode(String date) {
    return 'Réintégration prévue le $date';
  }

  @override
  String get disciplineAlerteRevuePeriodique => 'Revue périodique nécessaire';

  @override
  String get disciplineDetailTitre => 'Dossier disciplinaire';

  @override
  String get disciplineIntrouvable =>
      'Ce dossier disciplinaire est introuvable.';

  @override
  String disciplineOuvertLe(String date) {
    return 'Ouvert le $date';
  }

  @override
  String get disciplineCommissionTitre => 'Commission instructrice';

  @override
  String get disciplineCommissionAucune => 'Aucune commission assignée.';

  @override
  String get disciplineCommissionAssignerBouton => 'Assigner une commission';

  @override
  String get disciplineCommissionAssignerTitre => 'Assigner une commission';

  @override
  String get disciplineCommissionCreerBouton => 'Créer une nouvelle commission';

  @override
  String get disciplineCommissionCreerTitre => 'Créer une commission';

  @override
  String get disciplineChampNomCommission => 'Nom de la commission';

  @override
  String get disciplineCommissionMembresTitre => 'Membres de la commission';

  @override
  String get disciplineCommissionAjouterMembreTooltip => 'Ajouter un membre';

  @override
  String get disciplinePiecesTitre => 'Pièces du dossier';

  @override
  String get disciplinePiecesAucune => 'Aucune pièce versée.';

  @override
  String get disciplinePieceAjouterTooltip => 'Ajouter une pièce';

  @override
  String get disciplinePieceAjouterTitre => 'Ajouter une pièce';

  @override
  String get disciplinePieceChampNature => 'Nature de la pièce';

  @override
  String get disciplinePieceNatureTemoignage => 'Témoignage';

  @override
  String get disciplinePieceNaturePreuve => 'Preuve';

  @override
  String get disciplinePieceChampContenu => 'Contenu (texte)';

  @override
  String get disciplineDecisionTitre => 'Décision';

  @override
  String get disciplineChampDecision => 'Décision motivée';

  @override
  String get disciplineChampDureeSanction =>
      'Durée de la sanction en jours (vide = indéterminée)';

  @override
  String get disciplineChampSuspendreMinisteres =>
      'Suspendre les affectations ministérielles actives';

  @override
  String get disciplinePrononcerBouton => 'Prononcer la décision';

  @override
  String disciplineDecisionRendueLe(String date) {
    return 'Décision rendue le $date';
  }

  @override
  String get disciplineCloturerBouton => 'Clôturer / Réintégrer';

  @override
  String get disciplineDossierClosNote =>
      'Dossier clos — le fidèle a retrouvé son statut antérieur.';

  @override
  String get disciplineDureeIndeterminee => 'Durée indéterminée';

  @override
  String disciplineDureeJours(int jours) {
    return '$jours jour(s)';
  }

  @override
  String get financesTitre => 'Contributions';

  @override
  String get financesHistoriqueTitre => 'Historique des contributions';

  @override
  String get financesAucuneContribution => 'Aucune contribution saisie.';

  @override
  String get financesAucuneContributionFidele =>
      'Aucune contribution pour ce fidèle.';

  @override
  String get financesSaisirTooltip => 'Saisir une offrande';

  @override
  String get financesSaisirTitre => 'Saisir une offrande';

  @override
  String get financesChampDonateur => 'Donateur';

  @override
  String get financesDonateurAnonyme => 'Donateur anonyme';

  @override
  String get financesChampLibelleDonateurAnonyme =>
      'Libellé du donateur anonyme (optionnel)';

  @override
  String get financesChampTypeOffrande => 'Type d\'offrande';

  @override
  String get financesChampMontant => 'Montant';

  @override
  String get financesChampModePaiement => 'Mode de paiement';

  @override
  String get financesModePaiementEspeces => 'Espèces';

  @override
  String get financesModePaiementMobileMoney => 'Mobile money';

  @override
  String get financesModePaiementVirement => 'Virement';

  @override
  String get financesSaisirBouton => 'Saisir';

  @override
  String get financesRapportParTypeTitre => 'Répartition par type d\'offrande';

  @override
  String get financesStatutEnAttente => 'En attente';

  @override
  String get financesStatutValidee => 'Validée';

  @override
  String get financesStatutRejetee => 'Rejetée';

  @override
  String get financesTresoriersTitre => 'Trésoriers désignés';

  @override
  String get financesTresoriersAucun => 'Aucun trésorier désigné.';

  @override
  String get financesTresorierDesignerTitre => 'Désigner un trésorier';

  @override
  String get financesTresorierDesignerBouton => 'Désigner';

  @override
  String get financesTresorierDesignerTooltip => 'Désigner un trésorier';

  @override
  String financesTresorierDepuis(String date) {
    return 'Trésorier depuis le $date';
  }

  @override
  String get financesTresorierRetirerTooltip => 'Retirer la désignation';

  @override
  String get financesRecuTitre => 'Reçu de contribution';

  @override
  String get financesIntrouvable => 'Cette contribution est introuvable.';

  @override
  String get financesValiderTitre => 'Valider la contribution';

  @override
  String get financesChampRoleActeur => 'Rôle agissant';

  @override
  String get financesChampValidePar => 'Validé par';

  @override
  String get financesValiderBouton => 'Valider';

  @override
  String get financesRejeterTitre => 'Rejeter la contribution';

  @override
  String get financesChampMotif => 'Motif';

  @override
  String get financesRejeterBouton => 'Rejeter';

  @override
  String get financesContrePasserTitre => 'Contre-passer la contribution';

  @override
  String get financesContrePasserBouton => 'Contre-passer';

  @override
  String financesSaisieLe(String date) {
    return 'Saisie le $date';
  }

  @override
  String financesValideeLe(String date) {
    return 'Validée le $date';
  }

  @override
  String get financesEstContrePassation =>
      'Cette contribution est une contre-passation.';

  @override
  String get financesProjetsTitre => 'Projets';

  @override
  String get financesProjetsAucun => 'Aucun projet.';

  @override
  String get financesProjetCreerTitre => 'Créer un projet';

  @override
  String get financesProjetCreerTooltip => 'Créer un projet';

  @override
  String get financesChampNomProjet => 'Nom du projet';

  @override
  String get financesChampBudgetPrevisionnel => 'Budget prévisionnel';

  @override
  String financesProjetSoldeSurBudget(int solde, int budget, String devise) {
    return 'Solde : $solde $devise / budget $budget $devise';
  }

  @override
  String get financesProjetDetailTitre => 'Fiche projet';

  @override
  String get financesProjetIntrouvable => 'Ce projet est introuvable.';

  @override
  String get financesDepenseAjouterTitre => 'Ajouter une dépense';

  @override
  String get financesDepenseAjouterBouton => 'Ajouter une dépense';

  @override
  String get financesChampLibelleDepense => 'Libellé de la dépense';

  @override
  String get financesChampDerogationTracee =>
      'Dérogation tracée (dépasse le solde disponible)';

  @override
  String get financesDepensesTitre => 'Dépenses';

  @override
  String get financesDepensesAucune => 'Aucune dépense engagée.';

  @override
  String financesDepenseDerogation(String date) {
    return '$date — dérogation tracée';
  }

  @override
  String get financesEngagementsTitre => 'Engagements et échéances';

  @override
  String get financesEngagementsAucun => 'Aucun engagement.';

  @override
  String get financesEngagementCreerTitre => 'Créer un engagement';

  @override
  String get financesEngagementCreerTooltip => 'Créer un engagement';

  @override
  String get financesChampTypeEngagement => 'Type d\'engagement';

  @override
  String get financesTypeEngagementDime => 'Dîme';

  @override
  String get financesTypeEngagementPromesseDon => 'Promesse de don';

  @override
  String get financesChampMontantPrevu => 'Montant prévu';

  @override
  String get financesChampPeriodicite => 'Périodicité';

  @override
  String get financesPeriodiciteHebdomadaire => 'Hebdomadaire';

  @override
  String get financesPeriodiciteMensuelle => 'Mensuelle';

  @override
  String get financesPeriodiciteTrimestrielle => 'Trimestrielle';

  @override
  String get financesPeriodiciteAnnuelle => 'Annuelle';

  @override
  String financesEngagementPeriodicite(String periodicite) {
    return 'Périodicité : $periodicite';
  }

  @override
  String get financesEcheanceEnAttente => 'En attente';

  @override
  String get financesEcheanceHonoree => 'Honorée';

  @override
  String get financesEcheanceEnRetard => 'En retard';

  @override
  String get financesEcheanceHonorerBouton => 'Honorer';

  @override
  String get patrimoineTitre => 'Biens';

  @override
  String get patrimoineCampagnesTitre => 'Campagnes d\'inventaire';

  @override
  String get patrimoineAjouterTooltip => 'Ajouter un bien';

  @override
  String get patrimoineAucunBien => 'Aucun bien enregistré.';

  @override
  String get patrimoineAlerteSeuilTitre =>
      'Biens sous le seuil d\'alerte de stock';

  @override
  String get patrimoineAjouterTitre => 'Ajouter un bien';

  @override
  String get patrimoineChampIdInventaire => 'Identifiant d\'inventaire';

  @override
  String get patrimoineChampCategorie => 'Catégorie';

  @override
  String get patrimoineChampDesignation => 'Désignation';

  @override
  String get patrimoineChampValeurAcquisition => 'Valeur d\'acquisition';

  @override
  String get patrimoineChampValeurVenale => 'Valeur vénale';

  @override
  String get patrimoineChampDateAcquisition => 'Date d\'acquisition';

  @override
  String get patrimoineChampSeuilAlerteStock => 'Seuil d\'alerte de stock';

  @override
  String get patrimoineEtatNeuf => 'Neuf';

  @override
  String get patrimoineEtatBon => 'Bon';

  @override
  String get patrimoineEtatAReparer => 'À réparer';

  @override
  String get patrimoineEtatHorsService => 'Hors service';

  @override
  String get patrimoineEtatCede => 'Cédé';

  @override
  String get patrimoineFicheTitre => 'Fiche du bien';

  @override
  String get patrimoineIntrouvable => 'Bien introuvable.';

  @override
  String get patrimoineSignalerEtatTitre => 'Signaler l\'état du bien';

  @override
  String get patrimoineChampEtat => 'État';

  @override
  String get patrimoineSignalerEtatBouton => 'Signaler l\'état';

  @override
  String get patrimoineSortirTitre => 'Sortir le bien du patrimoine';

  @override
  String get patrimoineChampTypeSortie => 'Type de sortie';

  @override
  String get patrimoineTypeSortieCession => 'Cession';

  @override
  String get patrimoineTypeSortieDon => 'Don';

  @override
  String get patrimoineTypeSortieMiseAuRebut => 'Mise au rebut';

  @override
  String get patrimoineChampRoleActeur => 'Rôle de l\'acteur';

  @override
  String get patrimoineChampValidePar => 'Validé par';

  @override
  String get patrimoineChampMotif => 'Motif';

  @override
  String get patrimoineSortirBouton => 'Sortir le bien';

  @override
  String get patrimoineReserverTitre => 'Réserver le bien';

  @override
  String get patrimoineChampObjetReservation => 'Objet de la réservation';

  @override
  String get patrimoineObjetCulte => 'Culte';

  @override
  String get patrimoineObjetEvenement => 'Événement';

  @override
  String get patrimoineObjetAutre => 'Autre';

  @override
  String get patrimoineAucunCultePourReservation =>
      'Aucun culte disponible pour ce nœud.';

  @override
  String get patrimoineChampCulte => 'Culte';

  @override
  String get patrimoineChampObjetLibre => 'Description de l\'objet';

  @override
  String get patrimoineChampDateDebut => 'Date de début';

  @override
  String get patrimoineChampDateFin => 'Date de fin';

  @override
  String get patrimoineReserverBouton => 'Réserver';

  @override
  String get patrimoineMouvementAjouterTitre => 'Ajouter un mouvement de stock';

  @override
  String get patrimoineChampTypeMouvement => 'Type de mouvement';

  @override
  String get patrimoineMouvementEntree => 'Entrée';

  @override
  String get patrimoineMouvementSortie => 'Sortie';

  @override
  String get patrimoineChampQuantite => 'Quantité';

  @override
  String get patrimoineStockTitre => 'Gestion de stock';

  @override
  String get patrimoineMouvementAjouterBouton => 'Ajouter un mouvement';

  @override
  String get patrimoineReservationsTitre => 'Réservations';

  @override
  String get patrimoineReservationsAucune => 'Aucune réservation enregistrée.';

  @override
  String get patrimoineCampagneDemarrerTooltip => 'Démarrer une campagne';

  @override
  String get patrimoineCampagnesAucune =>
      'Aucune campagne d\'inventaire enregistrée.';

  @override
  String get patrimoineCampagneEnCours => 'En cours';

  @override
  String get patrimoineCampagneCloturee => 'Clôturée';

  @override
  String get patrimoineCampagneDemarrerTitre =>
      'Démarrer une campagne d\'inventaire';

  @override
  String get patrimoineChampLibelleCampagne => 'Libellé de la campagne';

  @override
  String get patrimoineCampagneDemarrerBouton => 'Démarrer';

  @override
  String get patrimoineCampagneFicheTitre => 'Fiche de la campagne';

  @override
  String get patrimoineCampagneIntrouvable => 'Campagne introuvable.';

  @override
  String get patrimoineCampagneCloturerTitre => 'Clôturer la campagne';

  @override
  String get patrimoineCampagneCloturerConfirmation =>
      'Cette action est irréversible : aucun nouveau pointage ne pourra être enregistré.';

  @override
  String get patrimoineCampagneCloturerBouton => 'Clôturer la campagne';

  @override
  String get patrimoineCampagneAjouterPointageTitre => 'Ajouter un pointage';

  @override
  String get patrimoineChampBien => 'Bien';

  @override
  String get patrimoineChampEtatConstate => 'État constaté';

  @override
  String get patrimoineChampQuantiteConstatee => 'Quantité constatée';

  @override
  String get patrimoineChampCommentaire => 'Commentaire';

  @override
  String get patrimoineCampagneAjouterPointageBouton =>
      'Enregistrer le pointage';

  @override
  String get patrimoineCampagneAjouterPointageTooltip => 'Ajouter un pointage';

  @override
  String get patrimoineCampagnePointagesTitre => 'Pointages';

  @override
  String get patrimoineCampagnePointagesAucun => 'Aucun pointage enregistré.';

  @override
  String patrimoineAcquisLe(String date) {
    return 'Acquis le $date';
  }

  @override
  String patrimoineSortiLe(String date) {
    return 'Sorti le $date';
  }

  @override
  String patrimoineQuantiteActuelle(int quantite) {
    return 'Quantité actuelle : $quantite';
  }

  @override
  String patrimoineSeuilAlerte(int seuil) {
    return 'Seuil d\'alerte : $seuil';
  }

  @override
  String patrimoineCampagneDemarreeLe(String date) {
    return 'Démarrée le $date';
  }

  @override
  String patrimoineCampagneClotureeLe(String date) {
    return 'Clôturée le $date';
  }
}
