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

/// Table Drift NomenclatureArchivage (Module VIII, RG-VIII-01) — modèle de
/// numérotation paramétrable par type de document, un type par ligne.
@DataClassName('NomenclatureArchivageRow')
class NomenclaturesArchivage extends Table {
  TextColumn get id => text()();
  TextColumn get typeDocument => text()();
  TextColumn get modeleNumerotation => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (type_document)'];
}

/// Table Drift DocumentArchive (Module VIII, RG-VIII-01/02/03/04/05) —
/// greffe transversale : `moduleOrigine`/`objetIdOrigine` pointent vers
/// l'objet métier producteur, sans FK (les modules producteurs sont
/// hétérogènes et certains n'existent pas encore).
@DataClassName('DocumentArchiveRow')
class DocumentsArchive extends Table {
  TextColumn get id => text()();
  TextColumn get numeroArchive => text()();
  TextColumn get typeDocument => text()();
  TextColumn get moduleOrigine => text()();
  TextColumn get objetIdOrigine => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get niveauConfidentialite => text().withDefault(const Constant('standard'))();
  TextColumn get statut => text().withDefault(const Constant('actif'))();
  TextColumn get fichier => text()();
  DateTimeColumn get dateArchivage => dateTime()();
  DateTimeColumn get dateMiseCorbeille => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (numero_archive)'];
}

/// Table Drift VersionDocument (Module VIII, RG-VIII-02) — historique complet
/// des versions ; la version 1 correspond au fichier fourni à l'archivage
/// initial et reste accessible indéfiniment.
@DataClassName('VersionDocumentRow')
class VersionsDocument extends Table {
  TextColumn get id => text()();
  TextColumn get documentId => text().references(DocumentsArchive, #id)();
  IntColumn get numeroVersion => integer()();
  TextColumn get fichier => text()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (document_id, numero_version)'];
}

/// Table Drift Mutation (Module IX — Déplacements, RG-IX-01/02/03/04).
/// `valideeParOrigine`/`valideeParDestination` portent la double validation
/// pastorale (RG-IX-01), au-delà du modèle minimal du Cahier qui ne prévoit
/// qu'un `statut` global.
@DataClassName('MutationRow')
class Mutations extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  @ReferenceName('mutationsCommeOrigine')
  TextColumn get noeudOrigineId => text().references(OrganisationNodes, #id)();
  @ReferenceName('mutationsCommeDestination')
  TextColumn get noeudDestinationId => text().references(OrganisationNodes, #id)();
  TextColumn get motif => text()();
  TextColumn get statut => text().withDefault(const Constant('en_attente'))();
  BoolColumn get valideeParOrigine => boolean().withDefault(const Constant(false))();
  BoolColumn get valideeParDestination => boolean().withDefault(const Constant(false))();
  TextColumn get motifRefus => text().nullable()();
  DateTimeColumn get dateDemande => dateTime()();
  DateTimeColumn get dateValidation => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift LettreRecommandation (RG-IX-02) — lien vers le document
/// archivé (Module VIII) généré à la validation d'une mutation.
@DataClassName('LettreRecommandationRow')
class LettresRecommandation extends Table {
  TextColumn get id => text()();
  TextColumn get mutationId => text().references(Mutations, #id)();
  TextColumn get documentArchiveId => text().references(DocumentsArchive, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (mutation_id)'];
}

/// Table Drift NatureFaute (Module X, RG-X-02) — référentiel fermé et
/// extensible, même motif que `TypesMinisteres`. Strictement administratif
/// et procédural : ne jamais y inscrire de catégorie à caractère moral,
/// doctrinal ou théologique (voir AGENTS.md §7, entrée Module X).
@DataClassName('NatureFauteRow')
class NaturesFaute extends Table {
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

/// Table Drift CommissionDisciplinaire (Module X, RG-X-02).
@DataClassName('CommissionDisciplinaireRow')
class CommissionsDisciplinaires extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get nom => text()();
  TextColumn get statut => text().withDefault(const Constant('active'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift MembreCommission (Module X, RG-X-02).
@DataClassName('MembreCommissionRow')
class MembresCommissionDisciplinaire extends Table {
  TextColumn get id => text()();
  TextColumn get commissionId => text().references(CommissionsDisciplinaires, #id)();
  TextColumn get fideleId => text().references(Fideles, #id)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (commission_id, fidele_id)'];
}

/// Table Drift DossierDisciplinaire (Module X, RG-X-01 à 04). Voir
/// `DossierDisciplinaire` (domaine) pour la justification des quatre champs
/// ajoutés au-delà du tableau minimal du Cahier.
@DataClassName('DossierDisciplinaireRow')
class DossiersDisciplinaires extends Table {
  TextColumn get id => text()();
  @ReferenceName('dossiersDisciplinairesCommeMisEnCause')
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get natureFauteId => text().references(NaturesFaute, #id)();
  DateTimeColumn get dateOuverture => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('en_instruction'))();
  @ReferenceName('dossiersDisciplinairesCommeAuteur')
  TextColumn get ouvertParFideleId => text().nullable().references(Fideles, #id)();
  TextColumn get statutSpirituelAnterieur => text().nullable()();
  TextColumn get commissionId => text().nullable().references(CommissionsDisciplinaires, #id)();
  TextColumn get decision => text().nullable()();
  DateTimeColumn get dateDecision => dateTime().nullable()();
  IntColumn get dureeSanctionJours => integer().nullable()();
  DateTimeColumn get dateReintegrationPrevue => dateTime().nullable()();
  BoolColumn get suspensionMinisteresAppliquee => boolean().withDefault(const Constant(false))();
  TextColumn get decisionComiteOrigineId => text().nullable().references(Decisions, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift PieceDossier (Module X, RG-X-02/06). `documentArchiveId`
/// nullable — rempli seulement si `ArchivageRepository` est injecté dans
/// `DisciplineRepository`, même précédent que `ProcesVerbal` (module VII).
@DataClassName('PieceDossierRow')
class PiecesDossier extends Table {
  TextColumn get id => text()();
  TextColumn get dossierId => text().references(DossiersDisciplinaires, #id)();
  TextColumn get nature => text()();
  DateTimeColumn get ajouteLe => dateTime()();
  TextColumn get documentArchiveId => text().nullable().references(DocumentsArchive, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift TypeOffrande (Module XI, RG-XI-01) — référentiel fermé et
/// extensible des types d'offrande, même précédent que TypesMinisteres.
@DataClassName('TypeOffrandeRow')
class TypesOffrande extends Table {
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

/// Table Drift Projet (Module XI, RG-XI-03). Le solde n'est pas une colonne
/// stockée : il se recalcule à la lecture (voir `Projet` domaine).
@DataClassName('ProjetRow')
class Projets extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get nom => text()();
  IntColumn get budgetPrevisionnel => integer()();
  TextColumn get devise => text()();
  TextColumn get statut => text().withDefault(const Constant('en_cours'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Contribution (Module XI, RG-XI-01/02/05/06). `fideleId`
/// nullable + `libelleDonateurAnonyme` couvrent le donateur anonyme identifié
/// techniquement (RG-XI-01). `contributionOrigineId` porte la
/// contre-passation tracée (RG-XI-05) : une contribution validée n'est
/// jamais éditée, seulement contre-passée par une nouvelle ligne.
@DataClassName('ContributionRow')
class Contributions extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().nullable().references(Fideles, #id)();
  TextColumn get libelleDonateurAnonyme => text().nullable()();
  TextColumn get typeOffrandeId => text().references(TypesOffrande, #id)();
  IntColumn get montant => integer()();
  TextColumn get devise => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get culteId => text().nullable().references(Cultes, #id)();
  TextColumn get projetId => text().nullable().references(Projets, #id)();
  TextColumn get modePaiement => text()();
  TextColumn get statut => text().withDefault(const Constant('en_attente'))();
  TextColumn get origine => text()();
  DateTimeColumn get dateSaisie => dateTime()();
  TextColumn get valideParFideleId => text().nullable()();
  DateTimeColumn get dateValidation => dateTime().nullable()();
  TextColumn get motifRejet => text().nullable()();
  TextColumn get contributionOrigineId => text().nullable().references(Contributions, #id)();
  BoolColumn get estContrePassation => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift DepenseProjet (Module XI, RG-XI-03). `derogationTracee` +
/// `motifDerogation` couvrent l'engagement d'une dépense au-delà du solde
/// disponible, exceptionnellement autorisé.
@DataClassName('DepenseProjetRow')
class DepensesProjet extends Table {
  TextColumn get id => text()();
  TextColumn get projetId => text().references(Projets, #id)();
  IntColumn get montant => integer()();
  TextColumn get libelle => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get valideParFideleId => text().references(Fideles, #id)();
  BoolColumn get derogationTracee => boolean().withDefault(const Constant(false))();
  TextColumn get motifDerogation => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Engagement (Module XI, RG-XI-04) — engagement récurrent d'un
/// fidèle (dîme d'engagement, promesse de don).
@DataClassName('EngagementRow')
class Engagements extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get type => text()();
  IntColumn get montantPrevu => integer()();
  TextColumn get periodicite => text()();
  DateTimeColumn get dateDebut => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift EcheanceEngagement (Module XI, RG-XI-04). `contributionId`
/// est renseigné si l'échéance est rapprochée manuellement d'une
/// contribution effectivement saisie.
@DataClassName('EcheanceEngagementRow')
class EcheancesEngagement extends Table {
  TextColumn get id => text()();
  TextColumn get engagementId => text().references(Engagements, #id)();
  DateTimeColumn get dateEcheance => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('en_attente'))();
  TextColumn get contributionId => text().nullable().references(Contributions, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift TresorierNoeud (Module XI, RG-XI-02) — désignation d'un
/// fidèle comme trésorier d'un nœud, habilitant la validation comptable au
/// même titre qu'un rang de rôle (l'énum `Role`, Module XXIII, est fermée
/// et ne porte pas de valeur « trésorier » — même motif que
/// `MembreCommission`/`MembresComite`).
@DataClassName('TresorierNoeudRow')
class TresoriersNoeud extends Table {
  TextColumn get id => text()();
  TextColumn get fideleId => text().references(Fideles, #id)();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift CategorieBien (Module XX, RG-XX-01) — référentiel fermé et
/// extensible des catégories de biens du patrimoine.
@DataClassName('CategorieBienRow')
class CategoriesBien extends Table {
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

/// Table Drift Bien (Module XX, RG-XX-01/02/05). `idInventaire` est
/// l'identifiant d'inventaire unique exigé par le Cahier, distinct de `id`.
/// Les colonnes `typeSortie`/`dateSortie`/`valideParFideleIdSortie`/
/// `motifSortie` tracent la sortie définitive du patrimoine (RG-XX-02) ;
/// `seuilAlerteStock` ne s'applique qu'aux biens à gestion de stock
/// (RG-XX-05).
@DataClassName('BienRow')
class Biens extends Table {
  TextColumn get id => text()();
  TextColumn get idInventaire => text()();
  TextColumn get categorieId => text().references(CategoriesBien, #id)();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get designation => text()();
  TextColumn get etat => text().withDefault(const Constant('neuf'))();
  IntColumn get valeurAcquisition => integer()();
  IntColumn get valeurVenale => integer()();
  TextColumn get devise => text()();
  DateTimeColumn get dateAcquisition => dateTime()();
  IntColumn get seuilAlerteStock => integer().nullable()();
  TextColumn get typeSortie => text().nullable()();
  DateTimeColumn get dateSortie => dateTime().nullable()();
  TextColumn get valideParFideleIdSortie => text().nullable().references(Fideles, #id)();
  TextColumn get motifSortie => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (id_inventaire)'];
}

/// Table Drift ReservationBien (Module XX, RG-XX-03). `culteId` référence un
/// culte existant (Module XII) quand `objetReservation` vaut `culte` ;
/// `objetLibre` porte la description libre pour `evenement`/`autre` (le
/// Module XVIII, Événements, n'existe pas encore).
@DataClassName('ReservationBienRow')
class ReservationsBien extends Table {
  TextColumn get id => text()();
  TextColumn get bienId => text().references(Biens, #id)();
  TextColumn get objetReservation => text()();
  TextColumn get culteId => text().nullable().references(Cultes, #id)();
  TextColumn get objetLibre => text().nullable()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift MouvementStock (Module XX, RG-XX-05). La quantité en stock
/// n'est pas une colonne stockée : elle se recalcule à la lecture (voir
/// `PatrimoineRules.calculerQuantiteStock`).
@DataClassName('MouvementStockRow')
class MouvementsStock extends Table {
  TextColumn get id => text()();
  TextColumn get bienId => text().references(Biens, #id)();
  TextColumn get type => text()();
  IntColumn get quantite => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get motif => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift CampagneInventaire (Module XX, RG-XX-04) — entité ajoutée
/// au-delà du tableau minimal du Cahier (même précédent que `ErratumPv` du
/// Module VII) pour porter la campagne de recensement périodique.
@DataClassName('CampagneInventaireRow')
class CampagnesInventaire extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get libelle => text()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateCloture => dateTime().nullable()();
  TextColumn get statut => text().withDefault(const Constant('en_cours'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift PointageInventaire (Module XX, RG-XX-04). `ecartDetecte` est
/// calculé et figé au moment du pointage (enregistrement d'audit, pas un
/// solde courant — voir `PointageInventaire` domaine).
@DataClassName('PointageInventaireRow')
class PointagesInventaire extends Table {
  TextColumn get id => text()();
  TextColumn get campagneId => text().references(CampagnesInventaire, #id)();
  TextColumn get bienId => text().references(Biens, #id)();
  TextColumn get etatConstate => text()();
  IntColumn get quantiteConstatee => integer().nullable()();
  BoolColumn get ecartDetecte => boolean().withDefault(const Constant(false))();
  TextColumn get commentaire => text().nullable()();
  DateTimeColumn get dateDuPointage => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift CompteComptable (Module XXI, RG-XXI-01) — plan comptable
/// paramétrable, référentiel fermé et extensible.
@DataClassName('CompteComptableRow')
class ComptesComptables extends Table {
  TextColumn get id => text()();
  TextColumn get codeCompte => text()();
  TextColumn get libelle => text()();
  TextColumn get type => text()();
  TextColumn get statut => text().withDefault(const Constant('actif'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (code_compte)'];
}

/// Table Drift PeriodeComptable (Module XXI, RG-XXI-03). Globale (aucune
/// colonne `noeud_id`, le Cahier ne le prévoit pas pour cette entité).
@DataClassName('PeriodeComptableRow')
class PeriodesComptables extends Table {
  TextColumn get id => text()();
  IntColumn get exercice => integer()();
  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('ouverte'))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (exercice)'];
}

/// Table Drift EcritureComptable (Module XXI, RG-XXI-01/02/03/05). Chaque
/// opération génère deux lignes équilibrées (débit + crédit) partageant le
/// même `piece_justificative_id` — voir `ComptabiliteRules` et
/// `ComptabiliteRepository`. `rapproche` (RG-XXI-05) est une colonne
/// ajoutée au-delà du tableau minimal du Cahier, même précédent que
/// `Bien.seuilAlerteStock` du Module XX.
@DataClassName('EcritureComptableRow')
class EcrituresComptables extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get compteId => text().references(ComptesComptables, #id)();
  IntColumn get debit => integer().withDefault(const Constant(0))();
  IntColumn get credit => integer().withDefault(const Constant(0))();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get pieceJustificativeId => text().nullable()();
  TextColumn get periodeId => text().references(PeriodesComptables, #id)();
  TextColumn get libelle => text().nullable()();
  BoolColumn get rapproche => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table Drift Budget (Module XXI, RG-XXI-04). `seuilAlertePourcentage` est
/// une colonne ajoutée au-delà du tableau minimal du Cahier (seuil d'alerte
/// « paramétrable » sans support nommé), même précédent que
/// `Bien.seuilAlerteStock` du Module XX ; `null` retombe sur
/// `AppDefaults.comptabiliteSeuilAlerteDepassementPourcentageParDefaut`.
@DataClassName('BudgetRow')
class Budgets extends Table {
  TextColumn get id => text()();
  TextColumn get noeudId => text().references(OrganisationNodes, #id)();
  TextColumn get periodeId => text().references(PeriodesComptables, #id)();
  TextColumn get compteId => text().references(ComptesComptables, #id)();
  IntColumn get montantPrevu => integer()();
  IntColumn get seuilAlertePourcentage => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
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
