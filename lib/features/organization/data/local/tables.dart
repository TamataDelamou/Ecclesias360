import 'package:drift/drift.dart';

/// Table Drift NœudOrganisationnel (Module I, RG-I-*).
@DataClassName('OrganisationNodeRow')
class OrganisationNodes extends Table {
  TextColumn get id => text()();
  TextColumn get typeNoeud => text()();
  TextColumn get noeudParentId => text().nullable()();
  TextColumn get nom => text()();
  TextColumn get codeInterne => text()();
  TextColumn get statut => text().withDefault(const Constant('provisoire'))();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get cachetUrl => text().nullable()();
  DateTimeColumn get dateFondation => dateTime().nullable()();
  TextColumn get categorieConfessionnelle => text().nullable()();
  TextColumn get zoneGeoId => text().nullable()();
  TextColumn get path => text()();
  IntColumn get depth => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code_interne)'];
}

/// Table Drift HistoriqueRattachement (RG-I-06) — trace tout changement de
/// rattachement d'un nœud.
@DataClassName('HistoriqueRattachementRow')
class HistoriqueRattachements extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text()();
  TextColumn get ancienParentId => text().nullable()();
  TextColumn get nouveauParentId => text()();
  DateTimeColumn get dateEffet => dateTime()();
  TextColumn get motif => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift ResponsableNoeud (Module I, RG-I-05) — responsables en
/// fonction d'un nœud, avec historique des mandats (`dateFin` nulle ou
/// passée). Base de `noeuds_du_perimetre()` côté serveur (RG-SEC-05, voir
/// RECONSTRUCTION_ecclesias360.md §3).
@DataClassName('NodeResponsableRow')
class NodeResponsables extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get fonction => text()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Fidèle (Module II, RG-II-*). `id` sert de matricule
/// (RG-II-01).
@DataClassName('FideleRow')
class Fideles extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get nom => text()();
  TextColumn get prenoms => text()();
  DateTimeColumn get dateNaissance => dateTime()();
  TextColumn get sexe => text()();
  TextColumn get statutCivil => text()();
  TextColumn get statutSpirituel => text().withDefault(const Constant('visiteur'))();
  TextColumn get statut => text().withDefault(const Constant('actif'))();
  DateTimeColumn get dateConversion => dateTime().nullable()();
  DateTimeColumn get dateBapteme => dateTime().nullable()();
  TextColumn get egliseProvenance => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get telephone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get adresse => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift LienFamilial (RG-II-04).
@DataClassName('LienFamilialRow')
class LiensFamiliaux extends Table {
  TextColumn get id => text()();
  @ReferenceName('liensCommeFidele1')
  TextColumn get fideleId1 => text().references(Fideles, #id)();
  @ReferenceName('liensCommeFidele2')
  TextColumn get fideleId2 => text().references(Fideles, #id)();
  TextColumn get typeLien => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift HistoriqueFidele (RG-II-05).
@DataClassName('HistoriqueFideleRow')
class HistoriqueFideles extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get champModifie => text()();
  TextColumn get ancienneValeur => text().nullable()();
  TextColumn get nouvelleValeur => text().nullable()();
  TextColumn get auteurFideleId => text().nullable()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Tuteur (RG-II-06).
@DataClassName('TuteurRow')
class Tuteurs extends Table {
  TextColumn get id => text()();
  @ReferenceName('tuteursCommeMineur')
  TextColumn get mineurId => text().references(Fideles, #id)();
  TextColumn get lien => text()();
  @ReferenceName('tuteursCommeTuteur')
  TextColumn get tuteurFideleId => text().nullable().references(Fideles, #id)();
  TextColumn get tuteurTiersNom => text().nullable()();
  TextColumn get tuteurTiersTelephone => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift ZoneGeographique (Module XXIII, référentiel — RG-XXIII-01/03).
@DataClassName('ZoneGeographiqueRow')
class ZonesGeographiques extends Table {
  TextColumn get id => text()();
  TextColumn get libelle => text()();
  IntColumn get niveau => integer()();
  TextColumn get parentId => text().nullable().references(ZonesGeographiques, #id)();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift TypeMinistere (Module III, RG-III-04) — catalogue
/// paramétrable, vingt-quatre types standards protégés par défaut (seedés
/// en migration, non désactivables depuis l'UI actuelle).
@DataClassName('TypeMinistereRow')
class TypesMinisteres extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get libelle => text()();
  BoolColumn get standard => boolean().withDefault(const Constant(false))();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code)'];
}

/// Table Drift Ministere (Module III, RG-III-01/04/05).
@DataClassName('MinistereRow')
class Ministeres extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get typeMinistereId => text().references(TypesMinisteres, #id)();
  TextColumn get nom => text()();
  DateTimeColumn get dateCreation => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift AffectationMinistere (Module III, RG-III-01/03).
@DataClassName('AffectationMinistereRow')
class AffectationsMinisteres extends Table {
  TextColumn get id => text()();
  TextColumn get ministereId => text().references(Ministeres, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get role => text()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime().nullable()();
  TextColumn get statut => text().withDefault(const Constant('active'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift MandatResponsable (Module III, RG-III-02/05) — les lignes
/// closes (`dateFinReelle` non nulle) constituent l'historique des
/// responsables successifs (écran 6), pas de table séparée.
@DataClassName('MandatResponsableRow')
class MandatsResponsables extends Table {
  TextColumn get id => text()();
  TextColumn get ministereId => text().references(Ministeres, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFinPrevue => dateTime().nullable()();
  DateTimeColumn get dateFinReelle => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift ActiviteMinistere (Module III, RG-III-05) — journal
/// d'activités (réunions, rapports).
@DataClassName('ActiviteMinistereRow')
class ActivitesMinisteres extends Table {
  TextColumn get id => text()();
  TextColumn get ministereId => text().references(Ministeres, #id)();
  TextColumn get type => text()();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime()();
  @ReferenceName('activitesCommeAuteur')
  TextColumn get auteurFideleId => text().nullable().references(Fideles, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift DonSpirituel (Module IV, RG-IV-04) — référentiel fixe des
/// neuf dons spirituels (1 Corinthiens 12), seedé en migration.
@DataClassName('DonSpirituelRow')
class DonsSpirituels extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get libelle => text()();
  TextColumn get descriptionBiblique => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code)'];
}

/// Table Drift DonFidele (Module IV, RG-IV-01/02) — chaque ligne est une
/// évaluation ; jamais mise à jour, seulement ajoutée (historique complet).
@DataClassName('DonFideleRow')
class DonsFideles extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get donId => text().references(DonsSpirituels, #id)();
  TextColumn get niveauMaturite => text()();
  @ReferenceName('evaluationsCommeResponsable')
  TextColumn get responsableSuiviId => text().references(Fideles, #id)();
  DateTimeColumn get dateEvaluation => dateTime()();
  TextColumn get observations => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift DonMinistereCompatible (Module IV, RG-IV-03) — table de
/// correspondance alimentant la suggestion d'affectation (Module III),
/// vide par défaut (jugement pastoral, hors périmètre technique).
@DataClassName('DonMinistereCompatibleRow')
class DonsMinisteresCompatibles extends Table {
  TextColumn get id => text()();
  TextColumn get donId => text().references(DonsSpirituels, #id)();
  TextColumn get typeMinistereId => text().references(TypesMinisteres, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (don_id, type_ministere_id)'];
}

/// Table Drift Profession (Module V, RG-V-02) — référentiel hiérarchisé
/// (catégorie / métier), paramétrable.
@DataClassName('ProfessionRow')
class Professions extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get categorie => text()();
  TextColumn get libelle => text()();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code)'];
}

/// Table Drift ProfessionFidele (Module V, RG-V-01) — déclaration d'une
/// profession/compétence par un fidèle, vérifiable.
@DataClassName('ProfessionFideleRow')
class ProfessionsFideles extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get professionId => text().references(Professions, #id)();
  TextColumn get statutVerification => text().withDefault(const Constant('declare'))();
  IntColumn get anneesExperience => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Sollicitation (Module V, RG-V-03) — sollicitation nommée
/// d'un fidèle pour un projet ou une action sociale, réponse tracée.
@DataClassName('SollicitationRow')
class Sollicitations extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get objet => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get reponse => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift GroupeEglise (Module VI, RG-VI-01/02) — segment
/// démographique ou fonctionnel de l'assemblée. `criteresJson` n'est
/// renseigné que pour `typeRegle = auto` (voir `CriteresGroupe`).
@DataClassName('GroupeEgliseRow')
class GroupesEglise extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get libelle => text()();
  TextColumn get typeRegle => text()();
  TextColumn get criteresJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code)'];
}

/// Table Drift AppartenanceGroupe (Module VI, RG-VI-01/02) — non exclusive,
/// un fidèle peut appartenir à plusieurs groupes.
@DataClassName('AppartenanceGroupeRow')
class AppartenancesGroupe extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get groupeId => text().references(GroupesEglise, #id)();
  DateTimeColumn get dateAffectation => dateTime()();
  TextColumn get origine => text()();
  TextColumn get motifDerogation => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (fidele_id, groupe_id)'];
}

/// Table Drift QuorumComite (Module VII, RG-VII-05) — quorum minimum
/// paramétrable par nœud, une ligne par nœud configuré.
@DataClassName('QuorumComiteRow')
class QuorumsComite extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  IntColumn get quorumMinimum => integer()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (noeud_id)'];
}

/// Table Drift MembreComite (Module VII, RG-VII-01) — sous-ensemble qualifié
/// des fidèles, jamais sans fiche fidèle sous-jacente (FK non nullable).
@DataClassName('MembreComiteRow')
class MembresComite extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get fonction => text()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift SeanceComite (Module VII, RG-VII-05).
@DataClassName('SeanceComiteRow')
class SeancesComite extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get ordreDuJour => text()();
  BoolColumn get quorumAtteint => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift PresentSeance (Module VII, RG-VII-05) — liste des présents
/// d'une séance, base du calcul de quorum.
@DataClassName('PresentSeanceRow')
class PresentsSeance extends Table {
  TextColumn get id => text()();
  TextColumn get seanceId => text().references(SeancesComite, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (seance_id, fidele_id)'];
}

/// Table Drift Decision (Module VII, RG-VII-04/05).
@DataClassName('DecisionRow')
class Decisions extends Table {
  TextColumn get id => text()();
  TextColumn get seanceId => text().references(SeancesComite, #id)();
  TextColumn get libelle => text()();
  TextColumn get resultatVote => text().nullable()();
  TextColumn get statut => text().withDefault(const Constant('ajourne'))();
  BoolColumn get porteeDisciplinaire => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift ProcesVerbal (Module VII, RG-VII-02/03).
@DataClassName('ProcesVerbalRow')
class ProcesVerbaux extends Table {
  TextColumn get id => text()();
  TextColumn get seanceId => text().references(SeancesComite, #id)();
  TextColumn get contenu => text()();
  TextColumn get statut => text().withDefault(const Constant('brouillon'))();
  TextColumn get documentArchiveId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (seance_id)'];
}

/// Table Drift ErratumPv (Module VII, RG-VII-02) — correction tracée d'un
/// PV déjà validé, jamais de modification silencieuse du contenu original.
@DataClassName('ErratumPvRow')
class ErratumsPv extends Table {
  TextColumn get id => text()();
  TextColumn get procesVerbalId => text().references(ProcesVerbaux, #id)();
  TextColumn get texte => text()();
  DateTimeColumn get dateAjout => dateTime()();
  TextColumn get auteurFideleId => text().nullable().references(Fideles, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift TacheSuivi (Module VII, RG-VII-03).
@DataClassName('TacheSuiviRow')
class TachesSuivi extends Table {
  TextColumn get id => text()();
  TextColumn get decisionId => text().references(Decisions, #id)();
  TextColumn get description => text()();
  TextColumn get assigneFideleId => text().references(Fideles, #id)();
  TextColumn get statut => text().withDefault(const Constant('a_faire'))();
  DateTimeColumn get dateCreation => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Culte (Module XII, RG-XII-01/02/05).
@DataClassName('CulteRow')
class Cultes extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  DateTimeColumn get dateHeure => dateTime()();
  TextColumn get typeCulte => text()();
  TextColumn get theme => text().nullable()();
  TextColumn get predicateurId => text().nullable().references(Fideles, #id)();
  TextColumn get statut => text().withDefault(const Constant('planifie'))();
  TextColumn get modePresence => text().withDefault(const Constant('nominal'))();
  IntColumn get compteGlobalPresence => integer().nullable()();
  TextColumn get serieRecurrenteId => text().nullable()();
  BoolColumn get estException => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift SequenceLiturgique (Module XII, RG-XII-01).
@DataClassName('SequenceLiturgiqueRow')
class SequencesLiturgiques extends Table {
  TextColumn get id => text()();
  TextColumn get culteId => text().references(Cultes, #id)();
  IntColumn get ordre => integer()();
  TextColumn get libelle => text()();
  TextColumn get responsableId => text().nullable().references(Fideles, #id)();
  IntColumn get dureePrevueMinutes => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift PresenceCulte (Module XII, RG-XII-02) — pointage nominal
/// uniquement (voir `Cultes.compteGlobalPresence` pour le mode global).
@DataClassName('PresenceCulteRow')
class PresencesCulte extends Table {
  TextColumn get id => text()();
  TextColumn get culteId => text().references(Cultes, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (culte_id, fidele_id)'];
}

/// Table Drift PublicationCulte (Module XII, RG-XII-03) — l'archivage
/// automatique dans la médiathèque (Module XIII) reste différé.
@DataClassName('PublicationCulteRow')
class PublicationsCulte extends Table {
  TextColumn get id => text()();
  TextColumn get culteId => text().references(Cultes, #id)();
  DateTimeColumn get datePublication => dateTime()();
  TextColumn get texteBiblique => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get videoUrl => text().nullable()();
  TextColumn get pdfUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (culte_id)'];
}

/// Table Drift PropositionTheme (Module XII, RG-XII-06) — le classement
/// automatique par l'assistant IA (Module XVI) reste différé,
/// `categorie` nullable en attendant.
@DataClassName('PropositionThemeRow')
class PropositionsTheme extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get titre => text()();
  TextColumn get explication => text().nullable()();
  TextColumn get categorie => text().nullable()();
  TextColumn get statut => text().withDefault(const Constant('soumise'))();
  DateTimeColumn get dateSoumission => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift VoteProposition (Module XII, RG-XII-06) — un vote par
/// fidèle et par proposition, modifiable.
@DataClassName('VotePropositionRow')
class VotesProposition extends Table {
  TextColumn get id => text()();
  TextColumn get propositionId => text().references(PropositionsTheme, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get valeur => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (proposition_id, fidele_id)'];
}

/// File d'attente hors ligne (RG-OFF-02) : chaque écriture locale enregistre
/// ici l'événement à rejouer vers Supabase dès qu'une connexion est
/// disponible, dans l'ordre chronologique, jamais purgée avant confirmation
/// serveur (chapitre 7.2 du Cahier).
@DataClassName('SyncOutboxRow')
class SyncOutbox extends Table {
  TextColumn get id => text()();
  TextColumn get entite => text()();
  TextColumn get entiteId => text()();
  TextColumn get operation => text()();
  DateTimeColumn get creeLe => dateTime()();
  IntColumn get tentatives => integer().withDefault(const Constant(0))();
  DateTimeColumn get derniereTentativeLe => dateTime().nullable()();
  TextColumn get derniereErreur => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
