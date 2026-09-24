// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_corpus_database.dart';

// ignore_for_file: type=lint
class $LivresTable extends Livres with TableInfo<$LivresTable, LivreCorpusRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LivresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abreviationMeta = const VerificationMeta(
    'abreviation',
  );
  @override
  late final GeneratedColumn<String> abreviation = GeneratedColumn<String>(
    'abreviation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordreMeta = const VerificationMeta('ordre');
  @override
  late final GeneratedColumn<int> ordre = GeneratedColumn<int>(
    'ordre',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deuterocanoniqueMeta = const VerificationMeta(
    'deuterocanonique',
  );
  @override
  late final GeneratedColumn<bool> deuterocanonique = GeneratedColumn<bool>(
    'deuterocanonique',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deuterocanonique" IN (0, 1))',
    ),
  );
  static const VerificationMeta _nbChapitresMeta = const VerificationMeta(
    'nbChapitres',
  );
  @override
  late final GeneratedColumn<int> nbChapitres = GeneratedColumn<int>(
    'nb_chapitres',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookId,
    nom,
    abreviation,
    ordre,
    deuterocanonique,
    nbChapitres,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'livres';
  @override
  VerificationContext validateIntegrity(
    Insertable<LivreCorpusRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('abreviation')) {
      context.handle(
        _abreviationMeta,
        abreviation.isAcceptableOrUnknown(
          data['abreviation']!,
          _abreviationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_abreviationMeta);
    }
    if (data.containsKey('ordre')) {
      context.handle(
        _ordreMeta,
        ordre.isAcceptableOrUnknown(data['ordre']!, _ordreMeta),
      );
    } else if (isInserting) {
      context.missing(_ordreMeta);
    }
    if (data.containsKey('deuterocanonique')) {
      context.handle(
        _deuterocanoniqueMeta,
        deuterocanonique.isAcceptableOrUnknown(
          data['deuterocanonique']!,
          _deuterocanoniqueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deuterocanoniqueMeta);
    }
    if (data.containsKey('nb_chapitres')) {
      context.handle(
        _nbChapitresMeta,
        nbChapitres.isAcceptableOrUnknown(
          data['nb_chapitres']!,
          _nbChapitresMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nbChapitresMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};
  @override
  LivreCorpusRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LivreCorpusRow(
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      abreviation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abreviation'],
      )!,
      ordre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordre'],
      )!,
      deuterocanonique: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deuterocanonique'],
      )!,
      nbChapitres: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nb_chapitres'],
      )!,
    );
  }

  @override
  $LivresTable createAlias(String alias) {
    return $LivresTable(attachedDatabase, alias);
  }
}

class LivreCorpusRow extends DataClass implements Insertable<LivreCorpusRow> {
  final int bookId;
  final String nom;
  final String abreviation;
  final int ordre;
  final bool deuterocanonique;
  final int nbChapitres;
  const LivreCorpusRow({
    required this.bookId,
    required this.nom,
    required this.abreviation,
    required this.ordre,
    required this.deuterocanonique,
    required this.nbChapitres,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_id'] = Variable<int>(bookId);
    map['nom'] = Variable<String>(nom);
    map['abreviation'] = Variable<String>(abreviation);
    map['ordre'] = Variable<int>(ordre);
    map['deuterocanonique'] = Variable<bool>(deuterocanonique);
    map['nb_chapitres'] = Variable<int>(nbChapitres);
    return map;
  }

  LivresCompanion toCompanion(bool nullToAbsent) {
    return LivresCompanion(
      bookId: Value(bookId),
      nom: Value(nom),
      abreviation: Value(abreviation),
      ordre: Value(ordre),
      deuterocanonique: Value(deuterocanonique),
      nbChapitres: Value(nbChapitres),
    );
  }

  factory LivreCorpusRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LivreCorpusRow(
      bookId: serializer.fromJson<int>(json['bookId']),
      nom: serializer.fromJson<String>(json['nom']),
      abreviation: serializer.fromJson<String>(json['abreviation']),
      ordre: serializer.fromJson<int>(json['ordre']),
      deuterocanonique: serializer.fromJson<bool>(json['deuterocanonique']),
      nbChapitres: serializer.fromJson<int>(json['nbChapitres']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookId': serializer.toJson<int>(bookId),
      'nom': serializer.toJson<String>(nom),
      'abreviation': serializer.toJson<String>(abreviation),
      'ordre': serializer.toJson<int>(ordre),
      'deuterocanonique': serializer.toJson<bool>(deuterocanonique),
      'nbChapitres': serializer.toJson<int>(nbChapitres),
    };
  }

  LivreCorpusRow copyWith({
    int? bookId,
    String? nom,
    String? abreviation,
    int? ordre,
    bool? deuterocanonique,
    int? nbChapitres,
  }) => LivreCorpusRow(
    bookId: bookId ?? this.bookId,
    nom: nom ?? this.nom,
    abreviation: abreviation ?? this.abreviation,
    ordre: ordre ?? this.ordre,
    deuterocanonique: deuterocanonique ?? this.deuterocanonique,
    nbChapitres: nbChapitres ?? this.nbChapitres,
  );
  LivreCorpusRow copyWithCompanion(LivresCompanion data) {
    return LivreCorpusRow(
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      nom: data.nom.present ? data.nom.value : this.nom,
      abreviation: data.abreviation.present
          ? data.abreviation.value
          : this.abreviation,
      ordre: data.ordre.present ? data.ordre.value : this.ordre,
      deuterocanonique: data.deuterocanonique.present
          ? data.deuterocanonique.value
          : this.deuterocanonique,
      nbChapitres: data.nbChapitres.present
          ? data.nbChapitres.value
          : this.nbChapitres,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LivreCorpusRow(')
          ..write('bookId: $bookId, ')
          ..write('nom: $nom, ')
          ..write('abreviation: $abreviation, ')
          ..write('ordre: $ordre, ')
          ..write('deuterocanonique: $deuterocanonique, ')
          ..write('nbChapitres: $nbChapitres')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    bookId,
    nom,
    abreviation,
    ordre,
    deuterocanonique,
    nbChapitres,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LivreCorpusRow &&
          other.bookId == this.bookId &&
          other.nom == this.nom &&
          other.abreviation == this.abreviation &&
          other.ordre == this.ordre &&
          other.deuterocanonique == this.deuterocanonique &&
          other.nbChapitres == this.nbChapitres);
}

class LivresCompanion extends UpdateCompanion<LivreCorpusRow> {
  final Value<int> bookId;
  final Value<String> nom;
  final Value<String> abreviation;
  final Value<int> ordre;
  final Value<bool> deuterocanonique;
  final Value<int> nbChapitres;
  const LivresCompanion({
    this.bookId = const Value.absent(),
    this.nom = const Value.absent(),
    this.abreviation = const Value.absent(),
    this.ordre = const Value.absent(),
    this.deuterocanonique = const Value.absent(),
    this.nbChapitres = const Value.absent(),
  });
  LivresCompanion.insert({
    this.bookId = const Value.absent(),
    required String nom,
    required String abreviation,
    required int ordre,
    required bool deuterocanonique,
    required int nbChapitres,
  }) : nom = Value(nom),
       abreviation = Value(abreviation),
       ordre = Value(ordre),
       deuterocanonique = Value(deuterocanonique),
       nbChapitres = Value(nbChapitres);
  static Insertable<LivreCorpusRow> custom({
    Expression<int>? bookId,
    Expression<String>? nom,
    Expression<String>? abreviation,
    Expression<int>? ordre,
    Expression<bool>? deuterocanonique,
    Expression<int>? nbChapitres,
  }) {
    return RawValuesInsertable({
      if (bookId != null) 'book_id': bookId,
      if (nom != null) 'nom': nom,
      if (abreviation != null) 'abreviation': abreviation,
      if (ordre != null) 'ordre': ordre,
      if (deuterocanonique != null) 'deuterocanonique': deuterocanonique,
      if (nbChapitres != null) 'nb_chapitres': nbChapitres,
    });
  }

  LivresCompanion copyWith({
    Value<int>? bookId,
    Value<String>? nom,
    Value<String>? abreviation,
    Value<int>? ordre,
    Value<bool>? deuterocanonique,
    Value<int>? nbChapitres,
  }) {
    return LivresCompanion(
      bookId: bookId ?? this.bookId,
      nom: nom ?? this.nom,
      abreviation: abreviation ?? this.abreviation,
      ordre: ordre ?? this.ordre,
      deuterocanonique: deuterocanonique ?? this.deuterocanonique,
      nbChapitres: nbChapitres ?? this.nbChapitres,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (abreviation.present) {
      map['abreviation'] = Variable<String>(abreviation.value);
    }
    if (ordre.present) {
      map['ordre'] = Variable<int>(ordre.value);
    }
    if (deuterocanonique.present) {
      map['deuterocanonique'] = Variable<bool>(deuterocanonique.value);
    }
    if (nbChapitres.present) {
      map['nb_chapitres'] = Variable<int>(nbChapitres.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LivresCompanion(')
          ..write('bookId: $bookId, ')
          ..write('nom: $nom, ')
          ..write('abreviation: $abreviation, ')
          ..write('ordre: $ordre, ')
          ..write('deuterocanonique: $deuterocanonique, ')
          ..write('nbChapitres: $nbChapitres')
          ..write(')'))
        .toString();
  }
}

class $VersetsTable extends Versets
    with TableInfo<$VersetsTable, VersetCorpusRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapitreMeta = const VerificationMeta(
    'chapitre',
  );
  @override
  late final GeneratedColumn<int> chapitre = GeneratedColumn<int>(
    'chapitre',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versetMeta = const VerificationMeta('verset');
  @override
  late final GeneratedColumn<int> verset = GeneratedColumn<int>(
    'verset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _texteMeta = const VerificationMeta('texte');
  @override
  late final GeneratedColumn<String> texte = GeneratedColumn<String>(
    'texte',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bookId, chapitre, verset, texte];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'versets';
  @override
  VerificationContext validateIntegrity(
    Insertable<VersetCorpusRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapitre')) {
      context.handle(
        _chapitreMeta,
        chapitre.isAcceptableOrUnknown(data['chapitre']!, _chapitreMeta),
      );
    } else if (isInserting) {
      context.missing(_chapitreMeta);
    }
    if (data.containsKey('verset')) {
      context.handle(
        _versetMeta,
        verset.isAcceptableOrUnknown(data['verset']!, _versetMeta),
      );
    } else if (isInserting) {
      context.missing(_versetMeta);
    }
    if (data.containsKey('texte')) {
      context.handle(
        _texteMeta,
        texte.isAcceptableOrUnknown(data['texte']!, _texteMeta),
      );
    } else if (isInserting) {
      context.missing(_texteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VersetCorpusRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VersetCorpusRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      chapitre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapitre'],
      )!,
      verset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}verset'],
      )!,
      texte: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}texte'],
      )!,
    );
  }

  @override
  $VersetsTable createAlias(String alias) {
    return $VersetsTable(attachedDatabase, alias);
  }
}

class VersetCorpusRow extends DataClass implements Insertable<VersetCorpusRow> {
  final int id;
  final int bookId;
  final int chapitre;
  final int verset;
  final String texte;
  const VersetCorpusRow({
    required this.id,
    required this.bookId,
    required this.chapitre,
    required this.verset,
    required this.texte,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapitre'] = Variable<int>(chapitre);
    map['verset'] = Variable<int>(verset);
    map['texte'] = Variable<String>(texte);
    return map;
  }

  VersetsCompanion toCompanion(bool nullToAbsent) {
    return VersetsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapitre: Value(chapitre),
      verset: Value(verset),
      texte: Value(texte),
    );
  }

  factory VersetCorpusRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VersetCorpusRow(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapitre: serializer.fromJson<int>(json['chapitre']),
      verset: serializer.fromJson<int>(json['verset']),
      texte: serializer.fromJson<String>(json['texte']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapitre': serializer.toJson<int>(chapitre),
      'verset': serializer.toJson<int>(verset),
      'texte': serializer.toJson<String>(texte),
    };
  }

  VersetCorpusRow copyWith({
    int? id,
    int? bookId,
    int? chapitre,
    int? verset,
    String? texte,
  }) => VersetCorpusRow(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapitre: chapitre ?? this.chapitre,
    verset: verset ?? this.verset,
    texte: texte ?? this.texte,
  );
  VersetCorpusRow copyWithCompanion(VersetsCompanion data) {
    return VersetCorpusRow(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapitre: data.chapitre.present ? data.chapitre.value : this.chapitre,
      verset: data.verset.present ? data.verset.value : this.verset,
      texte: data.texte.present ? data.texte.value : this.texte,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VersetCorpusRow(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapitre: $chapitre, ')
          ..write('verset: $verset, ')
          ..write('texte: $texte')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, chapitre, verset, texte);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VersetCorpusRow &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapitre == this.chapitre &&
          other.verset == this.verset &&
          other.texte == this.texte);
}

class VersetsCompanion extends UpdateCompanion<VersetCorpusRow> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapitre;
  final Value<int> verset;
  final Value<String> texte;
  const VersetsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapitre = const Value.absent(),
    this.verset = const Value.absent(),
    this.texte = const Value.absent(),
  });
  VersetsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapitre,
    required int verset,
    required String texte,
  }) : bookId = Value(bookId),
       chapitre = Value(chapitre),
       verset = Value(verset),
       texte = Value(texte);
  static Insertable<VersetCorpusRow> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapitre,
    Expression<int>? verset,
    Expression<String>? texte,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapitre != null) 'chapitre': chapitre,
      if (verset != null) 'verset': verset,
      if (texte != null) 'texte': texte,
    });
  }

  VersetsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<int>? chapitre,
    Value<int>? verset,
    Value<String>? texte,
  }) {
    return VersetsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapitre: chapitre ?? this.chapitre,
      verset: verset ?? this.verset,
      texte: texte ?? this.texte,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapitre.present) {
      map['chapitre'] = Variable<int>(chapitre.value);
    }
    if (verset.present) {
      map['verset'] = Variable<int>(verset.value);
    }
    if (texte.present) {
      map['texte'] = Variable<String>(texte.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersetsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapitre: $chapitre, ')
          ..write('verset: $verset, ')
          ..write('texte: $texte')
          ..write(')'))
        .toString();
  }
}

abstract class _$BibleCorpusDatabase extends GeneratedDatabase {
  _$BibleCorpusDatabase(QueryExecutor e) : super(e);
  $BibleCorpusDatabaseManager get managers => $BibleCorpusDatabaseManager(this);
  late final $LivresTable livres = $LivresTable(this);
  late final $VersetsTable versets = $VersetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [livres, versets];
}

typedef $$LivresTableCreateCompanionBuilder =
    LivresCompanion Function({
      Value<int> bookId,
      required String nom,
      required String abreviation,
      required int ordre,
      required bool deuterocanonique,
      required int nbChapitres,
    });
typedef $$LivresTableUpdateCompanionBuilder =
    LivresCompanion Function({
      Value<int> bookId,
      Value<String> nom,
      Value<String> abreviation,
      Value<int> ordre,
      Value<bool> deuterocanonique,
      Value<int> nbChapitres,
    });

class $$LivresTableFilterComposer
    extends Composer<_$BibleCorpusDatabase, $LivresTable> {
  $$LivresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abreviation => $composableBuilder(
    column: $table.abreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordre => $composableBuilder(
    column: $table.ordre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deuterocanonique => $composableBuilder(
    column: $table.deuterocanonique,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nbChapitres => $composableBuilder(
    column: $table.nbChapitres,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LivresTableOrderingComposer
    extends Composer<_$BibleCorpusDatabase, $LivresTable> {
  $$LivresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abreviation => $composableBuilder(
    column: $table.abreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordre => $composableBuilder(
    column: $table.ordre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deuterocanonique => $composableBuilder(
    column: $table.deuterocanonique,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nbChapitres => $composableBuilder(
    column: $table.nbChapitres,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LivresTableAnnotationComposer
    extends Composer<_$BibleCorpusDatabase, $LivresTable> {
  $$LivresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get abreviation => $composableBuilder(
    column: $table.abreviation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ordre =>
      $composableBuilder(column: $table.ordre, builder: (column) => column);

  GeneratedColumn<bool> get deuterocanonique => $composableBuilder(
    column: $table.deuterocanonique,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nbChapitres => $composableBuilder(
    column: $table.nbChapitres,
    builder: (column) => column,
  );
}

class $$LivresTableTableManager
    extends
        RootTableManager<
          _$BibleCorpusDatabase,
          $LivresTable,
          LivreCorpusRow,
          $$LivresTableFilterComposer,
          $$LivresTableOrderingComposer,
          $$LivresTableAnnotationComposer,
          $$LivresTableCreateCompanionBuilder,
          $$LivresTableUpdateCompanionBuilder,
          (
            LivreCorpusRow,
            BaseReferences<_$BibleCorpusDatabase, $LivresTable, LivreCorpusRow>,
          ),
          LivreCorpusRow,
          PrefetchHooks Function()
        > {
  $$LivresTableTableManager(_$BibleCorpusDatabase db, $LivresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LivresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LivresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LivresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> bookId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> abreviation = const Value.absent(),
                Value<int> ordre = const Value.absent(),
                Value<bool> deuterocanonique = const Value.absent(),
                Value<int> nbChapitres = const Value.absent(),
              }) => LivresCompanion(
                bookId: bookId,
                nom: nom,
                abreviation: abreviation,
                ordre: ordre,
                deuterocanonique: deuterocanonique,
                nbChapitres: nbChapitres,
              ),
          createCompanionCallback:
              ({
                Value<int> bookId = const Value.absent(),
                required String nom,
                required String abreviation,
                required int ordre,
                required bool deuterocanonique,
                required int nbChapitres,
              }) => LivresCompanion.insert(
                bookId: bookId,
                nom: nom,
                abreviation: abreviation,
                ordre: ordre,
                deuterocanonique: deuterocanonique,
                nbChapitres: nbChapitres,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LivresTable, LivreCorpusRow>(table),
                  BaseReferences<
                    _$BibleCorpusDatabase,
                    $LivresTable,
                    LivreCorpusRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LivresTableProcessedTableManager =
    ProcessedTableManager<
      _$BibleCorpusDatabase,
      $LivresTable,
      LivreCorpusRow,
      $$LivresTableFilterComposer,
      $$LivresTableOrderingComposer,
      $$LivresTableAnnotationComposer,
      $$LivresTableCreateCompanionBuilder,
      $$LivresTableUpdateCompanionBuilder,
      (
        LivreCorpusRow,
        BaseReferences<_$BibleCorpusDatabase, $LivresTable, LivreCorpusRow>,
      ),
      LivreCorpusRow,
      PrefetchHooks Function()
    >;
typedef $$VersetsTableCreateCompanionBuilder =
    VersetsCompanion Function({
      Value<int> id,
      required int bookId,
      required int chapitre,
      required int verset,
      required String texte,
    });
typedef $$VersetsTableUpdateCompanionBuilder =
    VersetsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<int> chapitre,
      Value<int> verset,
      Value<String> texte,
    });

class $$VersetsTableFilterComposer
    extends Composer<_$BibleCorpusDatabase, $VersetsTable> {
  $$VersetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapitre => $composableBuilder(
    column: $table.chapitre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get verset => $composableBuilder(
    column: $table.verset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get texte => $composableBuilder(
    column: $table.texte,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VersetsTableOrderingComposer
    extends Composer<_$BibleCorpusDatabase, $VersetsTable> {
  $$VersetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapitre => $composableBuilder(
    column: $table.chapitre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get verset => $composableBuilder(
    column: $table.verset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get texte => $composableBuilder(
    column: $table.texte,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VersetsTableAnnotationComposer
    extends Composer<_$BibleCorpusDatabase, $VersetsTable> {
  $$VersetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapitre =>
      $composableBuilder(column: $table.chapitre, builder: (column) => column);

  GeneratedColumn<int> get verset =>
      $composableBuilder(column: $table.verset, builder: (column) => column);

  GeneratedColumn<String> get texte =>
      $composableBuilder(column: $table.texte, builder: (column) => column);
}

class $$VersetsTableTableManager
    extends
        RootTableManager<
          _$BibleCorpusDatabase,
          $VersetsTable,
          VersetCorpusRow,
          $$VersetsTableFilterComposer,
          $$VersetsTableOrderingComposer,
          $$VersetsTableAnnotationComposer,
          $$VersetsTableCreateCompanionBuilder,
          $$VersetsTableUpdateCompanionBuilder,
          (
            VersetCorpusRow,
            BaseReferences<
              _$BibleCorpusDatabase,
              $VersetsTable,
              VersetCorpusRow
            >,
          ),
          VersetCorpusRow,
          PrefetchHooks Function()
        > {
  $$VersetsTableTableManager(_$BibleCorpusDatabase db, $VersetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<int> chapitre = const Value.absent(),
                Value<int> verset = const Value.absent(),
                Value<String> texte = const Value.absent(),
              }) => VersetsCompanion(
                id: id,
                bookId: bookId,
                chapitre: chapitre,
                verset: verset,
                texte: texte,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required int chapitre,
                required int verset,
                required String texte,
              }) => VersetsCompanion.insert(
                id: id,
                bookId: bookId,
                chapitre: chapitre,
                verset: verset,
                texte: texte,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VersetsTable, VersetCorpusRow>(table),
                  BaseReferences<
                    _$BibleCorpusDatabase,
                    $VersetsTable,
                    VersetCorpusRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VersetsTableProcessedTableManager =
    ProcessedTableManager<
      _$BibleCorpusDatabase,
      $VersetsTable,
      VersetCorpusRow,
      $$VersetsTableFilterComposer,
      $$VersetsTableOrderingComposer,
      $$VersetsTableAnnotationComposer,
      $$VersetsTableCreateCompanionBuilder,
      $$VersetsTableUpdateCompanionBuilder,
      (
        VersetCorpusRow,
        BaseReferences<_$BibleCorpusDatabase, $VersetsTable, VersetCorpusRow>,
      ),
      VersetCorpusRow,
      PrefetchHooks Function()
    >;

class $BibleCorpusDatabaseManager {
  final _$BibleCorpusDatabase _db;
  $BibleCorpusDatabaseManager(this._db);
  $$LivresTableTableManager get livres =>
      $$LivresTableTableManager(_db, _db.livres);
  $$VersetsTableTableManager get versets =>
      $$VersetsTableTableManager(_db, _db.versets);
}
