import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../../domain/models/livre_biblique.dart';
import '../../domain/rules/recherche_biblique_rules.dart';

part 'bible_corpus_database.g.dart';

/// Table `livres` du corpus, déclarée au schéma exact du fichier produit par
/// l'outil (jamais créée par Drift : voir [BibleCorpusDatabase.migration]).
@DataClassName('LivreCorpusRow')
class Livres extends Table {
  IntColumn get bookId => integer().named('book_id')();
  TextColumn get nom => text()();
  TextColumn get abreviation => text()();
  IntColumn get ordre => integer()();
  BoolColumn get deuterocanonique => boolean()();
  IntColumn get nbChapitres => integer().named('nb_chapitres')();

  @override
  Set<Column> get primaryKey => {bookId};
}

/// Table `versets` du corpus (l'index `versets_fts` n'est lu que par SQL).
@DataClassName('VersetCorpusRow')
class Versets extends Table {
  IntColumn get id => integer()();
  IntColumn get bookId => integer().named('book_id')();
  IntColumn get chapitre => integer()();
  IntColumn get verset => integer()();
  TextColumn get texte => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Seconde base Drift du Module XXIV : le corpus d'**une** version biblique
/// (livres, versets, index FTS5 insensible aux accents), produit par
/// `tool/bible/construire_corpus.dart`. Ouverte en lecture seule
/// (`query_only`) : le corpus n'est jamais modifié par l'application. Le
/// fichier porte `user_version = 1`, égal à [schemaVersion], pour que Drift
/// ne tente jamais d'y créer un schéma. Toutes les lectures passent par des
/// requêtes SQL (le schéma est celui du fichier, pas celui de Drift).
@DriftDatabase(tables: [Livres, Versets])
class BibleCorpusDatabase extends _$BibleCorpusDatabase {
  BibleCorpusDatabase(File fichier)
      : super(NativeDatabase(fichier, setup: (db) => db.execute('PRAGMA query_only = ON')));

  BibleCorpusDatabase.surExecuteur(super.executeur);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => throw StateError('Corpus biblique sans schéma : fichier invalide.'),
        onUpgrade: (m, from, to) async => throw StateError('Corpus biblique de format inattendu ($from).'),
      );

  /// Livres de la version, dans son ordre d'affichage.
  Future<List<LivreBiblique>> lireLivres() async {
    final lignes = await (select(livres)..orderBy([(t) => OrderingTerm.asc(t.ordre)])).get();
    return [
      for (final l in lignes)
        LivreBiblique(
          bookId: l.bookId,
          nom: l.nom,
          abreviation: l.abreviation,
          ordre: l.ordre,
          deuterocanonique: l.deuterocanonique,
          nbChapitres: l.nbChapitres,
        ),
    ];
  }

  Future<List<VersetBiblique>> chapitre(int bookId, int chapitre) async {
    final lignes = await (select(versets)
          ..where((t) => t.bookId.equals(bookId) & t.chapitre.equals(chapitre))
          ..orderBy([(t) => OrderingTerm.asc(t.verset)]))
        .get();
    return lignes.map(_depuisLigne).toList(growable: false);
  }

  Future<VersetBiblique?> verset(ReferenceBiblique reference) async {
    final numero = reference.verset;
    if (numero == null) return null;
    final ligne = await (select(versets)
          ..where((t) =>
              t.bookId.equals(reference.bookId) & t.chapitre.equals(reference.chapitre) & t.verset.equals(numero)))
        .getSingleOrNull();
    return ligne == null ? null : _depuisLigne(ligne);
  }

  VersetBiblique _depuisLigne(VersetCorpusRow l) =>
      VersetBiblique(bookId: l.bookId, chapitre: l.chapitre, verset: l.verset, texte: l.texte);

  /// RG-XXIV-05 — recherche locale (FTS5), par pertinence puis dans l'ordre
  /// d'affichage de la version.
  Future<List<VersetBiblique>> rechercher(String saisie, {int limite = 100}) async {
    final expression = RechercheBibliqueRules.expressionFts(saisie);
    if (expression == null) return const [];
    final lignes = await customSelect(
      'SELECT v.book_id, v.chapitre, v.verset, v.texte FROM versets_fts f '
      'JOIN versets v ON v.id = f.rowid '
      'JOIN livres l ON l.book_id = v.book_id '
      'WHERE versets_fts MATCH ? ORDER BY l.ordre, v.chapitre, v.verset LIMIT ?',
      variables: [Variable.withString(expression), Variable.withInt(limite)],
    ).get();
    return lignes.map(_verset).toList(growable: false);
  }

  VersetBiblique _verset(QueryRow l) => VersetBiblique(
        bookId: l.read<int>('book_id'),
        chapitre: l.read<int>('chapitre'),
        verset: l.read<int>('verset'),
        texte: l.read<String>('texte'),
      );
}
