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
  String get archivageAucunDansCorbeille => 'Trash is empty.';

  @override
  String get archivageAucunDocument => 'No archived document.';

  @override
  String get archivageBibliothequeTitre => 'Archived documents';

  @override
  String get archivageChampReferenceFichier => 'File reference (name, link...)';

  @override
  String get archivageCorbeilleTitre => 'Trash';

  @override
  String get archivageDetailTitre => 'Archived document';

  @override
  String get archivageDocumentIntrouvable =>
      'This document could not be found (or was purged).';

  @override
  String get archivageMettreEnCorbeilleBouton => 'Move to trash';

  @override
  String archivageMiseCorbeilleLe(String date) {
    return 'Moved to trash on $date';
  }

  @override
  String get archivageNiveauRestreint => 'Restricted';

  @override
  String get archivageNiveauStandard => 'Standard';

  @override
  String get archivageNouvelleVersionBouton => 'New version';

  @override
  String get archivageNouvelleVersionTitre => 'Add a new version';

  @override
  String get archivageOrigineLabel => 'Origin';

  @override
  String archivagePurgeableApres(String date) {
    return 'Purgeable from $date';
  }

  @override
  String get archivagePurgerBouton => 'Purge permanently';

  @override
  String get archivagePurgerConfirmationMessage =>
      'This action cannot be undone: the document and all its versions will be deleted.';

  @override
  String get archivagePurgerConfirmationTitre =>
      'Permanently purge this document?';

  @override
  String get archivageRechercheLabel => 'Search a document (number, type)';

  @override
  String get archivageRestaurerBouton => 'Restore';

  @override
  String archivageVersionLabel(int numero) {
    return 'Version $numero';
  }

  @override
  String get archivageVersionsTitre => 'Version history';

  @override
  String get deplacementsAucunDeplacement => 'No mutation recorded.';

  @override
  String get deplacementsAucuneMutation => 'No mutations.';

  @override
  String get deplacementsChampFidele => 'Member';

  @override
  String get deplacementsChampMotif => 'Reason';

  @override
  String get deplacementsChampMotifRefus => 'Reason for rejection (optional)';

  @override
  String get deplacementsChampNoeudDestination => 'Destination church';

  @override
  String get deplacementsCoteDestinationLabel => 'Destination church';

  @override
  String get deplacementsCoteOrigineLabel => 'Origin church';

  @override
  String get deplacementsDateDemandeLabel => 'Requested on';

  @override
  String get deplacementsDateValidationLabel => 'Approved on';

  @override
  String get deplacementsDemanderTitre => 'Request a mutation';

  @override
  String get deplacementsDetailTitre => 'Mutation';

  @override
  String get deplacementsHistoriqueTitre => 'Mutation history';

  @override
  String get deplacementsIntrouvable => 'This mutation could not be found.';

  @override
  String get deplacementsMotifLabel => 'Reason';

  @override
  String get deplacementsRefuserBouton => 'Reject';

  @override
  String get deplacementsRefuserTitre => 'Reject this mutation?';

  @override
  String get deplacementsStatutEnAttente => 'Pending';

  @override
  String get deplacementsStatutRefusee => 'Rejected';

  @override
  String get deplacementsStatutValidee => 'Approved';

  @override
  String get deplacementsTitre => 'Mutations';

  @override
  String get deplacementsValiderDestinationBouton => 'Approve (destination)';

  @override
  String get deplacementsValiderOrigineBouton => 'Approve (origin)';

  @override
  String get deplacementsVoirLettreBouton => 'View recommendation letter';

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
  String comiteMembreActif(String fonction, String date) {
    return '$fonction — since $date';
  }

  @override
  String comiteMembreClos(String fonction) {
    return '$fonction (term ended)';
  }

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
  String get comitePvValideEtImmuable =>
      'These minutes are validated and immutable.';

  @override
  String get comiteQuorumAtteint => 'Quorum reached';

  @override
  String get comiteQuorumNonAtteint => 'Quorum not reached';

  @override
  String get comiteQuorumNonConfigure => 'Quorum not configured';

  @override
  String get comiteSeanceIntrouvableCorps =>
      'This meeting does not exist (anymore).';

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
  String get culteAjouterSequenceBouton => 'Add a sequence';

  @override
  String get culteAjouterSequenceTitre => 'Add a sequence';

  @override
  String get culteAucunPredicateur => 'None';

  @override
  String get culteAucuneSequence => 'No sequence yet.';

  @override
  String get culteChampAudioUrl => 'Audio link';

  @override
  String get culteChampCompteGlobal => 'Aggregate attendance count';

  @override
  String get culteChampDateHeure => 'Date and time';

  @override
  String get culteChampDureeMinutes => 'Planned duration (minutes)';

  @override
  String get culteChampLibelleSequence => 'Label (e.g. Worship, Sermon)';

  @override
  String get culteChampModePresence => 'Attendance mode';

  @override
  String get culteChampNombreOccurrences => 'Number of occurrences';

  @override
  String get culteChampOrdre => 'Order';

  @override
  String get culteChampPdfUrl => 'PDF link';

  @override
  String get culteChampPredicateur => 'Preacher (optional)';

  @override
  String get culteChampRecurrent => 'Create a recurring series (weekly)';

  @override
  String get culteChampResponsable => 'Person in charge (optional)';

  @override
  String get culteChampTexteBiblique => 'Bible passage';

  @override
  String get culteChampTheme => 'Theme (optional)';

  @override
  String get culteChampType => 'Service type (e.g. Sunday service)';

  @override
  String get culteChampTypeErreur => 'The service type is required.';

  @override
  String get culteChampVideoUrl => 'Video link';

  @override
  String get culteDateHeureChoisir => 'Choose the date and time';

  @override
  String get culteEnregistrerCompte => 'Save the count';

  @override
  String get culteLiturgieTitre => 'Liturgy';

  @override
  String get culteModePresenceGlobal => 'Aggregate (total count)';

  @override
  String get culteModePresenceNominal => 'Individual (per member)';

  @override
  String get culteNonPublie => 'No publication for this service yet.';

  @override
  String get cultePresencesTitre => 'Attendance';

  @override
  String get cultePublicationTitre => 'Post-service publication';

  @override
  String cultePublieLe(String date) {
    return 'Published on $date';
  }

  @override
  String get cultePublierBouton => 'Publish';

  @override
  String get culteStatutTitre => 'Status';

  @override
  String get cultesAucun => 'No worship services recorded yet.';

  @override
  String get cultesNouveauTooltip => 'New worship service';

  @override
  String get cultesTitre => 'Worship services';

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
  String fideleDateNaissanceValeur(String date) {
    return 'Date of birth: $date';
  }

  @override
  String get fideleHistoriqueAucune => 'No changes recorded yet.';

  @override
  String fideleHistoriqueTitre(String nom) {
    return 'History — $nom';
  }

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
  String get fideleStatutDisciplineNote =>
      'This status can only be changed from the Discipline module (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) {
    return '→ $cible';
  }

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

  @override
  String get propositionChampExplication => 'Brief explanation (optional)';

  @override
  String get propositionChampTitre => 'Title';

  @override
  String get propositionSoumettreTitre => 'Submit a theme proposal';

  @override
  String get propositionSoumettreTooltip => 'Submit a proposal';

  @override
  String get propositionsAucune => 'No proposal submitted yet.';

  @override
  String get propositionsThemeTitre => 'Theme proposals';

  @override
  String get propositionsVoterEnTantQue => 'Vote/submit as';
}
