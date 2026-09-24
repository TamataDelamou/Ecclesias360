// Préparation des corpus bibliques (Module XXIV, RG-XXIV-01).
//
// Exécution : dart run tool/bible/construire_corpus.dart
//
// Télécharge chaque source, attribue les identifiants de livre stables
// (1..66 protocanon, 67..73 deutérocanoniques — jamais l'ordre d'affichage
// d'une version), construit une base SQLite par version (livres, versets,
// index FTS5 insensible aux accents), applique des contrôles bloquants,
// compresse, puis génère le catalogue initial des versions
// (`lib/features/bible/data/catalogue_versions_initial.dart`).
//
// Sorties :
//   assets/bible/<code>.db.gz        versions embarquées (LSG 1910)
//   build/bible/<code>.db.gz         versions téléchargées à la demande, à
//                                    déposer dans le bucket `corpus-bibliques`
//
// Toute source reste vérifiée à l'édition exacte (méthodologie du dossier de
// reconstruction, §8) : l'édition et la licence déclarées par la source sont
// enregistrées dans chaque base et affichées en fin d'exécution.

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:sqlite3/sqlite3.dart';

/// Version du format des bases produites : à incrémenter si le schéma change
/// (l'application redécompresse alors le corpus embarqué).
const formatCorpus = 1;

class Livre {
  const Livre(this.id, this.nom, this.abreviation);
  final int id;
  final String nom;
  final String abreviation;
}

/// Noms et abréviations d'usage de l'application (libellés éditoriaux, pas
/// ceux d'une édition donnée).
const livres = <Livre>[
  Livre(1, 'Genèse', 'Gn'), Livre(2, 'Exode', 'Ex'), Livre(3, 'Lévitique', 'Lv'), Livre(4, 'Nombres', 'Nb'),
  Livre(5, 'Deutéronome', 'Dt'), Livre(6, 'Josué', 'Jos'), Livre(7, 'Juges', 'Jg'), Livre(8, 'Ruth', 'Rt'),
  Livre(9, '1 Samuel', '1S'), Livre(10, '2 Samuel', '2S'), Livre(11, '1 Rois', '1R'), Livre(12, '2 Rois', '2R'),
  Livre(13, '1 Chroniques', '1Ch'), Livre(14, '2 Chroniques', '2Ch'), Livre(15, 'Esdras', 'Esd'),
  Livre(16, 'Néhémie', 'Né'), Livre(17, 'Esther', 'Est'), Livre(18, 'Job', 'Jb'), Livre(19, 'Psaumes', 'Ps'),
  Livre(20, 'Proverbes', 'Pr'), Livre(21, 'Ecclésiaste', 'Ec'), Livre(22, 'Cantique des cantiques', 'Ct'),
  Livre(23, 'Ésaïe', 'Es'), Livre(24, 'Jérémie', 'Jr'), Livre(25, 'Lamentations', 'Lm'), Livre(26, 'Ézéchiel', 'Ez'),
  Livre(27, 'Daniel', 'Dn'), Livre(28, 'Osée', 'Os'), Livre(29, 'Joël', 'Jl'), Livre(30, 'Amos', 'Am'),
  Livre(31, 'Abdias', 'Ab'), Livre(32, 'Jonas', 'Jon'), Livre(33, 'Michée', 'Mi'), Livre(34, 'Nahum', 'Na'),
  Livre(35, 'Habacuc', 'Ha'), Livre(36, 'Sophonie', 'So'), Livre(37, 'Aggée', 'Ag'), Livre(38, 'Zacharie', 'Za'),
  Livre(39, 'Malachie', 'Ml'), Livre(40, 'Matthieu', 'Mt'), Livre(41, 'Marc', 'Mc'), Livre(42, 'Luc', 'Lc'),
  Livre(43, 'Jean', 'Jn'), Livre(44, 'Actes', 'Ac'), Livre(45, 'Romains', 'Rm'), Livre(46, '1 Corinthiens', '1Co'),
  Livre(47, '2 Corinthiens', '2Co'), Livre(48, 'Galates', 'Ga'), Livre(49, 'Éphésiens', 'Ep'),
  Livre(50, 'Philippiens', 'Ph'), Livre(51, 'Colossiens', 'Col'), Livre(52, '1 Thessaloniciens', '1Th'),
  Livre(53, '2 Thessaloniciens', '2Th'), Livre(54, '1 Timothée', '1Tm'), Livre(55, '2 Timothée', '2Tm'),
  Livre(56, 'Tite', 'Tt'), Livre(57, 'Philémon', 'Phm'), Livre(58, 'Hébreux', 'He'), Livre(59, 'Jacques', 'Jc'),
  Livre(60, '1 Pierre', '1P'), Livre(61, '2 Pierre', '2P'), Livre(62, '1 Jean', '1Jn'), Livre(63, '2 Jean', '2Jn'),
  Livre(64, '3 Jean', '3Jn'), Livre(65, 'Jude', 'Jude'), Livre(66, 'Apocalypse', 'Ap'),
  Livre(67, 'Tobie', 'Tb'), Livre(68, 'Judith', 'Jdt'), Livre(69, '1 Maccabées', '1M'), Livre(70, '2 Maccabées', '2M'),
  Livre(71, 'Sagesse', 'Sg'), Livre(72, 'Siracide', 'Si'), Livre(73, 'Baruch', 'Ba'),
];

/// Codes de livre des fichiers VPL d'ebible.org, dans l'ordre 1..66.
const codesVplEbible = [
  'GEN', 'EXO', 'LEV', 'NUM', 'DEU', 'JOS', 'JDG', 'RUT', '1SA', '2SA', '1KI', '2KI', '1CH', '2CH', 'EZR', 'NEH',
  'EST', 'JOB', 'PSA', 'PRO', 'ECC', 'SOL', 'ISA', 'JER', 'LAM', 'EZE', 'DAN', 'HOS', 'JOE', 'AMO', 'OBA', 'JON',
  'MIC', 'NAH', 'HAB', 'ZEP', 'HAG', 'ZEC', 'MAL', 'MAT', 'MAR', 'LUK', 'JOH', 'ACT', 'ROM', '1CO', '2CO', 'GAL',
  'EPH', 'PHI', 'COL', '1TH', '2TH', '1TI', '2TI', 'TIT', 'PHM', 'HEB', 'JAM', '1PE', '2PE', '1JO', '2JO', '3JO',
  'JUD', 'REV',
];

/// Noms de livre de scrollmapper (anglais) → identifiant stable.
const nomsScrollmapper = {
  'Genesis': 1, 'Exodus': 2, 'Leviticus': 3, 'Numbers': 4, 'Deuteronomy': 5, 'Joshua': 6, 'Judges': 7, 'Ruth': 8,
  'I Samuel': 9, 'II Samuel': 10, 'I Kings': 11, 'II Kings': 12, 'I Chronicles': 13, 'II Chronicles': 14,
  'Ezra': 15, 'Nehemiah': 16, 'Esther': 17, 'Job': 18, 'Psalms': 19, 'Proverbs': 20, 'Ecclesiastes': 21,
  'Song of Solomon': 22, 'Isaiah': 23, 'Jeremiah': 24, 'Lamentations': 25, 'Ezekiel': 26, 'Daniel': 27,
  'Hosea': 28, 'Joel': 29, 'Amos': 30, 'Obadiah': 31, 'Jonah': 32, 'Micah': 33, 'Nahum': 34, 'Habakkuk': 35,
  'Zephaniah': 36, 'Haggai': 37, 'Zechariah': 38, 'Malachi': 39, 'Matthew': 40, 'Mark': 41, 'Luke': 42,
  'John': 43, 'Acts': 44, 'Romans': 45, 'I Corinthians': 46, 'II Corinthians': 47, 'Galatians': 48,
  'Ephesians': 49, 'Philippians': 50, 'Colossians': 51, 'I Thessalonians': 52, 'II Thessalonians': 53,
  'I Timothy': 54, 'II Timothy': 55, 'Titus': 56, 'Philemon': 57, 'Hebrews': 58, 'James': 59, 'I Peter': 60,
  'II Peter': 61, 'I John': 62, 'II John': 63, 'III John': 64, 'Jude': 65, 'Revelation of John': 66,
  'Tobit': 67, 'Judith': 68, 'I Maccabees': 69, 'II Maccabees': 70, 'Wisdom': 71, 'Sirach': 72, 'Baruch': 73,
};

class Verset {
  const Verset(this.livre, this.chapitre, this.verset, this.texte);
  final int livre;
  final int chapitre;
  final int verset;
  final String texte;
}

class SourceVersion {
  const SourceVersion({
    required this.code,
    required this.nom,
    required this.edition,
    required this.licence,
    required this.source,
    required this.embarquee,
    required this.charger,
    this.nomsPropres = const {},
    this.deuterocanoniquesAttendus = false,
    this.corrections = const {},
    this.balisageAdmis = const {},
  });

  final String code;
  final String nom;
  final String edition;
  final String licence;
  final String source;
  final bool embarquee;
  final Map<int, String> nomsPropres;
  final bool deuterocanoniquesAttendus;

  /// Corrections éditoriales nommées, par référence `livre chapitre:verset` :
  /// (texte exact à retirer ou remplacer, remplacement). Une correction dont
  /// le texte n'est plus trouvé fait échouer la construction : une mise à
  /// jour de la source est alors relue, jamais corrigée à l'aveugle.
  final Map<String, (String, String)> corrections;

  /// Références dont les caractères de balisage font partie du texte de
  /// l'édition (ex. accolades de la Crampon) : admises nommément, jamais
  /// en bloc.
  final Set<String> balisageAdmis;

  /// Renvoie les versets dans l'ordre d'affichage de la version.
  final Future<List<Verset>> Function(Directory cache) charger;
}

final sources = <SourceVersion>[
  SourceVersion(
    code: 'lsg1910',
    nom: 'Louis Segond 1910',
    edition: 'Louis Segond, édition de 1910',
    licence: 'Domaine public (ebible.org : « Cette Bible est dans le domaine public »)',
    source: 'https://ebible.org/Scriptures/fraLSG_vpl.zip',
    embarquee: true,
    charger: (cache) => chargerVplEbible(cache, 'fraLSG'),
  ),
  SourceVersion(
    code: 'darby',
    nom: 'Darby',
    edition: 'J.N. Darby, révision JND v2.0 (Bibles et Publications Chrétiennes, 2024) du texte de 1885',
    licence: 'Domaine public (déclaré par Bibles et Publications Chrétiennes, ebible.org)',
    source: 'https://ebible.org/Scriptures/frajnd_vpl.zip',
    embarquee: false,
    charger: (cache) => chargerVplEbible(cache, 'frajnd'),
  ),
  SourceVersion(
    code: 'crampon',
    nom: 'Crampon',
    edition: 'Augustin Crampon, édition de 1923',
    licence: 'Domaine public (scrollmapper/bible_databases, FreCrampon ; dépôt sous licence MIT)',
    source: 'https://raw.githubusercontent.com/scrollmapper/bible_databases/master/sources/fr/FreCrampon/FreCrampon.json',
    embarquee: false,
    nomsPropres: {23: 'Isaïe', 72: 'Ecclésiastique (Siracide)'},
    deuterocanoniquesAttendus: true,
    // Intertitre éditorial fondu dans le dernier verset du Siracide.
    corrections: {'72 50:29': (' <DEUX APPENDICES >', '')},
    // Accolades présentes dans le texte de l'édition : non modifiées.
    balisageAdmis: {'46 12:28'},
    charger: (cache) => chargerJsonScrollmapper(cache, 'FreCrampon'),
  ),
];

Future<List<int>> telecharger(String url, File cible) async {
  if (!cible.existsSync()) {
    stdout.writeln('  téléchargement : $url');
    final client = HttpClient();
    try {
      final reponse = await (await client.getUrl(Uri.parse(url))).close();
      if (reponse.statusCode != 200) throw StateError('HTTP ${reponse.statusCode} pour $url');
      await reponse.pipe(cible.openWrite());
    } finally {
      client.close();
    }
  }
  return cible.readAsBytes();
}

Future<List<Verset>> chargerVplEbible(Directory cache, String id) async {
  final octets = await telecharger('https://ebible.org/Scriptures/${id}_vpl.zip', File('${cache.path}/${id}_vpl.zip'));
  final archive = ZipDecoder().decodeBytes(octets);
  final fichier = archive.files.firstWhere((f) => f.name.endsWith('_vpl.txt'));
  final lignes = const LineSplitter().convert(utf8.decode(fichier.content as List<int>));
  final motif = RegExp(r'^(\S+) (\d+):(\d+) (.*)$');
  final versets = <Verset>[];
  for (final ligne in lignes) {
    if (ligne.trim().isEmpty) continue;
    final m = motif.firstMatch(ligne);
    if (m == null) throw StateError('Ligne VPL illisible : $ligne');
    final indice = codesVplEbible.indexOf(m[1]!);
    if (indice < 0) throw StateError('Code de livre inconnu : ${m[1]}');
    versets.add(Verset(indice + 1, int.parse(m[2]!), int.parse(m[3]!), m[4]!.trim()));
  }
  return versets;
}

Future<List<Verset>> chargerJsonScrollmapper(Directory cache, String id) async {
  final octets = await telecharger(
    'https://raw.githubusercontent.com/scrollmapper/bible_databases/master/sources/fr/$id/$id.json',
    File('${cache.path}/$id.json'),
  );
  final donnees = jsonDecode(utf8.decode(octets)) as Map<String, dynamic>;
  final versets = <Verset>[];
  for (final livre in donnees['books'] as List<dynamic>) {
    final nom = (livre as Map<String, dynamic>)['name'] as String;
    final id = nomsScrollmapper[nom];
    if (id == null) throw StateError('Livre scrollmapper non attribué : $nom');
    for (final chapitre in livre['chapters'] as List<dynamic>) {
      for (final v in (chapitre as Map<String, dynamic>)['verses'] as List<dynamic>) {
        final verset = v as Map<String, dynamic>;
        versets.add(Verset(id, verset['chapter'] as int, verset['verse'] as int, (verset['text'] as String).trim()));
      }
    }
  }
  return versets;
}

class Bilan {
  Bilan(this.source, this.livres, this.chapitres, this.versets, this.octets, this.sha256, this.fichier, this.omis);
  final SourceVersion source;
  final int livres;
  final int chapitres;
  final int versets;
  final int octets;
  final String sha256;
  final String fichier;
  final List<String> omis;
}

/// Contrôles bloquants : un corpus qui échoue n'est jamais produit.
void controler(SourceVersion source, List<Verset> versets) {
  void exiger(bool condition, String message) {
    if (!condition) throw StateError('[${source.code}] $message');
  }

  final parLivre = <int, Set<int>>{};
  final vus = <String>{};
  for (final v in versets) {
    final reference = '${v.livre} ${v.chapitre}:${v.verset}';
    exiger(source.balisageAdmis.contains(reference) || !RegExp(r'[<>{}\\|]').hasMatch(v.texte),
        'balisage résiduel $reference : ${v.texte}');
    exiger(vus.add('${v.livre}-${v.chapitre}-${v.verset}'), 'verset en double ${v.livre} ${v.chapitre}:${v.verset}');
    parLivre.putIfAbsent(v.livre, () => {}).add(v.chapitre);
  }
  for (final id in List.generate(66, (i) => i + 1)) {
    exiger(parLivre.containsKey(id), 'livre protocanonique $id absent');
  }
  for (final entree in parLivre.entries) {
    final chapitres = entree.value.toList()..sort();
    exiger(chapitres.first == 1 && chapitres.last == chapitres.length, 'chapitres non contigus, livre ${entree.key}');
  }
  final deutero = parLivre.keys.where((id) => id > 66).toSet();
  if (source.deuterocanoniquesAttendus) {
    exiger(deutero.length == 7 && deutero.every((id) => id <= 73), 'deutérocanoniques attendus 67..73, trouvés $deutero');
  } else {
    exiger(deutero.isEmpty, 'deutérocanoniques inattendus : $deutero');
  }
}

Future<Bilan> construire(SourceVersion source, Directory cache) async {
  stdout.writeln('== ${source.code}');
  final aCorriger = Map.of(source.corrections);
  final bruts = [
    for (final v in await source.charger(cache))
      switch (aCorriger.remove('${v.livre} ${v.chapitre}:${v.verset}')) {
        null => v,
        (final retire, final remplacement) => v.texte.contains(retire)
            ? Verset(v.livre, v.chapitre, v.verset, v.texte.replaceFirst(retire, remplacement).trim())
            : throw StateError('[${source.code}] correction introuvable ${v.livre} ${v.chapitre}:${v.verset}'),
      },
  ];
  if (aCorriger.isNotEmpty) throw StateError('[${source.code}] corrections sans verset : ${aCorriger.keys}');
  // Un verset vide est une omission de l'édition (ex. Mt 23,14, absent du
  // texte critique) : exclu du corpus, jamais comblé, et listé au bilan.
  final omis = bruts.where((v) => v.texte.isEmpty).map((v) => '${v.livre} ${v.chapitre}:${v.verset}').toList();
  final versets = bruts.where((v) => v.texte.isNotEmpty).toList();
  controler(source, versets);

  final temporaire = File('${cache.path}/${source.code}.db');
  if (temporaire.existsSync()) temporaire.deleteSync();
  final db = sqlite3.open(temporaire.path);
  try {
    db.execute('''
      CREATE TABLE version (code TEXT NOT NULL, nom TEXT NOT NULL, edition TEXT NOT NULL,
        licence TEXT NOT NULL, source TEXT NOT NULL, format INTEGER NOT NULL);
      CREATE TABLE livres (book_id INTEGER PRIMARY KEY, nom TEXT NOT NULL, abreviation TEXT NOT NULL,
        ordre INTEGER NOT NULL, deuterocanonique INTEGER NOT NULL, nb_chapitres INTEGER NOT NULL);
      CREATE TABLE versets (id INTEGER PRIMARY KEY, book_id INTEGER NOT NULL, chapitre INTEGER NOT NULL,
        verset INTEGER NOT NULL, texte TEXT NOT NULL);
      CREATE UNIQUE INDEX versets_reference ON versets (book_id, chapitre, verset);
      CREATE VIRTUAL TABLE versets_fts USING fts5(texte, content='versets', content_rowid='id',
        tokenize='unicode61 remove_diacritics 2');
    ''');
    db.execute('INSERT INTO version VALUES (?, ?, ?, ?, ?, ?)',
        [source.code, source.nom, source.edition, source.licence, source.source, formatCorpus]);

    final ordre = <int>[];
    final chapitres = <int, int>{};
    for (final v in versets) {
      if (!ordre.contains(v.livre)) ordre.add(v.livre);
      chapitres[v.livre] = (chapitres[v.livre] ?? 0) < v.chapitre ? v.chapitre : chapitres[v.livre]!;
    }
    final insertionLivre = db.prepare('INSERT INTO livres VALUES (?, ?, ?, ?, ?, ?)');
    for (var i = 0; i < ordre.length; i++) {
      final livre = livres.firstWhere((l) => l.id == ordre[i]);
      insertionLivre.execute([
        livre.id,
        source.nomsPropres[livre.id] ?? livre.nom,
        livre.abreviation,
        i + 1,
        livre.id > 66 ? 1 : 0,
        chapitres[livre.id],
      ]);
    }
    insertionLivre.close();

    db.execute('BEGIN');
    final insertionVerset = db.prepare('INSERT INTO versets (book_id, chapitre, verset, texte) VALUES (?, ?, ?, ?)');
    for (final v in versets) {
      insertionVerset.execute([v.livre, v.chapitre, v.verset, v.texte]);
    }
    insertionVerset.close();
    db.execute("INSERT INTO versets_fts (versets_fts) VALUES ('rebuild')");
    db.execute('COMMIT');
    db.execute("INSERT INTO versets_fts (versets_fts) VALUES ('optimize')");
    // Lu par Drift en lecture seule : user_version = schemaVersion (1), pour
    // que Drift ne tente jamais de créer un schéma dans le corpus.
    db.execute('PRAGMA user_version = 1');
    db.execute('VACUUM');
  } finally {
    db.close();
  }

  final compresse = GZipCodec(level: 9).encode(temporaire.readAsBytesSync());
  final dossier = Directory(source.embarquee ? 'assets/bible' : 'build/bible')..createSync(recursive: true);
  final fichier = '${source.code}.db.gz';
  File('${dossier.path}/$fichier').writeAsBytesSync(compresse);

  final nbChapitres = versets.map((v) => '${v.livre}-${v.chapitre}').toSet().length;
  final nbLivres = versets.map((v) => v.livre).toSet().length;
  return Bilan(source, nbLivres, nbChapitres, versets.length, compresse.length, sha256.convert(compresse).toString(),
      fichier, omis);
}

String chaine(String s) => "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'")}'";

void genererCatalogue(List<Bilan> bilans) {
  final tampon = StringBuffer()
    ..writeln('// GÉNÉRÉ par tool/bible/construire_corpus.dart — ne pas modifier à la main.')
    ..writeln('//')
    ..writeln('// Catalogue initial des versions bibliques (RG-XXIV-01), inséré dans le')
    ..writeln('// référentiel `versions_bibliques` : un référentiel en données, jamais un')
    ..writeln('// enum figé (AGENTS.md §12 point 4).')
    ..writeln()
    ..writeln("import '../domain/models/version_biblique.dart';")
    ..writeln()
    ..writeln('/// Format des bases produites ; son changement redéclenche la décompression.')
    ..writeln('const formatCorpusBiblique = $formatCorpus;')
    ..writeln()
    ..writeln('const catalogueVersionsInitial = <VersionBiblique>[');
  for (final b in bilans) {
    tampon
      ..writeln('  VersionBiblique(')
      ..writeln('    code: ${chaine(b.source.code)},')
      ..writeln('    nom: ${chaine(b.source.nom)},')
      ..writeln("    langue: 'fr',")
      ..writeln('    edition: ${chaine(b.source.edition)},')
      ..writeln('    licence: ${chaine(b.source.licence)},')
      ..writeln('    source: ${chaine(b.source.source)},')
      ..writeln('    embarquee: ${b.source.embarquee},')
      ..writeln('    fichier: ${chaine(b.fichier)},')
      ..writeln('    taille: ${b.octets},')
      ..writeln('    sha256: ${chaine(b.sha256)},')
      ..writeln('    nbLivres: ${b.livres},')
      ..writeln('    nbVersets: ${b.versets},')
      ..writeln('  ),');
  }
  tampon.writeln('];');
  File('lib/features/bible/data/catalogue_versions_initial.dart')
    ..createSync(recursive: true)
    ..writeAsStringSync(tampon.toString());
}

Future<void> main() async {
  final cache = Directory('build/bible/sources')..createSync(recursive: true);
  final bilans = <Bilan>[];
  for (final source in sources) {
    bilans.add(await construire(source, cache));
  }
  genererCatalogue(bilans);

  stdout.writeln('\nBilan (format $formatCorpus) :');
  for (final b in bilans) {
    stdout.writeln('- ${b.source.code} : ${b.livres} livres, ${b.chapitres} chapitres, ${b.versets} versets, '
        '${(b.octets / 1024 / 1024).toStringAsFixed(2)} Mio compressés, '
        '${b.source.embarquee ? 'embarquée' : 'à téléverser'} (${b.fichier})\n'
        '  édition : ${b.source.edition}\n  licence : ${b.source.licence}\n  sha256 : ${b.sha256}\n'
        '  corrections nommées : ${b.source.corrections.keys.join(', ')}'
        '${b.source.corrections.isEmpty ? 'aucune' : ''} ; balisage admis : '
        '${b.source.balisageAdmis.isEmpty ? 'aucun' : b.source.balisageAdmis.join(', ')}\n'
        '  versets vides exclus : ${b.omis.length}${b.omis.length > 10 ? '' : ' ${b.omis.join(', ')}'}');
    // Liste complète des exclusions, pour relecture.
    File('build/bible/${b.source.code}_versets_exclus.txt').writeAsStringSync(b.omis.join('\n'));
  }
}
