// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OrganisationNodesTable extends OrganisationNodes
    with TableInfo<$OrganisationNodesTable, OrganisationNodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganisationNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeNoeudMeta = const VerificationMeta(
    'typeNoeud',
  );
  @override
  late final GeneratedColumn<String> typeNoeud = GeneratedColumn<String>(
    'type_noeud',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noeudParentIdMeta = const VerificationMeta(
    'noeudParentId',
  );
  @override
  late final GeneratedColumn<String> noeudParentId = GeneratedColumn<String>(
    'noeud_parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
  static const VerificationMeta _codeInterneMeta = const VerificationMeta(
    'codeInterne',
  );
  @override
  late final GeneratedColumn<String> codeInterne = GeneratedColumn<String>(
    'code_interne',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('provisoire'),
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachetUrlMeta = const VerificationMeta(
    'cachetUrl',
  );
  @override
  late final GeneratedColumn<String> cachetUrl = GeneratedColumn<String>(
    'cachet_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateFondationMeta = const VerificationMeta(
    'dateFondation',
  );
  @override
  late final GeneratedColumn<DateTime> dateFondation =
      GeneratedColumn<DateTime>(
        'date_fondation',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _categorieConfessionnelleMeta =
      const VerificationMeta('categorieConfessionnelle');
  @override
  late final GeneratedColumn<String> categorieConfessionnelle =
      GeneratedColumn<String>(
        'categorie_confessionnelle',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _zoneGeoIdMeta = const VerificationMeta(
    'zoneGeoId',
  );
  @override
  late final GeneratedColumn<String> zoneGeoId = GeneratedColumn<String>(
    'zone_geo_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    typeNoeud,
    noeudParentId,
    nom,
    codeInterne,
    statut,
    logoUrl,
    cachetUrl,
    dateFondation,
    categorieConfessionnelle,
    zoneGeoId,
    path,
    depth,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organisation_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrganisationNodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type_noeud')) {
      context.handle(
        _typeNoeudMeta,
        typeNoeud.isAcceptableOrUnknown(data['type_noeud']!, _typeNoeudMeta),
      );
    } else if (isInserting) {
      context.missing(_typeNoeudMeta);
    }
    if (data.containsKey('noeud_parent_id')) {
      context.handle(
        _noeudParentIdMeta,
        noeudParentId.isAcceptableOrUnknown(
          data['noeud_parent_id']!,
          _noeudParentIdMeta,
        ),
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
    if (data.containsKey('code_interne')) {
      context.handle(
        _codeInterneMeta,
        codeInterne.isAcceptableOrUnknown(
          data['code_interne']!,
          _codeInterneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_codeInterneMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('cachet_url')) {
      context.handle(
        _cachetUrlMeta,
        cachetUrl.isAcceptableOrUnknown(data['cachet_url']!, _cachetUrlMeta),
      );
    }
    if (data.containsKey('date_fondation')) {
      context.handle(
        _dateFondationMeta,
        dateFondation.isAcceptableOrUnknown(
          data['date_fondation']!,
          _dateFondationMeta,
        ),
      );
    }
    if (data.containsKey('categorie_confessionnelle')) {
      context.handle(
        _categorieConfessionnelleMeta,
        categorieConfessionnelle.isAcceptableOrUnknown(
          data['categorie_confessionnelle']!,
          _categorieConfessionnelleMeta,
        ),
      );
    }
    if (data.containsKey('zone_geo_id')) {
      context.handle(
        _zoneGeoIdMeta,
        zoneGeoId.isAcceptableOrUnknown(data['zone_geo_id']!, _zoneGeoIdMeta),
      );
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrganisationNodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrganisationNodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      typeNoeud: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_noeud'],
      )!,
      noeudParentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}noeud_parent_id'],
      ),
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      codeInterne: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code_interne'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      cachetUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cachet_url'],
      ),
      dateFondation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fondation'],
      ),
      categorieConfessionnelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorie_confessionnelle'],
      ),
      zoneGeoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zone_geo_id'],
      ),
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OrganisationNodesTable createAlias(String alias) {
    return $OrganisationNodesTable(attachedDatabase, alias);
  }
}

class OrganisationNodeRow extends DataClass
    implements Insertable<OrganisationNodeRow> {
  final String id;
  final String typeNoeud;
  final String? noeudParentId;
  final String nom;
  final String codeInterne;
  final String statut;
  final String? logoUrl;
  final String? cachetUrl;
  final DateTime? dateFondation;
  final String? categorieConfessionnelle;
  final String? zoneGeoId;
  final String path;
  final int depth;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OrganisationNodeRow({
    required this.id,
    required this.typeNoeud,
    this.noeudParentId,
    required this.nom,
    required this.codeInterne,
    required this.statut,
    this.logoUrl,
    this.cachetUrl,
    this.dateFondation,
    this.categorieConfessionnelle,
    this.zoneGeoId,
    required this.path,
    required this.depth,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type_noeud'] = Variable<String>(typeNoeud);
    if (!nullToAbsent || noeudParentId != null) {
      map['noeud_parent_id'] = Variable<String>(noeudParentId);
    }
    map['nom'] = Variable<String>(nom);
    map['code_interne'] = Variable<String>(codeInterne);
    map['statut'] = Variable<String>(statut);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || cachetUrl != null) {
      map['cachet_url'] = Variable<String>(cachetUrl);
    }
    if (!nullToAbsent || dateFondation != null) {
      map['date_fondation'] = Variable<DateTime>(dateFondation);
    }
    if (!nullToAbsent || categorieConfessionnelle != null) {
      map['categorie_confessionnelle'] = Variable<String>(
        categorieConfessionnelle,
      );
    }
    if (!nullToAbsent || zoneGeoId != null) {
      map['zone_geo_id'] = Variable<String>(zoneGeoId);
    }
    map['path'] = Variable<String>(path);
    map['depth'] = Variable<int>(depth);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrganisationNodesCompanion toCompanion(bool nullToAbsent) {
    return OrganisationNodesCompanion(
      id: Value(id),
      typeNoeud: Value(typeNoeud),
      noeudParentId: noeudParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(noeudParentId),
      nom: Value(nom),
      codeInterne: Value(codeInterne),
      statut: Value(statut),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      cachetUrl: cachetUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(cachetUrl),
      dateFondation: dateFondation == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFondation),
      categorieConfessionnelle: categorieConfessionnelle == null && nullToAbsent
          ? const Value.absent()
          : Value(categorieConfessionnelle),
      zoneGeoId: zoneGeoId == null && nullToAbsent
          ? const Value.absent()
          : Value(zoneGeoId),
      path: Value(path),
      depth: Value(depth),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OrganisationNodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrganisationNodeRow(
      id: serializer.fromJson<String>(json['id']),
      typeNoeud: serializer.fromJson<String>(json['typeNoeud']),
      noeudParentId: serializer.fromJson<String?>(json['noeudParentId']),
      nom: serializer.fromJson<String>(json['nom']),
      codeInterne: serializer.fromJson<String>(json['codeInterne']),
      statut: serializer.fromJson<String>(json['statut']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      cachetUrl: serializer.fromJson<String?>(json['cachetUrl']),
      dateFondation: serializer.fromJson<DateTime?>(json['dateFondation']),
      categorieConfessionnelle: serializer.fromJson<String?>(
        json['categorieConfessionnelle'],
      ),
      zoneGeoId: serializer.fromJson<String?>(json['zoneGeoId']),
      path: serializer.fromJson<String>(json['path']),
      depth: serializer.fromJson<int>(json['depth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'typeNoeud': serializer.toJson<String>(typeNoeud),
      'noeudParentId': serializer.toJson<String?>(noeudParentId),
      'nom': serializer.toJson<String>(nom),
      'codeInterne': serializer.toJson<String>(codeInterne),
      'statut': serializer.toJson<String>(statut),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'cachetUrl': serializer.toJson<String?>(cachetUrl),
      'dateFondation': serializer.toJson<DateTime?>(dateFondation),
      'categorieConfessionnelle': serializer.toJson<String?>(
        categorieConfessionnelle,
      ),
      'zoneGeoId': serializer.toJson<String?>(zoneGeoId),
      'path': serializer.toJson<String>(path),
      'depth': serializer.toJson<int>(depth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OrganisationNodeRow copyWith({
    String? id,
    String? typeNoeud,
    Value<String?> noeudParentId = const Value.absent(),
    String? nom,
    String? codeInterne,
    String? statut,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> cachetUrl = const Value.absent(),
    Value<DateTime?> dateFondation = const Value.absent(),
    Value<String?> categorieConfessionnelle = const Value.absent(),
    Value<String?> zoneGeoId = const Value.absent(),
    String? path,
    int? depth,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OrganisationNodeRow(
    id: id ?? this.id,
    typeNoeud: typeNoeud ?? this.typeNoeud,
    noeudParentId: noeudParentId.present
        ? noeudParentId.value
        : this.noeudParentId,
    nom: nom ?? this.nom,
    codeInterne: codeInterne ?? this.codeInterne,
    statut: statut ?? this.statut,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    cachetUrl: cachetUrl.present ? cachetUrl.value : this.cachetUrl,
    dateFondation: dateFondation.present
        ? dateFondation.value
        : this.dateFondation,
    categorieConfessionnelle: categorieConfessionnelle.present
        ? categorieConfessionnelle.value
        : this.categorieConfessionnelle,
    zoneGeoId: zoneGeoId.present ? zoneGeoId.value : this.zoneGeoId,
    path: path ?? this.path,
    depth: depth ?? this.depth,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OrganisationNodeRow copyWithCompanion(OrganisationNodesCompanion data) {
    return OrganisationNodeRow(
      id: data.id.present ? data.id.value : this.id,
      typeNoeud: data.typeNoeud.present ? data.typeNoeud.value : this.typeNoeud,
      noeudParentId: data.noeudParentId.present
          ? data.noeudParentId.value
          : this.noeudParentId,
      nom: data.nom.present ? data.nom.value : this.nom,
      codeInterne: data.codeInterne.present
          ? data.codeInterne.value
          : this.codeInterne,
      statut: data.statut.present ? data.statut.value : this.statut,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      cachetUrl: data.cachetUrl.present ? data.cachetUrl.value : this.cachetUrl,
      dateFondation: data.dateFondation.present
          ? data.dateFondation.value
          : this.dateFondation,
      categorieConfessionnelle: data.categorieConfessionnelle.present
          ? data.categorieConfessionnelle.value
          : this.categorieConfessionnelle,
      zoneGeoId: data.zoneGeoId.present ? data.zoneGeoId.value : this.zoneGeoId,
      path: data.path.present ? data.path.value : this.path,
      depth: data.depth.present ? data.depth.value : this.depth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrganisationNodeRow(')
          ..write('id: $id, ')
          ..write('typeNoeud: $typeNoeud, ')
          ..write('noeudParentId: $noeudParentId, ')
          ..write('nom: $nom, ')
          ..write('codeInterne: $codeInterne, ')
          ..write('statut: $statut, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('cachetUrl: $cachetUrl, ')
          ..write('dateFondation: $dateFondation, ')
          ..write('categorieConfessionnelle: $categorieConfessionnelle, ')
          ..write('zoneGeoId: $zoneGeoId, ')
          ..write('path: $path, ')
          ..write('depth: $depth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    typeNoeud,
    noeudParentId,
    nom,
    codeInterne,
    statut,
    logoUrl,
    cachetUrl,
    dateFondation,
    categorieConfessionnelle,
    zoneGeoId,
    path,
    depth,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganisationNodeRow &&
          other.id == this.id &&
          other.typeNoeud == this.typeNoeud &&
          other.noeudParentId == this.noeudParentId &&
          other.nom == this.nom &&
          other.codeInterne == this.codeInterne &&
          other.statut == this.statut &&
          other.logoUrl == this.logoUrl &&
          other.cachetUrl == this.cachetUrl &&
          other.dateFondation == this.dateFondation &&
          other.categorieConfessionnelle == this.categorieConfessionnelle &&
          other.zoneGeoId == this.zoneGeoId &&
          other.path == this.path &&
          other.depth == this.depth &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrganisationNodesCompanion extends UpdateCompanion<OrganisationNodeRow> {
  final Value<String> id;
  final Value<String> typeNoeud;
  final Value<String?> noeudParentId;
  final Value<String> nom;
  final Value<String> codeInterne;
  final Value<String> statut;
  final Value<String?> logoUrl;
  final Value<String?> cachetUrl;
  final Value<DateTime?> dateFondation;
  final Value<String?> categorieConfessionnelle;
  final Value<String?> zoneGeoId;
  final Value<String> path;
  final Value<int> depth;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OrganisationNodesCompanion({
    this.id = const Value.absent(),
    this.typeNoeud = const Value.absent(),
    this.noeudParentId = const Value.absent(),
    this.nom = const Value.absent(),
    this.codeInterne = const Value.absent(),
    this.statut = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.cachetUrl = const Value.absent(),
    this.dateFondation = const Value.absent(),
    this.categorieConfessionnelle = const Value.absent(),
    this.zoneGeoId = const Value.absent(),
    this.path = const Value.absent(),
    this.depth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganisationNodesCompanion.insert({
    required String id,
    required String typeNoeud,
    this.noeudParentId = const Value.absent(),
    required String nom,
    required String codeInterne,
    this.statut = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.cachetUrl = const Value.absent(),
    this.dateFondation = const Value.absent(),
    this.categorieConfessionnelle = const Value.absent(),
    this.zoneGeoId = const Value.absent(),
    required String path,
    required int depth,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       typeNoeud = Value(typeNoeud),
       nom = Value(nom),
       codeInterne = Value(codeInterne),
       path = Value(path),
       depth = Value(depth),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<OrganisationNodeRow> custom({
    Expression<String>? id,
    Expression<String>? typeNoeud,
    Expression<String>? noeudParentId,
    Expression<String>? nom,
    Expression<String>? codeInterne,
    Expression<String>? statut,
    Expression<String>? logoUrl,
    Expression<String>? cachetUrl,
    Expression<DateTime>? dateFondation,
    Expression<String>? categorieConfessionnelle,
    Expression<String>? zoneGeoId,
    Expression<String>? path,
    Expression<int>? depth,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (typeNoeud != null) 'type_noeud': typeNoeud,
      if (noeudParentId != null) 'noeud_parent_id': noeudParentId,
      if (nom != null) 'nom': nom,
      if (codeInterne != null) 'code_interne': codeInterne,
      if (statut != null) 'statut': statut,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (cachetUrl != null) 'cachet_url': cachetUrl,
      if (dateFondation != null) 'date_fondation': dateFondation,
      if (categorieConfessionnelle != null)
        'categorie_confessionnelle': categorieConfessionnelle,
      if (zoneGeoId != null) 'zone_geo_id': zoneGeoId,
      if (path != null) 'path': path,
      if (depth != null) 'depth': depth,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganisationNodesCompanion copyWith({
    Value<String>? id,
    Value<String>? typeNoeud,
    Value<String?>? noeudParentId,
    Value<String>? nom,
    Value<String>? codeInterne,
    Value<String>? statut,
    Value<String?>? logoUrl,
    Value<String?>? cachetUrl,
    Value<DateTime?>? dateFondation,
    Value<String?>? categorieConfessionnelle,
    Value<String?>? zoneGeoId,
    Value<String>? path,
    Value<int>? depth,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrganisationNodesCompanion(
      id: id ?? this.id,
      typeNoeud: typeNoeud ?? this.typeNoeud,
      noeudParentId: noeudParentId ?? this.noeudParentId,
      nom: nom ?? this.nom,
      codeInterne: codeInterne ?? this.codeInterne,
      statut: statut ?? this.statut,
      logoUrl: logoUrl ?? this.logoUrl,
      cachetUrl: cachetUrl ?? this.cachetUrl,
      dateFondation: dateFondation ?? this.dateFondation,
      categorieConfessionnelle:
          categorieConfessionnelle ?? this.categorieConfessionnelle,
      zoneGeoId: zoneGeoId ?? this.zoneGeoId,
      path: path ?? this.path,
      depth: depth ?? this.depth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (typeNoeud.present) {
      map['type_noeud'] = Variable<String>(typeNoeud.value);
    }
    if (noeudParentId.present) {
      map['noeud_parent_id'] = Variable<String>(noeudParentId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (codeInterne.present) {
      map['code_interne'] = Variable<String>(codeInterne.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (cachetUrl.present) {
      map['cachet_url'] = Variable<String>(cachetUrl.value);
    }
    if (dateFondation.present) {
      map['date_fondation'] = Variable<DateTime>(dateFondation.value);
    }
    if (categorieConfessionnelle.present) {
      map['categorie_confessionnelle'] = Variable<String>(
        categorieConfessionnelle.value,
      );
    }
    if (zoneGeoId.present) {
      map['zone_geo_id'] = Variable<String>(zoneGeoId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganisationNodesCompanion(')
          ..write('id: $id, ')
          ..write('typeNoeud: $typeNoeud, ')
          ..write('noeudParentId: $noeudParentId, ')
          ..write('nom: $nom, ')
          ..write('codeInterne: $codeInterne, ')
          ..write('statut: $statut, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('cachetUrl: $cachetUrl, ')
          ..write('dateFondation: $dateFondation, ')
          ..write('categorieConfessionnelle: $categorieConfessionnelle, ')
          ..write('zoneGeoId: $zoneGeoId, ')
          ..write('path: $path, ')
          ..write('depth: $depth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistoriqueRattachementsTable extends HistoriqueRattachements
    with TableInfo<$HistoriqueRattachementsTable, HistoriqueRattachementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriqueRattachementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noeudIdMeta = const VerificationMeta(
    'noeudId',
  );
  @override
  late final GeneratedColumn<String> noeudId = GeneratedColumn<String>(
    'noeud_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ancienParentIdMeta = const VerificationMeta(
    'ancienParentId',
  );
  @override
  late final GeneratedColumn<String> ancienParentId = GeneratedColumn<String>(
    'ancien_parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nouveauParentIdMeta = const VerificationMeta(
    'nouveauParentId',
  );
  @override
  late final GeneratedColumn<String> nouveauParentId = GeneratedColumn<String>(
    'nouveau_parent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateEffetMeta = const VerificationMeta(
    'dateEffet',
  );
  @override
  late final GeneratedColumn<DateTime> dateEffet = GeneratedColumn<DateTime>(
    'date_effet',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motifMeta = const VerificationMeta('motif');
  @override
  late final GeneratedColumn<String> motif = GeneratedColumn<String>(
    'motif',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    noeudId,
    ancienParentId,
    nouveauParentId,
    dateEffet,
    motif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historique_rattachements';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoriqueRattachementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('noeud_id')) {
      context.handle(
        _noeudIdMeta,
        noeudId.isAcceptableOrUnknown(data['noeud_id']!, _noeudIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noeudIdMeta);
    }
    if (data.containsKey('ancien_parent_id')) {
      context.handle(
        _ancienParentIdMeta,
        ancienParentId.isAcceptableOrUnknown(
          data['ancien_parent_id']!,
          _ancienParentIdMeta,
        ),
      );
    }
    if (data.containsKey('nouveau_parent_id')) {
      context.handle(
        _nouveauParentIdMeta,
        nouveauParentId.isAcceptableOrUnknown(
          data['nouveau_parent_id']!,
          _nouveauParentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nouveauParentIdMeta);
    }
    if (data.containsKey('date_effet')) {
      context.handle(
        _dateEffetMeta,
        dateEffet.isAcceptableOrUnknown(data['date_effet']!, _dateEffetMeta),
      );
    } else if (isInserting) {
      context.missing(_dateEffetMeta);
    }
    if (data.containsKey('motif')) {
      context.handle(
        _motifMeta,
        motif.isAcceptableOrUnknown(data['motif']!, _motifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoriqueRattachementRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoriqueRattachementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      noeudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}noeud_id'],
      )!,
      ancienParentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ancien_parent_id'],
      ),
      nouveauParentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nouveau_parent_id'],
      )!,
      dateEffet: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_effet'],
      )!,
      motif: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motif'],
      ),
    );
  }

  @override
  $HistoriqueRattachementsTable createAlias(String alias) {
    return $HistoriqueRattachementsTable(attachedDatabase, alias);
  }
}

class HistoriqueRattachementRow extends DataClass
    implements Insertable<HistoriqueRattachementRow> {
  final String id;
  final String noeudId;
  final String? ancienParentId;
  final String nouveauParentId;
  final DateTime dateEffet;
  final String? motif;
  const HistoriqueRattachementRow({
    required this.id,
    required this.noeudId,
    this.ancienParentId,
    required this.nouveauParentId,
    required this.dateEffet,
    this.motif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['noeud_id'] = Variable<String>(noeudId);
    if (!nullToAbsent || ancienParentId != null) {
      map['ancien_parent_id'] = Variable<String>(ancienParentId);
    }
    map['nouveau_parent_id'] = Variable<String>(nouveauParentId);
    map['date_effet'] = Variable<DateTime>(dateEffet);
    if (!nullToAbsent || motif != null) {
      map['motif'] = Variable<String>(motif);
    }
    return map;
  }

  HistoriqueRattachementsCompanion toCompanion(bool nullToAbsent) {
    return HistoriqueRattachementsCompanion(
      id: Value(id),
      noeudId: Value(noeudId),
      ancienParentId: ancienParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(ancienParentId),
      nouveauParentId: Value(nouveauParentId),
      dateEffet: Value(dateEffet),
      motif: motif == null && nullToAbsent
          ? const Value.absent()
          : Value(motif),
    );
  }

  factory HistoriqueRattachementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoriqueRattachementRow(
      id: serializer.fromJson<String>(json['id']),
      noeudId: serializer.fromJson<String>(json['noeudId']),
      ancienParentId: serializer.fromJson<String?>(json['ancienParentId']),
      nouveauParentId: serializer.fromJson<String>(json['nouveauParentId']),
      dateEffet: serializer.fromJson<DateTime>(json['dateEffet']),
      motif: serializer.fromJson<String?>(json['motif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'noeudId': serializer.toJson<String>(noeudId),
      'ancienParentId': serializer.toJson<String?>(ancienParentId),
      'nouveauParentId': serializer.toJson<String>(nouveauParentId),
      'dateEffet': serializer.toJson<DateTime>(dateEffet),
      'motif': serializer.toJson<String?>(motif),
    };
  }

  HistoriqueRattachementRow copyWith({
    String? id,
    String? noeudId,
    Value<String?> ancienParentId = const Value.absent(),
    String? nouveauParentId,
    DateTime? dateEffet,
    Value<String?> motif = const Value.absent(),
  }) => HistoriqueRattachementRow(
    id: id ?? this.id,
    noeudId: noeudId ?? this.noeudId,
    ancienParentId: ancienParentId.present
        ? ancienParentId.value
        : this.ancienParentId,
    nouveauParentId: nouveauParentId ?? this.nouveauParentId,
    dateEffet: dateEffet ?? this.dateEffet,
    motif: motif.present ? motif.value : this.motif,
  );
  HistoriqueRattachementRow copyWithCompanion(
    HistoriqueRattachementsCompanion data,
  ) {
    return HistoriqueRattachementRow(
      id: data.id.present ? data.id.value : this.id,
      noeudId: data.noeudId.present ? data.noeudId.value : this.noeudId,
      ancienParentId: data.ancienParentId.present
          ? data.ancienParentId.value
          : this.ancienParentId,
      nouveauParentId: data.nouveauParentId.present
          ? data.nouveauParentId.value
          : this.nouveauParentId,
      dateEffet: data.dateEffet.present ? data.dateEffet.value : this.dateEffet,
      motif: data.motif.present ? data.motif.value : this.motif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoriqueRattachementRow(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('ancienParentId: $ancienParentId, ')
          ..write('nouveauParentId: $nouveauParentId, ')
          ..write('dateEffet: $dateEffet, ')
          ..write('motif: $motif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    noeudId,
    ancienParentId,
    nouveauParentId,
    dateEffet,
    motif,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoriqueRattachementRow &&
          other.id == this.id &&
          other.noeudId == this.noeudId &&
          other.ancienParentId == this.ancienParentId &&
          other.nouveauParentId == this.nouveauParentId &&
          other.dateEffet == this.dateEffet &&
          other.motif == this.motif);
}

class HistoriqueRattachementsCompanion
    extends UpdateCompanion<HistoriqueRattachementRow> {
  final Value<String> id;
  final Value<String> noeudId;
  final Value<String?> ancienParentId;
  final Value<String> nouveauParentId;
  final Value<DateTime> dateEffet;
  final Value<String?> motif;
  final Value<int> rowid;
  const HistoriqueRattachementsCompanion({
    this.id = const Value.absent(),
    this.noeudId = const Value.absent(),
    this.ancienParentId = const Value.absent(),
    this.nouveauParentId = const Value.absent(),
    this.dateEffet = const Value.absent(),
    this.motif = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistoriqueRattachementsCompanion.insert({
    required String id,
    required String noeudId,
    this.ancienParentId = const Value.absent(),
    required String nouveauParentId,
    required DateTime dateEffet,
    this.motif = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       noeudId = Value(noeudId),
       nouveauParentId = Value(nouveauParentId),
       dateEffet = Value(dateEffet);
  static Insertable<HistoriqueRattachementRow> custom({
    Expression<String>? id,
    Expression<String>? noeudId,
    Expression<String>? ancienParentId,
    Expression<String>? nouveauParentId,
    Expression<DateTime>? dateEffet,
    Expression<String>? motif,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noeudId != null) 'noeud_id': noeudId,
      if (ancienParentId != null) 'ancien_parent_id': ancienParentId,
      if (nouveauParentId != null) 'nouveau_parent_id': nouveauParentId,
      if (dateEffet != null) 'date_effet': dateEffet,
      if (motif != null) 'motif': motif,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistoriqueRattachementsCompanion copyWith({
    Value<String>? id,
    Value<String>? noeudId,
    Value<String?>? ancienParentId,
    Value<String>? nouveauParentId,
    Value<DateTime>? dateEffet,
    Value<String?>? motif,
    Value<int>? rowid,
  }) {
    return HistoriqueRattachementsCompanion(
      id: id ?? this.id,
      noeudId: noeudId ?? this.noeudId,
      ancienParentId: ancienParentId ?? this.ancienParentId,
      nouveauParentId: nouveauParentId ?? this.nouveauParentId,
      dateEffet: dateEffet ?? this.dateEffet,
      motif: motif ?? this.motif,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (noeudId.present) {
      map['noeud_id'] = Variable<String>(noeudId.value);
    }
    if (ancienParentId.present) {
      map['ancien_parent_id'] = Variable<String>(ancienParentId.value);
    }
    if (nouveauParentId.present) {
      map['nouveau_parent_id'] = Variable<String>(nouveauParentId.value);
    }
    if (dateEffet.present) {
      map['date_effet'] = Variable<DateTime>(dateEffet.value);
    }
    if (motif.present) {
      map['motif'] = Variable<String>(motif.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriqueRattachementsCompanion(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('ancienParentId: $ancienParentId, ')
          ..write('nouveauParentId: $nouveauParentId, ')
          ..write('dateEffet: $dateEffet, ')
          ..write('motif: $motif, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entiteMeta = const VerificationMeta('entite');
  @override
  late final GeneratedColumn<String> entite = GeneratedColumn<String>(
    'entite',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entiteIdMeta = const VerificationMeta(
    'entiteId',
  );
  @override
  late final GeneratedColumn<String> entiteId = GeneratedColumn<String>(
    'entite_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creeLeMeta = const VerificationMeta('creeLe');
  @override
  late final GeneratedColumn<DateTime> creeLe = GeneratedColumn<DateTime>(
    'cree_le',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tentativesMeta = const VerificationMeta(
    'tentatives',
  );
  @override
  late final GeneratedColumn<int> tentatives = GeneratedColumn<int>(
    'tentatives',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _derniereTentativeLeMeta =
      const VerificationMeta('derniereTentativeLe');
  @override
  late final GeneratedColumn<DateTime> derniereTentativeLe =
      GeneratedColumn<DateTime>(
        'derniere_tentative_le',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _derniereErreurMeta = const VerificationMeta(
    'derniereErreur',
  );
  @override
  late final GeneratedColumn<String> derniereErreur = GeneratedColumn<String>(
    'derniere_erreur',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entite,
    entiteId,
    operation,
    creeLe,
    tentatives,
    derniereTentativeLe,
    derniereErreur,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entite')) {
      context.handle(
        _entiteMeta,
        entite.isAcceptableOrUnknown(data['entite']!, _entiteMeta),
      );
    } else if (isInserting) {
      context.missing(_entiteMeta);
    }
    if (data.containsKey('entite_id')) {
      context.handle(
        _entiteIdMeta,
        entiteId.isAcceptableOrUnknown(data['entite_id']!, _entiteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entiteIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('cree_le')) {
      context.handle(
        _creeLeMeta,
        creeLe.isAcceptableOrUnknown(data['cree_le']!, _creeLeMeta),
      );
    } else if (isInserting) {
      context.missing(_creeLeMeta);
    }
    if (data.containsKey('tentatives')) {
      context.handle(
        _tentativesMeta,
        tentatives.isAcceptableOrUnknown(data['tentatives']!, _tentativesMeta),
      );
    }
    if (data.containsKey('derniere_tentative_le')) {
      context.handle(
        _derniereTentativeLeMeta,
        derniereTentativeLe.isAcceptableOrUnknown(
          data['derniere_tentative_le']!,
          _derniereTentativeLeMeta,
        ),
      );
    }
    if (data.containsKey('derniere_erreur')) {
      context.handle(
        _derniereErreurMeta,
        derniereErreur.isAcceptableOrUnknown(
          data['derniere_erreur']!,
          _derniereErreurMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entite'],
      )!,
      entiteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entite_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      creeLe: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cree_le'],
      )!,
      tentatives: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tentatives'],
      )!,
      derniereTentativeLe: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}derniere_tentative_le'],
      ),
      derniereErreur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}derniere_erreur'],
      ),
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxRow extends DataClass implements Insertable<SyncOutboxRow> {
  final String id;
  final String entite;
  final String entiteId;
  final String operation;
  final DateTime creeLe;
  final int tentatives;
  final DateTime? derniereTentativeLe;
  final String? derniereErreur;
  const SyncOutboxRow({
    required this.id,
    required this.entite,
    required this.entiteId,
    required this.operation,
    required this.creeLe,
    required this.tentatives,
    this.derniereTentativeLe,
    this.derniereErreur,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entite'] = Variable<String>(entite);
    map['entite_id'] = Variable<String>(entiteId);
    map['operation'] = Variable<String>(operation);
    map['cree_le'] = Variable<DateTime>(creeLe);
    map['tentatives'] = Variable<int>(tentatives);
    if (!nullToAbsent || derniereTentativeLe != null) {
      map['derniere_tentative_le'] = Variable<DateTime>(derniereTentativeLe);
    }
    if (!nullToAbsent || derniereErreur != null) {
      map['derniere_erreur'] = Variable<String>(derniereErreur);
    }
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      id: Value(id),
      entite: Value(entite),
      entiteId: Value(entiteId),
      operation: Value(operation),
      creeLe: Value(creeLe),
      tentatives: Value(tentatives),
      derniereTentativeLe: derniereTentativeLe == null && nullToAbsent
          ? const Value.absent()
          : Value(derniereTentativeLe),
      derniereErreur: derniereErreur == null && nullToAbsent
          ? const Value.absent()
          : Value(derniereErreur),
    );
  }

  factory SyncOutboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxRow(
      id: serializer.fromJson<String>(json['id']),
      entite: serializer.fromJson<String>(json['entite']),
      entiteId: serializer.fromJson<String>(json['entiteId']),
      operation: serializer.fromJson<String>(json['operation']),
      creeLe: serializer.fromJson<DateTime>(json['creeLe']),
      tentatives: serializer.fromJson<int>(json['tentatives']),
      derniereTentativeLe: serializer.fromJson<DateTime?>(
        json['derniereTentativeLe'],
      ),
      derniereErreur: serializer.fromJson<String?>(json['derniereErreur']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entite': serializer.toJson<String>(entite),
      'entiteId': serializer.toJson<String>(entiteId),
      'operation': serializer.toJson<String>(operation),
      'creeLe': serializer.toJson<DateTime>(creeLe),
      'tentatives': serializer.toJson<int>(tentatives),
      'derniereTentativeLe': serializer.toJson<DateTime?>(derniereTentativeLe),
      'derniereErreur': serializer.toJson<String?>(derniereErreur),
    };
  }

  SyncOutboxRow copyWith({
    String? id,
    String? entite,
    String? entiteId,
    String? operation,
    DateTime? creeLe,
    int? tentatives,
    Value<DateTime?> derniereTentativeLe = const Value.absent(),
    Value<String?> derniereErreur = const Value.absent(),
  }) => SyncOutboxRow(
    id: id ?? this.id,
    entite: entite ?? this.entite,
    entiteId: entiteId ?? this.entiteId,
    operation: operation ?? this.operation,
    creeLe: creeLe ?? this.creeLe,
    tentatives: tentatives ?? this.tentatives,
    derniereTentativeLe: derniereTentativeLe.present
        ? derniereTentativeLe.value
        : this.derniereTentativeLe,
    derniereErreur: derniereErreur.present
        ? derniereErreur.value
        : this.derniereErreur,
  );
  SyncOutboxRow copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxRow(
      id: data.id.present ? data.id.value : this.id,
      entite: data.entite.present ? data.entite.value : this.entite,
      entiteId: data.entiteId.present ? data.entiteId.value : this.entiteId,
      operation: data.operation.present ? data.operation.value : this.operation,
      creeLe: data.creeLe.present ? data.creeLe.value : this.creeLe,
      tentatives: data.tentatives.present
          ? data.tentatives.value
          : this.tentatives,
      derniereTentativeLe: data.derniereTentativeLe.present
          ? data.derniereTentativeLe.value
          : this.derniereTentativeLe,
      derniereErreur: data.derniereErreur.present
          ? data.derniereErreur.value
          : this.derniereErreur,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxRow(')
          ..write('id: $id, ')
          ..write('entite: $entite, ')
          ..write('entiteId: $entiteId, ')
          ..write('operation: $operation, ')
          ..write('creeLe: $creeLe, ')
          ..write('tentatives: $tentatives, ')
          ..write('derniereTentativeLe: $derniereTentativeLe, ')
          ..write('derniereErreur: $derniereErreur')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entite,
    entiteId,
    operation,
    creeLe,
    tentatives,
    derniereTentativeLe,
    derniereErreur,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxRow &&
          other.id == this.id &&
          other.entite == this.entite &&
          other.entiteId == this.entiteId &&
          other.operation == this.operation &&
          other.creeLe == this.creeLe &&
          other.tentatives == this.tentatives &&
          other.derniereTentativeLe == this.derniereTentativeLe &&
          other.derniereErreur == this.derniereErreur);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxRow> {
  final Value<String> id;
  final Value<String> entite;
  final Value<String> entiteId;
  final Value<String> operation;
  final Value<DateTime> creeLe;
  final Value<int> tentatives;
  final Value<DateTime?> derniereTentativeLe;
  final Value<String?> derniereErreur;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.id = const Value.absent(),
    this.entite = const Value.absent(),
    this.entiteId = const Value.absent(),
    this.operation = const Value.absent(),
    this.creeLe = const Value.absent(),
    this.tentatives = const Value.absent(),
    this.derniereTentativeLe = const Value.absent(),
    this.derniereErreur = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String id,
    required String entite,
    required String entiteId,
    required String operation,
    required DateTime creeLe,
    this.tentatives = const Value.absent(),
    this.derniereTentativeLe = const Value.absent(),
    this.derniereErreur = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entite = Value(entite),
       entiteId = Value(entiteId),
       operation = Value(operation),
       creeLe = Value(creeLe);
  static Insertable<SyncOutboxRow> custom({
    Expression<String>? id,
    Expression<String>? entite,
    Expression<String>? entiteId,
    Expression<String>? operation,
    Expression<DateTime>? creeLe,
    Expression<int>? tentatives,
    Expression<DateTime>? derniereTentativeLe,
    Expression<String>? derniereErreur,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entite != null) 'entite': entite,
      if (entiteId != null) 'entite_id': entiteId,
      if (operation != null) 'operation': operation,
      if (creeLe != null) 'cree_le': creeLe,
      if (tentatives != null) 'tentatives': tentatives,
      if (derniereTentativeLe != null)
        'derniere_tentative_le': derniereTentativeLe,
      if (derniereErreur != null) 'derniere_erreur': derniereErreur,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? id,
    Value<String>? entite,
    Value<String>? entiteId,
    Value<String>? operation,
    Value<DateTime>? creeLe,
    Value<int>? tentatives,
    Value<DateTime?>? derniereTentativeLe,
    Value<String?>? derniereErreur,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      id: id ?? this.id,
      entite: entite ?? this.entite,
      entiteId: entiteId ?? this.entiteId,
      operation: operation ?? this.operation,
      creeLe: creeLe ?? this.creeLe,
      tentatives: tentatives ?? this.tentatives,
      derniereTentativeLe: derniereTentativeLe ?? this.derniereTentativeLe,
      derniereErreur: derniereErreur ?? this.derniereErreur,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entite.present) {
      map['entite'] = Variable<String>(entite.value);
    }
    if (entiteId.present) {
      map['entite_id'] = Variable<String>(entiteId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (creeLe.present) {
      map['cree_le'] = Variable<DateTime>(creeLe.value);
    }
    if (tentatives.present) {
      map['tentatives'] = Variable<int>(tentatives.value);
    }
    if (derniereTentativeLe.present) {
      map['derniere_tentative_le'] = Variable<DateTime>(
        derniereTentativeLe.value,
      );
    }
    if (derniereErreur.present) {
      map['derniere_erreur'] = Variable<String>(derniereErreur.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('id: $id, ')
          ..write('entite: $entite, ')
          ..write('entiteId: $entiteId, ')
          ..write('operation: $operation, ')
          ..write('creeLe: $creeLe, ')
          ..write('tentatives: $tentatives, ')
          ..write('derniereTentativeLe: $derniereTentativeLe, ')
          ..write('derniereErreur: $derniereErreur, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrganisationNodesTable organisationNodes =
      $OrganisationNodesTable(this);
  late final $HistoriqueRattachementsTable historiqueRattachements =
      $HistoriqueRattachementsTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    organisationNodes,
    historiqueRattachements,
    syncOutbox,
  ];
}

typedef $$OrganisationNodesTableCreateCompanionBuilder =
    OrganisationNodesCompanion Function({
      required String id,
      required String typeNoeud,
      Value<String?> noeudParentId,
      required String nom,
      required String codeInterne,
      Value<String> statut,
      Value<String?> logoUrl,
      Value<String?> cachetUrl,
      Value<DateTime?> dateFondation,
      Value<String?> categorieConfessionnelle,
      Value<String?> zoneGeoId,
      required String path,
      required int depth,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$OrganisationNodesTableUpdateCompanionBuilder =
    OrganisationNodesCompanion Function({
      Value<String> id,
      Value<String> typeNoeud,
      Value<String?> noeudParentId,
      Value<String> nom,
      Value<String> codeInterne,
      Value<String> statut,
      Value<String?> logoUrl,
      Value<String?> cachetUrl,
      Value<DateTime?> dateFondation,
      Value<String?> categorieConfessionnelle,
      Value<String?> zoneGeoId,
      Value<String> path,
      Value<int> depth,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$OrganisationNodesTableFilterComposer
    extends Composer<_$AppDatabase, $OrganisationNodesTable> {
  $$OrganisationNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeNoeud => $composableBuilder(
    column: $table.typeNoeud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noeudParentId => $composableBuilder(
    column: $table.noeudParentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codeInterne => $composableBuilder(
    column: $table.codeInterne,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cachetUrl => $composableBuilder(
    column: $table.cachetUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFondation => $composableBuilder(
    column: $table.dateFondation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorieConfessionnelle => $composableBuilder(
    column: $table.categorieConfessionnelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zoneGeoId => $composableBuilder(
    column: $table.zoneGeoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrganisationNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganisationNodesTable> {
  $$OrganisationNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeNoeud => $composableBuilder(
    column: $table.typeNoeud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noeudParentId => $composableBuilder(
    column: $table.noeudParentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codeInterne => $composableBuilder(
    column: $table.codeInterne,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cachetUrl => $composableBuilder(
    column: $table.cachetUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFondation => $composableBuilder(
    column: $table.dateFondation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorieConfessionnelle => $composableBuilder(
    column: $table.categorieConfessionnelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zoneGeoId => $composableBuilder(
    column: $table.zoneGeoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganisationNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganisationNodesTable> {
  $$OrganisationNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get typeNoeud =>
      $composableBuilder(column: $table.typeNoeud, builder: (column) => column);

  GeneratedColumn<String> get noeudParentId => $composableBuilder(
    column: $table.noeudParentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get codeInterne => $composableBuilder(
    column: $table.codeInterne,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get cachetUrl =>
      $composableBuilder(column: $table.cachetUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFondation => $composableBuilder(
    column: $table.dateFondation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorieConfessionnelle => $composableBuilder(
    column: $table.categorieConfessionnelle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get zoneGeoId =>
      $composableBuilder(column: $table.zoneGeoId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrganisationNodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganisationNodesTable,
          OrganisationNodeRow,
          $$OrganisationNodesTableFilterComposer,
          $$OrganisationNodesTableOrderingComposer,
          $$OrganisationNodesTableAnnotationComposer,
          $$OrganisationNodesTableCreateCompanionBuilder,
          $$OrganisationNodesTableUpdateCompanionBuilder,
          (
            OrganisationNodeRow,
            BaseReferences<
              _$AppDatabase,
              $OrganisationNodesTable,
              OrganisationNodeRow
            >,
          ),
          OrganisationNodeRow,
          PrefetchHooks Function()
        > {
  $$OrganisationNodesTableTableManager(
    _$AppDatabase db,
    $OrganisationNodesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganisationNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganisationNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrganisationNodesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> typeNoeud = const Value.absent(),
                Value<String?> noeudParentId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> codeInterne = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> cachetUrl = const Value.absent(),
                Value<DateTime?> dateFondation = const Value.absent(),
                Value<String?> categorieConfessionnelle = const Value.absent(),
                Value<String?> zoneGeoId = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganisationNodesCompanion(
                id: id,
                typeNoeud: typeNoeud,
                noeudParentId: noeudParentId,
                nom: nom,
                codeInterne: codeInterne,
                statut: statut,
                logoUrl: logoUrl,
                cachetUrl: cachetUrl,
                dateFondation: dateFondation,
                categorieConfessionnelle: categorieConfessionnelle,
                zoneGeoId: zoneGeoId,
                path: path,
                depth: depth,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String typeNoeud,
                Value<String?> noeudParentId = const Value.absent(),
                required String nom,
                required String codeInterne,
                Value<String> statut = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> cachetUrl = const Value.absent(),
                Value<DateTime?> dateFondation = const Value.absent(),
                Value<String?> categorieConfessionnelle = const Value.absent(),
                Value<String?> zoneGeoId = const Value.absent(),
                required String path,
                required int depth,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => OrganisationNodesCompanion.insert(
                id: id,
                typeNoeud: typeNoeud,
                noeudParentId: noeudParentId,
                nom: nom,
                codeInterne: codeInterne,
                statut: statut,
                logoUrl: logoUrl,
                cachetUrl: cachetUrl,
                dateFondation: dateFondation,
                categorieConfessionnelle: categorieConfessionnelle,
                zoneGeoId: zoneGeoId,
                path: path,
                depth: depth,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrganisationNodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganisationNodesTable,
      OrganisationNodeRow,
      $$OrganisationNodesTableFilterComposer,
      $$OrganisationNodesTableOrderingComposer,
      $$OrganisationNodesTableAnnotationComposer,
      $$OrganisationNodesTableCreateCompanionBuilder,
      $$OrganisationNodesTableUpdateCompanionBuilder,
      (
        OrganisationNodeRow,
        BaseReferences<
          _$AppDatabase,
          $OrganisationNodesTable,
          OrganisationNodeRow
        >,
      ),
      OrganisationNodeRow,
      PrefetchHooks Function()
    >;
typedef $$HistoriqueRattachementsTableCreateCompanionBuilder =
    HistoriqueRattachementsCompanion Function({
      required String id,
      required String noeudId,
      Value<String?> ancienParentId,
      required String nouveauParentId,
      required DateTime dateEffet,
      Value<String?> motif,
      Value<int> rowid,
    });
typedef $$HistoriqueRattachementsTableUpdateCompanionBuilder =
    HistoriqueRattachementsCompanion Function({
      Value<String> id,
      Value<String> noeudId,
      Value<String?> ancienParentId,
      Value<String> nouveauParentId,
      Value<DateTime> dateEffet,
      Value<String?> motif,
      Value<int> rowid,
    });

class $$HistoriqueRattachementsTableFilterComposer
    extends Composer<_$AppDatabase, $HistoriqueRattachementsTable> {
  $$HistoriqueRattachementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noeudId => $composableBuilder(
    column: $table.noeudId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ancienParentId => $composableBuilder(
    column: $table.ancienParentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nouveauParentId => $composableBuilder(
    column: $table.nouveauParentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEffet => $composableBuilder(
    column: $table.dateEffet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motif => $composableBuilder(
    column: $table.motif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistoriqueRattachementsTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoriqueRattachementsTable> {
  $$HistoriqueRattachementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noeudId => $composableBuilder(
    column: $table.noeudId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ancienParentId => $composableBuilder(
    column: $table.ancienParentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nouveauParentId => $composableBuilder(
    column: $table.nouveauParentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEffet => $composableBuilder(
    column: $table.dateEffet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motif => $composableBuilder(
    column: $table.motif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistoriqueRattachementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoriqueRattachementsTable> {
  $$HistoriqueRattachementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get noeudId =>
      $composableBuilder(column: $table.noeudId, builder: (column) => column);

  GeneratedColumn<String> get ancienParentId => $composableBuilder(
    column: $table.ancienParentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nouveauParentId => $composableBuilder(
    column: $table.nouveauParentId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateEffet =>
      $composableBuilder(column: $table.dateEffet, builder: (column) => column);

  GeneratedColumn<String> get motif =>
      $composableBuilder(column: $table.motif, builder: (column) => column);
}

class $$HistoriqueRattachementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoriqueRattachementsTable,
          HistoriqueRattachementRow,
          $$HistoriqueRattachementsTableFilterComposer,
          $$HistoriqueRattachementsTableOrderingComposer,
          $$HistoriqueRattachementsTableAnnotationComposer,
          $$HistoriqueRattachementsTableCreateCompanionBuilder,
          $$HistoriqueRattachementsTableUpdateCompanionBuilder,
          (
            HistoriqueRattachementRow,
            BaseReferences<
              _$AppDatabase,
              $HistoriqueRattachementsTable,
              HistoriqueRattachementRow
            >,
          ),
          HistoriqueRattachementRow,
          PrefetchHooks Function()
        > {
  $$HistoriqueRattachementsTableTableManager(
    _$AppDatabase db,
    $HistoriqueRattachementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoriqueRattachementsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$HistoriqueRattachementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HistoriqueRattachementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> noeudId = const Value.absent(),
                Value<String?> ancienParentId = const Value.absent(),
                Value<String> nouveauParentId = const Value.absent(),
                Value<DateTime> dateEffet = const Value.absent(),
                Value<String?> motif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistoriqueRattachementsCompanion(
                id: id,
                noeudId: noeudId,
                ancienParentId: ancienParentId,
                nouveauParentId: nouveauParentId,
                dateEffet: dateEffet,
                motif: motif,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String noeudId,
                Value<String?> ancienParentId = const Value.absent(),
                required String nouveauParentId,
                required DateTime dateEffet,
                Value<String?> motif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistoriqueRattachementsCompanion.insert(
                id: id,
                noeudId: noeudId,
                ancienParentId: ancienParentId,
                nouveauParentId: nouveauParentId,
                dateEffet: dateEffet,
                motif: motif,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoriqueRattachementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoriqueRattachementsTable,
      HistoriqueRattachementRow,
      $$HistoriqueRattachementsTableFilterComposer,
      $$HistoriqueRattachementsTableOrderingComposer,
      $$HistoriqueRattachementsTableAnnotationComposer,
      $$HistoriqueRattachementsTableCreateCompanionBuilder,
      $$HistoriqueRattachementsTableUpdateCompanionBuilder,
      (
        HistoriqueRattachementRow,
        BaseReferences<
          _$AppDatabase,
          $HistoriqueRattachementsTable,
          HistoriqueRattachementRow
        >,
      ),
      HistoriqueRattachementRow,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      required String id,
      required String entite,
      required String entiteId,
      required String operation,
      required DateTime creeLe,
      Value<int> tentatives,
      Value<DateTime?> derniereTentativeLe,
      Value<String?> derniereErreur,
      Value<int> rowid,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<String> id,
      Value<String> entite,
      Value<String> entiteId,
      Value<String> operation,
      Value<DateTime> creeLe,
      Value<int> tentatives,
      Value<DateTime?> derniereTentativeLe,
      Value<String?> derniereErreur,
      Value<int> rowid,
    });

class $$SyncOutboxTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entite => $composableBuilder(
    column: $table.entite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entiteId => $composableBuilder(
    column: $table.entiteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creeLe => $composableBuilder(
    column: $table.creeLe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tentatives => $composableBuilder(
    column: $table.tentatives,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get derniereTentativeLe => $composableBuilder(
    column: $table.derniereTentativeLe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get derniereErreur => $composableBuilder(
    column: $table.derniereErreur,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entite => $composableBuilder(
    column: $table.entite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entiteId => $composableBuilder(
    column: $table.entiteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creeLe => $composableBuilder(
    column: $table.creeLe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tentatives => $composableBuilder(
    column: $table.tentatives,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get derniereTentativeLe => $composableBuilder(
    column: $table.derniereTentativeLe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get derniereErreur => $composableBuilder(
    column: $table.derniereErreur,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entite =>
      $composableBuilder(column: $table.entite, builder: (column) => column);

  GeneratedColumn<String> get entiteId =>
      $composableBuilder(column: $table.entiteId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<DateTime> get creeLe =>
      $composableBuilder(column: $table.creeLe, builder: (column) => column);

  GeneratedColumn<int> get tentatives => $composableBuilder(
    column: $table.tentatives,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get derniereTentativeLe => $composableBuilder(
    column: $table.derniereTentativeLe,
    builder: (column) => column,
  );

  GeneratedColumn<String> get derniereErreur => $composableBuilder(
    column: $table.derniereErreur,
    builder: (column) => column,
  );
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxTable,
          SyncOutboxRow,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxRow,
            BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxRow>,
          ),
          SyncOutboxRow,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$AppDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entite = const Value.absent(),
                Value<String> entiteId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<DateTime> creeLe = const Value.absent(),
                Value<int> tentatives = const Value.absent(),
                Value<DateTime?> derniereTentativeLe = const Value.absent(),
                Value<String?> derniereErreur = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                id: id,
                entite: entite,
                entiteId: entiteId,
                operation: operation,
                creeLe: creeLe,
                tentatives: tentatives,
                derniereTentativeLe: derniereTentativeLe,
                derniereErreur: derniereErreur,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entite,
                required String entiteId,
                required String operation,
                required DateTime creeLe,
                Value<int> tentatives = const Value.absent(),
                Value<DateTime?> derniereTentativeLe = const Value.absent(),
                Value<String?> derniereErreur = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                id: id,
                entite: entite,
                entiteId: entiteId,
                operation: operation,
                creeLe: creeLe,
                tentatives: tentatives,
                derniereTentativeLe: derniereTentativeLe,
                derniereErreur: derniereErreur,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxTable,
      SyncOutboxRow,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxRow,
        BaseReferences<_$AppDatabase, $SyncOutboxTable, SyncOutboxRow>,
      ),
      SyncOutboxRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrganisationNodesTableTableManager get organisationNodes =>
      $$OrganisationNodesTableTableManager(_db, _db.organisationNodes);
  $$HistoriqueRattachementsTableTableManager get historiqueRattachements =>
      $$HistoriqueRattachementsTableTableManager(
        _db,
        _db.historiqueRattachements,
      );
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
}
