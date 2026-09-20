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
  String get comiteChampPorteeDisciplinaire => 'Portée disciplinaire (Module X)';

  @override
  String get comiteChampResultatVote => 'Résultat du vote (ex. 5 pour, 1 contre)';

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
  String comiteMembreActif(String fonction, String date) => '$fonction — depuis le $date';

  @override
  String comiteMembreClos(String fonction) => '$fonction (mandat clos)';

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
  String get comitePvValideEtImmuable => 'Ce procès-verbal est validé et immuable.';

  @override
  String get comiteQuorumAtteint => 'Quorum atteint';

  @override
  String get comiteQuorumNonAtteint => 'Quorum non atteint';

  @override
  String get comiteQuorumNonConfigure => 'Quorum non configuré';

  @override
  String get comiteSeanceIntrouvableCorps => 'Cette séance n\'existe pas (ou plus).';

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
  String fideleDateNaissanceValeur(String date) => 'Date de naissance : $date';

  @override
  String get fideleHistoriqueAucune => 'Aucune modification historisée.';

  @override
  String fideleHistoriqueTitre(String nom) => 'Historique — $nom';

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
  String get fideleStatutDisciplineNote => 'Ce statut ne peut être modifié que depuis le module Discipline (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) => '→ $cible';

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
}
