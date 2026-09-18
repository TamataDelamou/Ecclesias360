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
