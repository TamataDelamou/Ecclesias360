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
  String get propositionsFicheRequise =>
      'Proposing a theme and voting are reserved for registered members (a record linked to your account).';

  @override
  String get propositionVotreProposition => 'Your proposal';

  @override
  String get disciplineTitre => 'Disciplinary files';

  @override
  String get disciplineHistoriqueTitre => 'Confidential disciplinary history';

  @override
  String get disciplineAucunDossier => 'No disciplinary file.';

  @override
  String get disciplineAucunDossierFidele =>
      'No disciplinary file for this member.';

  @override
  String get disciplineOuvrirTooltip => 'Open a file';

  @override
  String get disciplineOuvrirTitre => 'Open a disciplinary file';

  @override
  String get disciplineChampFideleMisEnCause => 'Member concerned';

  @override
  String get disciplineChampNatureFaute => 'Nature of the offense';

  @override
  String get disciplineAccesReserve =>
      'Access restricted to a pastor or a member of the disciplinary committee.';

  @override
  String get disciplineStatutEnInstruction => 'Under investigation';

  @override
  String get disciplineStatutSanctionne => 'Sanctioned';

  @override
  String get disciplineStatutClos => 'Closed';

  @override
  String disciplineAlerteFinDePeriode(String date) {
    return 'Reinstatement due on $date';
  }

  @override
  String get disciplineAlerteRevuePeriodique => 'Periodic review required';

  @override
  String get disciplineDetailTitre => 'Disciplinary file';

  @override
  String get disciplineIntrouvable =>
      'This disciplinary file could not be found.';

  @override
  String disciplineOuvertLe(String date) {
    return 'Opened on $date';
  }

  @override
  String get disciplineCommissionTitre => 'Investigating committee';

  @override
  String get disciplineCommissionAucune => 'No committee assigned.';

  @override
  String get disciplineCommissionAssignerBouton => 'Assign a committee';

  @override
  String get disciplineCommissionAssignerTitre => 'Assign a committee';

  @override
  String get disciplineCommissionCreerBouton => 'Create a new committee';

  @override
  String get disciplineCommissionCreerTitre => 'Create a committee';

  @override
  String get disciplineChampNomCommission => 'Committee name';

  @override
  String get disciplineCommissionMembresTitre => 'Committee members';

  @override
  String get disciplineCommissionAjouterMembreTooltip => 'Add a member';

  @override
  String get disciplinePiecesTitre => 'File records';

  @override
  String get disciplinePiecesAucune => 'No record submitted.';

  @override
  String get disciplinePieceAjouterTooltip => 'Add a record';

  @override
  String get disciplinePieceAjouterTitre => 'Add a record';

  @override
  String get disciplinePieceChampNature => 'Record type';

  @override
  String get disciplinePieceNatureTemoignage => 'Testimony';

  @override
  String get disciplinePieceNaturePreuve => 'Evidence';

  @override
  String get disciplinePieceChampContenu => 'Content (text)';

  @override
  String get disciplineDecisionTitre => 'Decision';

  @override
  String get disciplineChampDecision => 'Motivated decision';

  @override
  String get disciplineChampDureeSanction =>
      'Sanction duration in days (blank = indefinite)';

  @override
  String get disciplineChampSuspendreMinisteres =>
      'Suspend active ministry assignments';

  @override
  String get disciplinePrononcerBouton => 'Issue the decision';

  @override
  String disciplineDecisionRendueLe(String date) {
    return 'Decision issued on $date';
  }

  @override
  String get disciplineCloturerBouton => 'Close / Reinstate';

  @override
  String get disciplineDossierClosNote =>
      'File closed — the member has regained their previous status.';

  @override
  String get disciplineDureeIndeterminee => 'Indefinite duration';

  @override
  String disciplineDureeJours(int jours) {
    return '$jours day(s)';
  }

  @override
  String get financesTitre => 'Contributions';

  @override
  String get financesHistoriqueTitre => 'Contribution history';

  @override
  String get financesAucuneContribution => 'No contribution recorded.';

  @override
  String get financesAucuneContributionFidele =>
      'No contribution for this member.';

  @override
  String get financesSaisirTooltip => 'Record an offering';

  @override
  String get financesSaisirTitre => 'Record an offering';

  @override
  String get financesChampDonateur => 'Donor';

  @override
  String get financesDonateurAnonyme => 'Anonymous donor';

  @override
  String get financesChampLibelleDonateurAnonyme =>
      'Anonymous donor label (optional)';

  @override
  String get financesChampTypeOffrande => 'Offering type';

  @override
  String get financesChampMontant => 'Amount';

  @override
  String get financesChampModePaiement => 'Payment method';

  @override
  String get financesModePaiementEspeces => 'Cash';

  @override
  String get financesModePaiementMobileMoney => 'Mobile money';

  @override
  String get financesModePaiementVirement => 'Bank transfer';

  @override
  String get financesSaisirBouton => 'Record';

  @override
  String get financesRapportParTypeTitre => 'Breakdown by offering type';

  @override
  String get financesStatutEnAttente => 'Pending';

  @override
  String get financesStatutValidee => 'Validated';

  @override
  String get financesStatutRejetee => 'Rejected';

  @override
  String get financesTresoriersTitre => 'Designated treasurers';

  @override
  String get financesTresoriersAucun => 'No designated treasurer.';

  @override
  String get financesTresorierDesignerTitre => 'Designate a treasurer';

  @override
  String get financesTresorierDesignerBouton => 'Designate';

  @override
  String get financesTresorierDesignerTooltip => 'Designate a treasurer';

  @override
  String financesTresorierDepuis(String date) {
    return 'Treasurer since $date';
  }

  @override
  String get financesTresorierRetirerTooltip => 'Remove designation';

  @override
  String get financesRecuTitre => 'Contribution receipt';

  @override
  String get financesIntrouvable => 'This contribution cannot be found.';

  @override
  String get financesValiderTitre => 'Validate the contribution';

  @override
  String get financesAccesReserve =>
      'Access restricted to a pastor, the node treasurer or the member concerned.';

  @override
  String get financesDecisionParLeSaisissant =>
      'You entered this contribution: another authorised person must validate or reject it (separation of duties).';

  @override
  String get authFicheLieeRequise =>
      'First link your account to your member record (\"Link my account to this record\"): the recorded validator is always a person from the register.';

  @override
  String get financesValiderBouton => 'Validate';

  @override
  String get financesRejeterTitre => 'Reject the contribution';

  @override
  String get financesChampMotif => 'Reason';

  @override
  String get financesRejeterBouton => 'Reject';

  @override
  String get financesContrePasserTitre => 'Reverse the contribution';

  @override
  String get financesContrePasserBouton => 'Reverse';

  @override
  String financesSaisieLe(String date) {
    return 'Recorded on $date';
  }

  @override
  String financesValideeLe(String date) {
    return 'Validated on $date';
  }

  @override
  String get financesEstContrePassation =>
      'This contribution is a reversal entry.';

  @override
  String get financesProjetsTitre => 'Projects';

  @override
  String get financesProjetsAucun => 'No project.';

  @override
  String get financesProjetCreerTitre => 'Create a project';

  @override
  String get financesProjetCreerTooltip => 'Create a project';

  @override
  String get financesChampNomProjet => 'Project name';

  @override
  String get financesChampBudgetPrevisionnel => 'Estimated budget';

  @override
  String financesProjetSoldeSurBudget(int solde, int budget, String devise) {
    return 'Balance: $solde $devise / budget $budget $devise';
  }

  @override
  String get financesProjetDetailTitre => 'Project sheet';

  @override
  String get financesProjetIntrouvable => 'This project cannot be found.';

  @override
  String get financesDepenseAjouterTitre => 'Add an expense';

  @override
  String get financesDepenseAjouterBouton => 'Add an expense';

  @override
  String get financesChampLibelleDepense => 'Expense label';

  @override
  String get financesChampDerogationTracee =>
      'Traced exception (exceeds available balance)';

  @override
  String get financesDepensesTitre => 'Expenses';

  @override
  String get financesDepensesAucune => 'No expense recorded.';

  @override
  String financesDepenseDerogation(String date) {
    return '$date — traced exception';
  }

  @override
  String get financesEngagementsTitre => 'Pledges and due dates';

  @override
  String get financesEngagementsAucun => 'No pledge.';

  @override
  String get financesEngagementCreerTitre => 'Create a pledge';

  @override
  String get financesEngagementCreerTooltip => 'Create a pledge';

  @override
  String get financesChampTypeEngagement => 'Pledge type';

  @override
  String get financesTypeEngagementDime => 'Tithe';

  @override
  String get financesTypeEngagementPromesseDon => 'Pledge of gift';

  @override
  String get financesChampMontantPrevu => 'Planned amount';

  @override
  String get financesChampPeriodicite => 'Frequency';

  @override
  String get financesPeriodiciteHebdomadaire => 'Weekly';

  @override
  String get financesPeriodiciteMensuelle => 'Monthly';

  @override
  String get financesPeriodiciteTrimestrielle => 'Quarterly';

  @override
  String get financesPeriodiciteAnnuelle => 'Yearly';

  @override
  String financesEngagementPeriodicite(String periodicite) {
    return 'Frequency: $periodicite';
  }

  @override
  String get financesEcheanceEnAttente => 'Pending';

  @override
  String get financesEcheanceHonoree => 'Honored';

  @override
  String get financesEcheanceEnRetard => 'Overdue';

  @override
  String get financesEcheanceHonorerBouton => 'Honor';

  @override
  String get patrimoineTitre => 'Assets';

  @override
  String get patrimoineCampagnesTitre => 'Inventory campaigns';

  @override
  String get patrimoineAjouterTooltip => 'Add an asset';

  @override
  String get patrimoineAucunBien => 'No assets recorded.';

  @override
  String get patrimoineAlerteSeuilTitre => 'Assets below stock alert threshold';

  @override
  String get patrimoineAjouterTitre => 'Add an asset';

  @override
  String get patrimoineChampIdInventaire => 'Inventory ID';

  @override
  String get patrimoineChampCategorie => 'Category';

  @override
  String get patrimoineChampDesignation => 'Description';

  @override
  String get patrimoineChampValeurAcquisition => 'Acquisition value';

  @override
  String get patrimoineChampValeurVenale => 'Market value';

  @override
  String get patrimoineChampDateAcquisition => 'Acquisition date';

  @override
  String get patrimoineChampSeuilAlerteStock => 'Stock alert threshold';

  @override
  String get patrimoineEtatNeuf => 'New';

  @override
  String get patrimoineEtatBon => 'Good';

  @override
  String get patrimoineEtatAReparer => 'Needs repair';

  @override
  String get patrimoineEtatHorsService => 'Out of service';

  @override
  String get patrimoineEtatCede => 'Disposed of';

  @override
  String get patrimoineFicheTitre => 'Asset record';

  @override
  String get patrimoineIntrouvable => 'Asset not found.';

  @override
  String get patrimoineSignalerEtatTitre => 'Report asset condition';

  @override
  String get patrimoineChampEtat => 'Condition';

  @override
  String get patrimoineSignalerEtatBouton => 'Report condition';

  @override
  String get patrimoineSortirTitre => 'Remove asset from inventory';

  @override
  String get patrimoineChampTypeSortie => 'Removal type';

  @override
  String get patrimoineTypeSortieCession => 'Transfer';

  @override
  String get patrimoineTypeSortieDon => 'Donation';

  @override
  String get patrimoineTypeSortieMiseAuRebut => 'Scrapping';

  @override
  String get patrimoineAccesReserve =>
      'Access restricted to the node\'s leaders (pastor, leader or administrator).';

  @override
  String get patrimoineChampMotif => 'Reason';

  @override
  String get patrimoineSortirBouton => 'Remove asset';

  @override
  String get patrimoineReserverTitre => 'Reserve the asset';

  @override
  String get patrimoineChampObjetReservation => 'Reservation purpose';

  @override
  String get patrimoineObjetCulte => 'Service';

  @override
  String get patrimoineObjetEvenement => 'Event';

  @override
  String get patrimoineObjetAutre => 'Other';

  @override
  String get patrimoineAucunCultePourReservation =>
      'No service available for this node.';

  @override
  String get patrimoineChampCulte => 'Service';

  @override
  String get patrimoineChampObjetLibre => 'Description';

  @override
  String get patrimoineChampDateDebut => 'Start date';

  @override
  String get patrimoineChampDateFin => 'End date';

  @override
  String get patrimoineReserverBouton => 'Reserve';

  @override
  String get patrimoineMouvementAjouterTitre => 'Add a stock movement';

  @override
  String get patrimoineChampTypeMouvement => 'Movement type';

  @override
  String get patrimoineMouvementEntree => 'In';

  @override
  String get patrimoineMouvementSortie => 'Out';

  @override
  String get patrimoineChampQuantite => 'Quantity';

  @override
  String get patrimoineStockTitre => 'Stock management';

  @override
  String get patrimoineMouvementAjouterBouton => 'Add a movement';

  @override
  String get patrimoineReservationsTitre => 'Reservations';

  @override
  String get patrimoineReservationsAucune => 'No reservations recorded.';

  @override
  String get patrimoineCampagneDemarrerTooltip => 'Start a campaign';

  @override
  String get patrimoineCampagnesAucune => 'No inventory campaigns recorded.';

  @override
  String get patrimoineCampagneEnCours => 'In progress';

  @override
  String get patrimoineCampagneCloturee => 'Closed';

  @override
  String get patrimoineCampagneDemarrerTitre => 'Start an inventory campaign';

  @override
  String get patrimoineChampLibelleCampagne => 'Campaign name';

  @override
  String get patrimoineCampagneDemarrerBouton => 'Start';

  @override
  String get patrimoineCampagneFicheTitre => 'Campaign record';

  @override
  String get patrimoineCampagneIntrouvable => 'Campaign not found.';

  @override
  String get patrimoineCampagneCloturerTitre => 'Close the campaign';

  @override
  String get patrimoineCampagneCloturerConfirmation =>
      'This action is irreversible: no new count can be recorded afterwards.';

  @override
  String get patrimoineCampagneCloturerBouton => 'Close the campaign';

  @override
  String get patrimoineCampagneAjouterPointageTitre => 'Add a count';

  @override
  String get patrimoineChampBien => 'Asset';

  @override
  String get patrimoineChampEtatConstate => 'Observed condition';

  @override
  String get patrimoineChampQuantiteConstatee => 'Observed quantity';

  @override
  String get patrimoineChampCommentaire => 'Comment';

  @override
  String get patrimoineCampagneAjouterPointageBouton => 'Save the count';

  @override
  String get patrimoineCampagneAjouterPointageTooltip => 'Add a count';

  @override
  String get patrimoineCampagnePointagesTitre => 'Counts';

  @override
  String get patrimoineCampagnePointagesAucun => 'No counts recorded.';

  @override
  String patrimoineAcquisLe(String date) {
    return 'Acquired on $date';
  }

  @override
  String patrimoineSortiLe(String date) {
    return 'Removed on $date';
  }

  @override
  String patrimoineQuantiteActuelle(int quantite) {
    return 'Current quantity: $quantite';
  }

  @override
  String patrimoineSeuilAlerte(int seuil) {
    return 'Alert threshold: $seuil';
  }

  @override
  String patrimoineCampagneDemarreeLe(String date) {
    return 'Started on $date';
  }

  @override
  String patrimoineCampagneClotureeLe(String date) {
    return 'Closed on $date';
  }

  @override
  String get comptabiliteTitre => 'Accounting';

  @override
  String get comptabiliteAccesReserve =>
      'Access restricted to a pastor or the node treasurer.';

  @override
  String get comptabiliteOngletCaisse => 'Cash';

  @override
  String get comptabiliteOngletEcritures => 'Entries';

  @override
  String get comptabiliteOngletRapport => 'Report';

  @override
  String get comptabiliteSoldeCaisseDuJour => 'Today\'s cash balance';

  @override
  String get comptabiliteAucuneEcriture => 'No entries recorded.';

  @override
  String get comptabiliteAucunePeriodeOuverte => 'No open accounting period.';

  @override
  String get comptabiliteDebit => 'Debit';

  @override
  String get comptabiliteCredit => 'Credit';

  @override
  String get comptabiliteRapportRecettes => 'Revenue';

  @override
  String get comptabiliteRapportDepenses => 'Expenses';

  @override
  String get comptabiliteRapportSoldeNet => 'Net balance';

  @override
  String get mediathequeCatalogueTitre => 'Media library catalog';

  @override
  String get mediathequeRechercheTheme => 'Search by theme';

  @override
  String get mediathequeAucunContenu => 'No published content yet.';

  @override
  String get mediathequeAucunResultat => 'No results for this search.';

  @override
  String get mediathequeFicheTitre => 'Content sheet';

  @override
  String get mediathequeContenuIntrouvable =>
      'This content could not be found (or is no longer available).';

  @override
  String get mediathequeChampType => 'Type';

  @override
  String get mediathequeChampTheme => 'Theme';

  @override
  String get mediathequeChampMotsCles => 'Keywords';

  @override
  String get mediathequeChampIntervenant => 'Speaker';

  @override
  String get mediathequeChampDate => 'Date';

  @override
  String get mediathequeChampFichier => 'File link';

  @override
  String get mediathequeChampConsultations => 'Views';

  @override
  String get mediathequeLectureSeule =>
      'Read-only: favourites and comments are reserved for registered members (a record linked to your account).';

  @override
  String get mediathequeFavorisReserves =>
      'A member\'s favourites are visible to them alone.';

  @override
  String get mediathequeAjouterFavori => 'Add to favorites';

  @override
  String get mediathequeRetirerFavori => 'Remove from favorites';

  @override
  String get mediathequeCommentairesTitre => 'Comments';

  @override
  String get mediathequeAucunCommentaire => 'No comments yet.';

  @override
  String get mediathequeCommentaireEnAttente => 'Awaiting moderation';

  @override
  String get mediathequeSignalerCommentaire => 'Report';

  @override
  String get mediathequeChampCommentaire => 'Your comment';

  @override
  String get mediathequeCommentaireAjouterBouton => 'Post';

  @override
  String get mediathequeFavorisTitre => 'Media library favorites';

  @override
  String get mediathequeFavorisAucun => 'No favorite content yet.';

  @override
  String get authConnexionTitre => 'Sign in';

  @override
  String get authConnexionIntro =>
      'Sign in without a password: a one-time code will be sent to you.';

  @override
  String get authIdentifiantTelephone => 'Phone';

  @override
  String get authIdentifiantEmail => 'Email';

  @override
  String get authChampTelephone => 'Number in international format';

  @override
  String get authChampTelephoneAide => 'Example: +224 620 00 00 01';

  @override
  String get authChampEmail => 'Email address';

  @override
  String get authTelephoneInvalide =>
      'Invalid number: include the country code (e.g. +224…).';

  @override
  String get authEmailInvalide => 'Invalid email address.';

  @override
  String get authMethodeTitre => 'Receive the code by';

  @override
  String get authMethodeSms => 'SMS';

  @override
  String get authMethodeWhatsapp => 'WhatsApp';

  @override
  String get authMethodeMagicLink => 'Sign-in link (Magic Link)';

  @override
  String get authMethodeCodeEmail => 'Code by email';

  @override
  String get authBasculerVersEmail => 'Receive a code by email instead';

  @override
  String get authEnvoyerCode => 'Send me the code';

  @override
  String get authVerificationTitre => 'Verification';

  @override
  String authVerificationIntro(String destinataire) {
    return 'Enter the 6-digit code sent to $destinataire.';
  }

  @override
  String get authVerificationMagicLink =>
      'You can also open the link in the same email on the device where the app is installed.';

  @override
  String get authChampCode => 'Code';

  @override
  String get authVerifier => 'Sign in';

  @override
  String get authRenvoyerCode => 'Resend code';

  @override
  String get authModifierIdentifiant => 'Change identifier';

  @override
  String get authDeconnexion => 'Sign out';

  @override
  String authCompteConnecte(String identifiant) {
    return 'Signed in: $identifiant';
  }

  @override
  String get authLiaisonsTitre => 'Account links';

  @override
  String get authLiaisonsAucune => 'No links recorded.';

  @override
  String get authLiaisonsConflits => 'Conflicts to resolve';

  @override
  String get authLiaisonsJournal => 'Log';

  @override
  String get authIssueLieAutomatiquement => 'Linked automatically';

  @override
  String get authIssueAdministrateurAmorcage => 'Bootstrap administrator';

  @override
  String get authIssueAucuneCorrespondance => 'No matching record';

  @override
  String get authIssueCorrespondanceMultiple => 'Several records match';

  @override
  String get authIssueFicheDejaLiee =>
      'Record already linked to another account';

  @override
  String get authStatutEnAttente => 'Pending';

  @override
  String get authStatutResoluLie => 'Resolved: account linked';

  @override
  String get authStatutResoluRejete => 'Resolved: kept as basic user';

  @override
  String get authLiaisonLier => 'Link account';

  @override
  String get authLiaisonRejeter => 'Keep as basic user';

  @override
  String get authLiaisonChoisirFiche => 'Record to link';

  @override
  String get authLiaisonConfirmation =>
      'If the record is linked to another account, that link will be removed and replaced. Confirm?';

  @override
  String get authConfirmer => 'Confirm';

  @override
  String get roleUtilisateurSimple => 'Basic user';

  @override
  String get roleMembre => 'Member';

  @override
  String get roleResponsable => 'Leader';

  @override
  String get rolePasteur => 'Pastor';

  @override
  String get roleAdministrateur => 'Administrator';

  @override
  String get authLierMonCompte => 'Link my account to this record';

  @override
  String authLierMonCompteConfirmation(String nom) {
    return 'Your administrator account will be linked to $nom\'s record, which will take the administrator role. The link is logged and can only be undone by resolving a link conflict.';
  }

  @override
  String get authLierMonCompteBouton => 'Link my account';

  @override
  String get authLierMonCompteFait => 'Account linked to your record.';
}
