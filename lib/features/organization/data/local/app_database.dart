import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/id_generator.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// RG-III-04 — les vingt-quatre types de ministères standards, seedés à la
/// création/mise à niveau de la base locale et dans la migration Supabase
/// correspondante (mêmes codes des deux côtés).
const List<(String code, String libelle)> typesMinisteresStandards = [
  ('chorale', 'Chorale'),
  ('louange', 'Louange'),
  ('intercession', 'Intercession et prière'),
  ('jeunesse', 'Jeunesse'),
  ('diaconat', 'Diaconat'),
  ('media', 'Média'),
  ('sonorisation', 'Sonorisation et son'),
  ('action_sociale', 'Action sociale'),
  ('evangelisation', 'Évangélisation'),
  ('enfants', 'Enfants et école du dimanche'),
  ('hospitalite', 'Hospitalité et accueil'),
  ('protocole', 'Protocole'),
  ('securite', 'Sécurité'),
  ('finances_offrandes', 'Finances et offrandes'),
  ('visitation_pastorale', 'Visitation pastorale'),
  ('enseignement_biblique', 'Enseignement biblique'),
  ('communication', 'Communication'),
  ('technique_informatique', 'Technique et informatique'),
  ('missions', 'Missions'),
  ('patrimoine', 'Construction et patrimoine'),
  ('sport', 'Sport'),
  ('arts_culture', 'Arts et culture'),
  ('femmes', 'Ministère des femmes'),
  ('hommes', 'Ministère des hommes'),
];

/// RG-IV-04 — les neuf dons spirituels (1 Corinthiens 12:8-10), référentiel
/// fixe seedé des deux côtés (local et Supabase, mêmes codes).
const List<(String code, String libelle, String descriptionBiblique)> donsSpirituelsStandards = [
  ('parole_de_sagesse', 'Parole de sagesse', '1 Corinthiens 12:8'),
  ('parole_de_connaissance', 'Parole de connaissance', '1 Corinthiens 12:8'),
  ('foi', 'Foi', '1 Corinthiens 12:9'),
  ('dons_de_guerisons', 'Dons de guérisons', '1 Corinthiens 12:9'),
  ('operations_de_miracles', 'Opérations de miracles', '1 Corinthiens 12:10'),
  ('prophetie', 'Prophétie', '1 Corinthiens 12:10'),
  ('discernement_des_esprits', 'Discernement des esprits', '1 Corinthiens 12:10'),
  ('diverses_langues', 'Diverses langues', '1 Corinthiens 12:10'),
  ('interpretation_des_langues', 'Interprétation des langues', '1 Corinthiens 12:10'),
];

/// RG-V-02 — quelques métiers de départ pour amorcer le référentiel
/// hiérarchisé (catégorie / métier), entièrement paramétrable ensuite
/// (contrairement aux référentiels fixes des Modules III/IV, aucune
/// protection « standard » ici).
const List<(String code, String categorie, String libelle)> professionsDeDepart = [
  ('medecin', 'Santé', 'Médecin'),
  ('infirmier', 'Santé', 'Infirmier'),
  ('enseignant', 'Éducation', 'Enseignant'),
  ('developpeur_informatique', 'Informatique', 'Développeur informatique'),
  ('ingenieur', 'Ingénierie et BTP', 'Ingénieur'),
  ('architecte', 'Ingénierie et BTP', 'Architecte'),
  ('artisan_macon', 'Ingénierie et BTP', 'Artisan / Maçon'),
  ('avocat', 'Droit et affaires', 'Avocat'),
  ('comptable', 'Droit et affaires', 'Comptable'),
  ('entrepreneur', 'Droit et affaires', 'Entrepreneur'),
  ('chauffeur', 'Transport et services', 'Chauffeur'),
  ('commercant', 'Commerce', 'Commerçant'),
];

/// RG-VI-01 — groupes de départ : sept groupes démographiques calculables
/// automatiquement à partir de la fiche fidèle (`criteresJson`, format
/// `CriteresGroupe.toJson()`) et quatre groupes fonctionnels purement
/// manuels (aucun critère calculable). Mêmes codes des deux côtés (local et
/// Supabase).
const List<(String code, String libelle, String typeRegle, String? criteresJson)> groupesEgliseDeDepart = [
  ('hommes', 'Hommes', 'auto', '{"sexe":"masculin"}'),
  ('femmes', 'Femmes', 'auto', '{"sexe":"feminin"}'),
  ('jeunesse', 'Jeunesse', 'auto', '{"ageMin":12,"ageMax":35}'),
  ('couples', 'Couples', 'auto', '{"statutCivil":"marie"}'),
  ('celibataires', 'Célibataires', 'auto', '{"statutCivil":"celibataire"}'),
  ('veuves', 'Veuves', 'auto', '{"statutCivil":"veuf"}'),
  ('nouveaux_convertis', 'Nouveaux convertis', 'auto', '{"statutSpirituel":"nouveau_converti"}'),
  ('missionnaires', 'Missionnaires', 'manuel', null),
  ('pasteurs', 'Pasteurs', 'manuel', null),
  ('anciens', 'Anciens', 'manuel', null),
  ('diacres', 'Diacres', 'manuel', null),
];

/// RG-VIII-01 — nomenclature de départ : un seul type de document producteur
/// existe déjà (le procès-verbal de comité, Module VII). Les autres types
/// (certificats, lettres de mutation, décisions disciplinaires...) seront
/// seedés au fil de la construction de leurs modules producteurs respectifs.
const List<(String typeDocument, String modeleNumerotation)> nomenclaturesArchivageDeDepart = [
  ('proces_verbal_comite', 'PV-{noeud}-{annee}-{sequence}'),
  ('lettre_recommandation', 'LR-{noeud}-{annee}-{sequence}'),
  ('piece_dossier_disciplinaire', 'PD-{noeud}-{annee}-{sequence}'),
];

/// RG-X-02 — natures de faute de départ, référentiel fermé et extensible.
/// Décision pastorale, hors périmètre technique : liste volontairement
/// courte et strictement administrative/procédurale (gouvernance,
/// organisation, engagements) — aucune catégorie à caractère moral,
/// doctrinal ou théologique n'y figure ni ne doit y être ajoutée, y compris
/// dans une évolution future de cette liste (voir AGENTS.md §7, entrée
/// Module X). Toute décision de ce type reste un jugement pastoral rendu
/// hors du logiciel, jamais une catégorie codée en dur ici.
const List<(String code, String libelle)> naturesFauteDeDepart = [
  ('absenteisme_prolonge', 'Absentéisme prolongé et injustifié'),
  ('desobeissance_autorite_pastorale', "Désobéissance à l'autorité pastorale"),
  ('conflit_non_resolu', 'Conflit non résolu avec un membre ou un responsable'),
  ('manquement_engagement_mandat', 'Manquement à un engagement ou à un mandat'),
];

/// RG-XI-01 — types d'offrande de départ, référentiel fermé et extensible
/// (le Cahier cite ces cinq formes dans l'objectif fonctionnel du module).
const List<(String code, String libelle)> typesOffrandeDeDepart = [
  ('ordinaire', 'Offrande ordinaire'),
  ('dime', 'Dîme'),
  ('premices', 'Prémices'),
  ('missionnaire', 'Offrande missionnaire'),
  ('construction', 'Offrande de construction'),
];

/// RG-XX-01 — les neuf catégories de biens de départ, référentiel fermé et
/// extensible (le Cahier cite ces catégories dans l'objectif fonctionnel du
/// module).
const List<(String code, String libelle)> categoriesBienDeDepart = [
  ('terrains', 'Terrains'),
  ('batiments', 'Bâtiments'),
  ('vehicules', 'Véhicules'),
  ('instruments_musique', 'Instruments de musique'),
  ('cameras', 'Caméras'),
  ('sonorisation', 'Sonorisation'),
  ('ordinateurs', 'Ordinateurs'),
  ('mobilier', 'Mobilier'),
  ('stocks', 'Stocks (fournitures)'),
];

/// RG-XXI-01 — plan comptable de départ, référentiel fermé et extensible.
/// Codes génériques (le Cahier n'impose aucun plan comptable réel) : deux
/// comptes de trésorerie (actif), un compte d'immobilisations (actif, débité
/// à l'acquisition/crédité à la sortie d'un bien — RG-XX-02/RG-XXI-02), deux
/// comptes de produits et deux comptes de charges dont un dédié à la valeur
/// comptable des sorties d'actifs (RG-XXI-02).
const List<(String code, String libelle, String type)> comptesComptablesDeDepart = [
  ('512000', 'Banque', 'actif'),
  ('530000', 'Caisse', 'actif'),
  ('211000', 'Immobilisations et biens', 'actif'),
  ('706000', 'Produits des contributions', 'produit'),
  ('758000', 'Produits de cession de biens', 'produit'),
  ('651000', 'Charges diverses', 'charge'),
  ('675000', "Charges — sorties d'actifs", 'charge'),
];

/// Base Drift/SQLite unique, offline-first (RG-OFF-01), partagée par tous
/// les modules (voir AGENTS.md §4).
@DriftDatabase(tables: [
  OrganisationNodes,
  HistoriqueRattachements,
  NodeResponsables,
  Fideles,
  LiensFamiliaux,
  HistoriqueFideles,
  Tuteurs,
  ZonesGeographiques,
  TypesMinisteres,
  Ministeres,
  AffectationsMinisteres,
  MandatsResponsables,
  ActivitesMinisteres,
  DonsSpirituels,
  DonsFideles,
  DonsMinisteresCompatibles,
  Professions,
  ProfessionsFideles,
  Sollicitations,
  GroupesEglise,
  AppartenancesGroupe,
  QuorumsComite,
  MembresComite,
  SeancesComite,
  PresentsSeance,
  Decisions,
  ProcesVerbaux,
  ErratumsPv,
  TachesSuivi,
  Cultes,
  SequencesLiturgiques,
  PresencesCulte,
  PublicationsCulte,
  PropositionsTheme,
  VotesProposition,
  NomenclaturesArchivage,
  DocumentsArchive,
  VersionsDocument,
  Mutations,
  LettresRecommandation,
  NaturesFaute,
  CommissionsDisciplinaires,
  MembresCommissionDisciplinaire,
  DossiersDisciplinaires,
  PiecesDossier,
  ConsultationsDisciplinaires,
  TypesOffrande,
  Projets,
  Contributions,
  DepensesProjet,
  Engagements,
  EcheancesEngagement,
  TresoriersNoeud,
  CategoriesBien,
  Biens,
  ReservationsBien,
  MouvementsStock,
  CampagnesInventaire,
  PointagesInventaire,
  ComptesComptables,
  PeriodesComptables,
  EcrituresComptables,
  Budgets,
  ContenusMediatheque,
  Favoris,
  Commentaires,
  ComptesUtilisateurs,
  JournalLiaisonsComptes,
  SyncOutbox,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 20;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v1 -> v2 : ajout du Module II (Fidèles). Un appareil qui avait
          // déjà créé la base en v1 (sans ces tables) doit les recevoir
          // explicitement — schemaVersion seul ne suffit pas, drift ne
          // recrée jamais rétroactivement un schéma déjà considéré à jour.
          if (from < 2) {
            await m.createTable(fideles);
            await m.createTable(liensFamiliaux);
            await m.createTable(historiqueFideles);
            await m.createTable(tuteurs);
          }
          // v2 -> v3 : ajout du référentiel ZoneGeographique (Module XXIII).
          if (from < 3) {
            await m.createTable(zonesGeographiques);
          }
          // v3 -> v4 : ajout de ResponsableNoeud (Module I, RG-I-05).
          if (from < 4) {
            await m.createTable(nodeResponsables);
          }
          // v4 -> v5 : ajout du Module III (Ministères et départements).
          if (from < 5) {
            await m.createTable(typesMinisteres);
            await m.createTable(ministeres);
            await m.createTable(affectationsMinisteres);
            await m.createTable(mandatsResponsables);
            await m.createTable(activitesMinisteres);
            await _seedTypesMinisteresStandards();
          }
          // v5 -> v6 : ajout du Module IV (Dons spirituels).
          if (from < 6) {
            await m.createTable(donsSpirituels);
            await m.createTable(donsFideles);
            await m.createTable(donsMinisteresCompatibles);
            await _seedDonsSpirituelsStandards();
          }
          // v6 -> v7 : ajout du Module V (Groupes professionnels).
          if (from < 7) {
            await m.createTable(professions);
            await m.createTable(professionsFideles);
            await m.createTable(sollicitations);
            await _seedProfessionsDeDepart();
          }
          // v7 -> v8 : ajout du Module VI (Groupes de l'Église).
          if (from < 8) {
            await m.createTable(groupesEglise);
            await m.createTable(appartenancesGroupe);
            await _seedGroupesEgliseDeDepart();
          }
          // v8 -> v9 : ajout du Module VII (Comité local).
          if (from < 9) {
            await m.createTable(quorumsComite);
            await m.createTable(membresComite);
            await m.createTable(seancesComite);
            await m.createTable(presentsSeance);
            await m.createTable(decisions);
            await m.createTable(procesVerbaux);
            await m.createTable(erratumsPv);
            await m.createTable(tachesSuivi);
          }
          // v9 -> v10 : ajout du Module XII (Cultes).
          if (from < 10) {
            await m.createTable(cultes);
            await m.createTable(sequencesLiturgiques);
            await m.createTable(presencesCulte);
            await m.createTable(publicationsCulte);
            await m.createTable(propositionsTheme);
            await m.createTable(votesProposition);
          }
          // v10 -> v11 : ajout du Module VIII (Archivage documentaire).
          if (from < 11) {
            await m.createTable(nomenclaturesArchivage);
            await m.createTable(documentsArchive);
            await m.createTable(versionsDocument);
            await _seedNomenclaturesArchivageDeDepart();
          }
          // v11 -> v12 : ajout du Module IX (Déplacements) + nomenclature
          // de la lettre de recommandation (RG-IX-02).
          if (from < 12) {
            await m.createTable(mutations);
            await m.createTable(lettresRecommandation);
            await _seedNomenclaturesArchivageDeDepart();
          }
          // v12 -> v13 : ajout du Module X (Discipline).
          if (from < 13) {
            await m.createTable(naturesFaute);
            await m.createTable(commissionsDisciplinaires);
            await m.createTable(membresCommissionDisciplinaire);
            await m.createTable(dossiersDisciplinaires);
            await m.createTable(piecesDossier);
            await _seedNaturesFauteStandards();
            // Backfill : la nomenclature de la pièce de dossier disciplinaire
            // (RG-X-06) s'ajoute à la liste existante (idempotent,
            // insertOrIgnore) plutôt que de dupliquer l'appel de seed.
            await _seedNomenclaturesArchivageDeDepart();
          }
          // v13 -> v14 : ajout du Module XI (Finances).
          if (from < 14) {
            await m.createTable(typesOffrande);
            await m.createTable(projets);
            await m.createTable(contributions);
            await m.createTable(depensesProjet);
            await m.createTable(engagements);
            await m.createTable(echeancesEngagement);
            await m.createTable(tresoriersNoeud);
            await _seedTypesOffrandeStandards();
          }
          // v14 -> v15 : ajout du Module XX (Biens / patrimoine).
          if (from < 15) {
            await m.createTable(categoriesBien);
            await m.createTable(biens);
            await m.createTable(reservationsBien);
            await m.createTable(mouvementsStock);
            await m.createTable(campagnesInventaire);
            await m.createTable(pointagesInventaire);
            await _seedCategoriesBienStandards();
          }
          // v15 -> v16 : ajout du Module XXI (Comptabilité).
          if (from < 16) {
            await m.createTable(comptesComptables);
            await m.createTable(periodesComptables);
            await m.createTable(ecrituresComptables);
            await m.createTable(budgets);
            await _seedComptesComptablesStandards();
            await _seedPeriodeComptableCourante();
          }
          // v16 -> v17 : ajout du Module XIII (Médiathèque chrétienne).
          // Aucun référentiel standard à seeder (pas de liste fermée de
          // types comparable à TypeMinistere/TypeOffrande/ComptesComptables).
          if (from < 17) {
            await m.createTable(contenusMediatheque);
            await m.createTable(favoris);
            await m.createTable(commentaires);
          }
          // v17 -> v18 : authentification (RG-SEC-01). Colonnes de liaison
          // ajoutées seulement si absentes : une base antérieure à v2 vient
          // de créer Fideles ci-dessus avec la définition courante, qui les
          // contient déjà.
          if (from < 18) {
            if (!await _colonneExiste('fideles', 'auth_user_id')) {
              await m.addColumn(fideles, fideles.authUserId);
            }
            if (!await _colonneExiste('fideles', 'role')) {
              await m.addColumn(fideles, fideles.role);
            }
            await customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_fideles_auth_user_id ON fideles (auth_user_id)');
            await m.createTable(comptesUtilisateurs);
            await m.createTable(journalLiaisonsComptes);
          }
          // v18 -> v19 : auteur de la saisie d'une contribution (RG-XI-02,
          // séparation saisie/validation). Même garde que v18 : une base
          // antérieure à v14 vient de créer la table avec la définition courante.
          if (from < 19 && !await _colonneExiste('contributions', 'saisie_par_fidele_id')) {
            await m.addColumn(contributions, contributions.saisieParFideleId);
          }
          // v19 -> v20 : journal des consultations disciplinaires (RG-SEC-06).
          if (from < 20) {
            await m.createTable(consultationsDisciplinaires);
          }
        },
        beforeOpen: (details) async {
          // SQLite n'applique pas les contraintes de clé étrangère par
          // défaut : sans ceci, les `references()` déclarées dans
          // tables.dart ne sont que déclaratives.
          await customStatement('PRAGMA foreign_keys = ON');
          if (details.wasCreated) {
            await _seedTypesMinisteresStandards();
            await _seedDonsSpirituelsStandards();
            await _seedProfessionsDeDepart();
            await _seedGroupesEgliseDeDepart();
            await _seedNomenclaturesArchivageDeDepart();
            await _seedNaturesFauteStandards();
            await _seedTypesOffrandeStandards();
            await _seedCategoriesBienStandards();
            await _seedComptesComptablesStandards();
            await _seedPeriodeComptableCourante();
          }
        },
      );

  Future<bool> _colonneExiste(String table, String colonne) async {
    final colonnes = await customSelect('PRAGMA table_info($table)').get();
    return colonnes.any((ligne) => ligne.read<String>('name') == colonne);
  }

  Future<void> _seedTypesMinisteresStandards() async {
    await batch((b) {
      b.insertAll(
        typesMinisteres,
        [
          for (final (code, libelle) in typesMinisteresStandards)
            TypesMinisteresCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              standard: const Value(true),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedDonsSpirituelsStandards() async {
    await batch((b) {
      b.insertAll(
        donsSpirituels,
        [
          for (final (code, libelle, descriptionBiblique) in donsSpirituelsStandards)
            DonsSpirituelsCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              descriptionBiblique: descriptionBiblique,
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedProfessionsDeDepart() async {
    await batch((b) {
      b.insertAll(
        professions,
        [
          for (final (code, categorie, libelle) in professionsDeDepart)
            ProfessionsCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              categorie: categorie,
              libelle: libelle,
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedGroupesEgliseDeDepart() async {
    await batch((b) {
      b.insertAll(
        groupesEglise,
        [
          for (final (code, libelle, typeRegle, criteresJson) in groupesEgliseDeDepart)
            GroupesEgliseCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              typeRegle: typeRegle,
              criteresJson: Value(criteresJson),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedNomenclaturesArchivageDeDepart() async {
    await batch((b) {
      b.insertAll(
        nomenclaturesArchivage,
        [
          for (final (typeDocument, modeleNumerotation) in nomenclaturesArchivageDeDepart)
            NomenclaturesArchivageCompanion.insert(
              id: IdGenerator.newId(),
              typeDocument: typeDocument,
              modeleNumerotation: modeleNumerotation,
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedNaturesFauteStandards() async {
    await batch((b) {
      b.insertAll(
        naturesFaute,
        [
          for (final (code, libelle) in naturesFauteDeDepart)
            NaturesFauteCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              standard: const Value(true),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedTypesOffrandeStandards() async {
    await batch((b) {
      b.insertAll(
        typesOffrande,
        [
          for (final (code, libelle) in typesOffrandeDeDepart)
            TypesOffrandeCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              standard: const Value(true),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedCategoriesBienStandards() async {
    await batch((b) {
      b.insertAll(
        categoriesBien,
        [
          for (final (code, libelle) in categoriesBienDeDepart)
            CategoriesBienCompanion.insert(
              id: IdGenerator.newId(),
              code: code,
              libelle: libelle,
              standard: const Value(true),
            ),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> _seedComptesComptablesStandards() async {
    await batch((b) {
      b.insertAll(
        comptesComptables,
        [
          for (final (code, libelle, type) in comptesComptablesDeDepart)
            ComptesComptablesCompanion.insert(id: IdGenerator.newId(), codeCompte: code, libelle: libelle, type: type),
        ],
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  /// RG-XXI-03 — amorce une période comptable ouverte pour l'exercice en
  /// cours (année civile), nécessaire pour que la première écriture générée
  /// automatiquement (RG-XXI-02) ait toujours une période où s'imputer.
  /// `insertOrIgnore` sur la contrainte `UNIQUE (exercice)` rend l'opération
  /// idempotente d'une exécution à l'autre.
  Future<void> _seedPeriodeComptableCourante() async {
    final annee = DateTime.now().year;
    await into(periodesComptables).insert(
      PeriodesComptablesCompanion.insert(
        id: IdGenerator.newId(),
        exercice: annee,
        dateDebut: DateTime(annee, 1, 1),
        dateFin: DateTime(annee, 12, 31),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, 'ecclesias_360.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
