// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ecclesias360';

  @override
  String get homeWelcome => 'Welcome to Ecclesias360';

  @override
  String get comiteAjouterDecisionTitre => 'Add a decision';

  @override
  String get comiteAjouterErratumBouton => 'Add a correction';

  @override
  String get comiteAjouterTacheBouton => 'Add a task';

  @override
  String get comiteAjouterTacheTitre => 'Add a follow-up task';

  @override
  String get comiteAucunMembre => 'No members appointed yet.';

  @override
  String get comiteAucuneDecision => 'No decisions yet.';

  @override
  String get comiteAucuneSeance => 'No meetings recorded yet.';

  @override
  String get comiteBoutonNommer => 'Appoint';

  @override
  String get comiteChampAssigneA => 'Assigned to';

  @override
  String get comiteChampBrouillonPv => 'Minutes draft';

  @override
  String get comiteChampDate => 'Date';

  @override
  String get comiteChampFonction => 'Role (e.g. Pastor, Deacon)';

  @override
  String get comiteChampLibelle => 'Label';

  @override
  String get comiteChampNouvelErratum => 'New correction';

  @override
  String get comiteChampOrdreDuJour => 'Agenda';

  @override
  String get comiteChampPorteeDisciplinaire => 'Disciplinary scope (Module X)';

  @override
  String get comiteChampResultatVote => 'Vote result (e.g. 5 for, 1 against)';

  @override
  String get comiteCloreMandatTooltip => 'End the term';

  @override
  String get comiteDecisionsTitre => 'Decisions';

  @override
  String get comiteEnregistrerBrouillon => 'Save the draft';

  @override
  String get comiteEnregistrerSeance => 'Save the meeting';

  @override
  String get comiteErratumsTitre => 'Corrections';

  @override
  String comiteMembreActif(String fonction, String date) => '$fonction — since $date';

  @override
  String comiteMembreClos(String fonction) => '$fonction (term ended)';

  @override
  String get comiteMembresTitre => 'Committee members';

  @override
  String get comiteNommerMembreTitre => 'Appoint a committee member';

  @override
  String get comiteNommerMembreTooltip => 'Appoint a member';

  @override
  String get comiteNouvelleSeanceTitre => 'New meeting';

  @override
  String get comitePresentsTitre => 'Attendees';

  @override
  String get comiteProcesVerbalTitre => 'Minutes';

  @override
  String get comitePvValideEtImmuable => 'These minutes are validated and immutable.';

  @override
  String get comiteQuorumAtteint => 'Quorum reached';

  @override
  String get comiteQuorumNonAtteint => 'Quorum not reached';

  @override
  String get comiteQuorumNonConfigure => 'Quorum not configured';

  @override
  String get comiteSeanceIntrouvableCorps => 'This meeting does not exist (anymore).';

  @override
  String get comiteSeanceTitre => 'Meeting';

  @override
  String get comiteSeancesTitre => 'Committee meetings';

  @override
  String get comiteTachesDeSuiviTitre => 'Follow-up tasks';

  @override
  String get comiteValiderPv => 'Validate (immutable)';

  @override
  String get commonAjouter => 'Add';

  @override
  String get commonAnnuler => 'Cancel';

  @override
  String get commonCreer => 'Create';

  @override
  String get commonDescription => 'Description';

  @override
  String get commonEnregistrer => 'Save';

  @override
  String get commonFidele => 'Member';

  @override
  String get commonOui => 'yes';

  @override
  String get dashboardModulesTitre => 'Modules';

  @override
  String get fideleActionArchiver => 'Archive (RG-II-08)';

  @override
  String get fideleActionCompetences => 'Professional skills';

  @override
  String get fideleActionDons => 'Spiritual gifts';

  @override
  String get fideleActionGroupes => 'Church groups';

  @override
  String get fideleAjouterLienBouton => 'Add a tie';

  @override
  String get fideleAjouterLienTitre => 'Add a family tie';

  @override
  String get fideleAjouterTuteurBouton => 'Add a guardian';

  @override
  String get fideleAjouterTuteurTitre => 'Add a guardian (third party)';

  @override
  String get fideleChampAdresse => 'Address';

  @override
  String get fideleChampDateNaissance => 'Date of birth';

  @override
  String get fideleChampEmail => 'Email';

  @override
  String get fideleChampLienTuteur => 'Relationship (e.g. father)';

  @override
  String get fideleChampMineur => 'Minor';

  @override
  String get fideleChampNoeud => 'Organizational node';

  @override
  String get fideleChampNoeudErreur => 'Choose an organizational node.';

  @override
  String get fideleChampNom => 'Last name';

  @override
  String get fideleChampNomErreur => 'Last name is required.';

  @override
  String get fideleChampNomTuteur => 'Guardian\'s name';

  @override
  String get fideleChampPrenoms => 'First names';

  @override
  String get fideleChampPrenomsErreur => 'First names are required.';

  @override
  String get fideleChampSexe => 'Sex';

  @override
  String get fideleChampSexeErreur => 'Choose a sex.';

  @override
  String get fideleChampStatutCivil => 'Marital status';

  @override
  String get fideleChampStatutCivilErreur => 'Choose a marital status.';

  @override
  String get fideleChampTelephone => 'Phone';

  @override
  String get fideleCheminementTitre => 'Spiritual journey';

  @override
  String fideleDateNaissanceValeur(String date) => 'Date of birth: $date';

  @override
  String get fideleHistoriqueAucune => 'No changes recorded yet.';

  @override
  String fideleHistoriqueTitre(String nom) => 'History — $nom';

  @override
  String get fideleHistoriqueTooltip => 'Change history';

  @override
  String get fideleIntrouvableCorps => 'This member does not exist (anymore).';

  @override
  String get fideleIntrouvableTitre => 'Member not found';

  @override
  String get fideleLiensFamiliauxTitre => 'Family ties';

  @override
  String get fideleModifierCoordonnees => 'Edit contact details';

  @override
  String get fideleStatutActuel => 'Current status';

  @override
  String get fideleStatutDisciplineNote => 'This status can only be changed from the Discipline module (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) => '→ $cible';

  @override
  String get fideleTuteurLegalTitre => 'Legal guardian (RG-II-06)';

  @override
  String get fidelesAucun => 'No members registered yet.';

  @override
  String get fidelesCreerAction => 'Create a member';

  @override
  String get fidelesRechercherIndice => 'Search a member (last or first name)';

  @override
  String get fidelesTitre => 'Members';

  @override
  String get moduleDonsReferentiel => 'Spiritual gifts reference';

  @override
  String get moduleGroupesEglise => 'Church groups';

  @override
  String get moduleMandatsEcheance => 'Terms coming due';

  @override
  String get moduleOrganisation => 'Organization';

  @override
  String get moduleProfessions => 'Professional groups';

  @override
  String get moduleRoles => 'Roles';

  @override
  String get moduleZonesGeographiques => 'Geographic zones';

  @override
  String get navAccueil => 'Home';

  @override
  String get parametresTitre => 'Settings';
}
