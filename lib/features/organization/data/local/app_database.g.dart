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

class $FidelesTable extends Fideles with TableInfo<$FidelesTable, FideleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FidelesTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES organisation_nodes (id)',
    ),
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
  static const VerificationMeta _prenomsMeta = const VerificationMeta(
    'prenoms',
  );
  @override
  late final GeneratedColumn<String> prenoms = GeneratedColumn<String>(
    'prenoms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateNaissanceMeta = const VerificationMeta(
    'dateNaissance',
  );
  @override
  late final GeneratedColumn<DateTime> dateNaissance =
      GeneratedColumn<DateTime>(
        'date_naissance',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sexeMeta = const VerificationMeta('sexe');
  @override
  late final GeneratedColumn<String> sexe = GeneratedColumn<String>(
    'sexe',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutCivilMeta = const VerificationMeta(
    'statutCivil',
  );
  @override
  late final GeneratedColumn<String> statutCivil = GeneratedColumn<String>(
    'statut_civil',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutSpirituelMeta = const VerificationMeta(
    'statutSpirituel',
  );
  @override
  late final GeneratedColumn<String> statutSpirituel = GeneratedColumn<String>(
    'statut_spirituel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('visiteur'),
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('actif'),
  );
  static const VerificationMeta _dateConversionMeta = const VerificationMeta(
    'dateConversion',
  );
  @override
  late final GeneratedColumn<DateTime> dateConversion =
      GeneratedColumn<DateTime>(
        'date_conversion',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateBaptemeMeta = const VerificationMeta(
    'dateBapteme',
  );
  @override
  late final GeneratedColumn<DateTime> dateBapteme = GeneratedColumn<DateTime>(
    'date_bapteme',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _egliseProvenanceMeta = const VerificationMeta(
    'egliseProvenance',
  );
  @override
  late final GeneratedColumn<String> egliseProvenance = GeneratedColumn<String>(
    'eglise_provenance',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telephoneMeta = const VerificationMeta(
    'telephone',
  );
  @override
  late final GeneratedColumn<String> telephone = GeneratedColumn<String>(
    'telephone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adresseMeta = const VerificationMeta(
    'adresse',
  );
  @override
  late final GeneratedColumn<String> adresse = GeneratedColumn<String>(
    'adresse',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    noeudId,
    nom,
    prenoms,
    dateNaissance,
    sexe,
    statutCivil,
    statutSpirituel,
    statut,
    dateConversion,
    dateBapteme,
    egliseProvenance,
    photoUrl,
    telephone,
    email,
    adresse,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fideles';
  @override
  VerificationContext validateIntegrity(
    Insertable<FideleRow> instance, {
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
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenoms')) {
      context.handle(
        _prenomsMeta,
        prenoms.isAcceptableOrUnknown(data['prenoms']!, _prenomsMeta),
      );
    } else if (isInserting) {
      context.missing(_prenomsMeta);
    }
    if (data.containsKey('date_naissance')) {
      context.handle(
        _dateNaissanceMeta,
        dateNaissance.isAcceptableOrUnknown(
          data['date_naissance']!,
          _dateNaissanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateNaissanceMeta);
    }
    if (data.containsKey('sexe')) {
      context.handle(
        _sexeMeta,
        sexe.isAcceptableOrUnknown(data['sexe']!, _sexeMeta),
      );
    } else if (isInserting) {
      context.missing(_sexeMeta);
    }
    if (data.containsKey('statut_civil')) {
      context.handle(
        _statutCivilMeta,
        statutCivil.isAcceptableOrUnknown(
          data['statut_civil']!,
          _statutCivilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statutCivilMeta);
    }
    if (data.containsKey('statut_spirituel')) {
      context.handle(
        _statutSpirituelMeta,
        statutSpirituel.isAcceptableOrUnknown(
          data['statut_spirituel']!,
          _statutSpirituelMeta,
        ),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('date_conversion')) {
      context.handle(
        _dateConversionMeta,
        dateConversion.isAcceptableOrUnknown(
          data['date_conversion']!,
          _dateConversionMeta,
        ),
      );
    }
    if (data.containsKey('date_bapteme')) {
      context.handle(
        _dateBaptemeMeta,
        dateBapteme.isAcceptableOrUnknown(
          data['date_bapteme']!,
          _dateBaptemeMeta,
        ),
      );
    }
    if (data.containsKey('eglise_provenance')) {
      context.handle(
        _egliseProvenanceMeta,
        egliseProvenance.isAcceptableOrUnknown(
          data['eglise_provenance']!,
          _egliseProvenanceMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('telephone')) {
      context.handle(
        _telephoneMeta,
        telephone.isAcceptableOrUnknown(data['telephone']!, _telephoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('adresse')) {
      context.handle(
        _adresseMeta,
        adresse.isAcceptableOrUnknown(data['adresse']!, _adresseMeta),
      );
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
  FideleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FideleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      noeudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}noeud_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      prenoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prenoms'],
      )!,
      dateNaissance: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_naissance'],
      )!,
      sexe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sexe'],
      )!,
      statutCivil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut_civil'],
      )!,
      statutSpirituel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut_spirituel'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      dateConversion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_conversion'],
      ),
      dateBapteme: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_bapteme'],
      ),
      egliseProvenance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}eglise_provenance'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      telephone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telephone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      adresse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adresse'],
      ),
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
  $FidelesTable createAlias(String alias) {
    return $FidelesTable(attachedDatabase, alias);
  }
}

class FideleRow extends DataClass implements Insertable<FideleRow> {
  final String id;
  final String noeudId;
  final String nom;
  final String prenoms;
  final DateTime dateNaissance;
  final String sexe;
  final String statutCivil;
  final String statutSpirituel;
  final String statut;
  final DateTime? dateConversion;
  final DateTime? dateBapteme;
  final String? egliseProvenance;
  final String? photoUrl;
  final String? telephone;
  final String? email;
  final String? adresse;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FideleRow({
    required this.id,
    required this.noeudId,
    required this.nom,
    required this.prenoms,
    required this.dateNaissance,
    required this.sexe,
    required this.statutCivil,
    required this.statutSpirituel,
    required this.statut,
    this.dateConversion,
    this.dateBapteme,
    this.egliseProvenance,
    this.photoUrl,
    this.telephone,
    this.email,
    this.adresse,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['noeud_id'] = Variable<String>(noeudId);
    map['nom'] = Variable<String>(nom);
    map['prenoms'] = Variable<String>(prenoms);
    map['date_naissance'] = Variable<DateTime>(dateNaissance);
    map['sexe'] = Variable<String>(sexe);
    map['statut_civil'] = Variable<String>(statutCivil);
    map['statut_spirituel'] = Variable<String>(statutSpirituel);
    map['statut'] = Variable<String>(statut);
    if (!nullToAbsent || dateConversion != null) {
      map['date_conversion'] = Variable<DateTime>(dateConversion);
    }
    if (!nullToAbsent || dateBapteme != null) {
      map['date_bapteme'] = Variable<DateTime>(dateBapteme);
    }
    if (!nullToAbsent || egliseProvenance != null) {
      map['eglise_provenance'] = Variable<String>(egliseProvenance);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || telephone != null) {
      map['telephone'] = Variable<String>(telephone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || adresse != null) {
      map['adresse'] = Variable<String>(adresse);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FidelesCompanion toCompanion(bool nullToAbsent) {
    return FidelesCompanion(
      id: Value(id),
      noeudId: Value(noeudId),
      nom: Value(nom),
      prenoms: Value(prenoms),
      dateNaissance: Value(dateNaissance),
      sexe: Value(sexe),
      statutCivil: Value(statutCivil),
      statutSpirituel: Value(statutSpirituel),
      statut: Value(statut),
      dateConversion: dateConversion == null && nullToAbsent
          ? const Value.absent()
          : Value(dateConversion),
      dateBapteme: dateBapteme == null && nullToAbsent
          ? const Value.absent()
          : Value(dateBapteme),
      egliseProvenance: egliseProvenance == null && nullToAbsent
          ? const Value.absent()
          : Value(egliseProvenance),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      telephone: telephone == null && nullToAbsent
          ? const Value.absent()
          : Value(telephone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      adresse: adresse == null && nullToAbsent
          ? const Value.absent()
          : Value(adresse),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FideleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FideleRow(
      id: serializer.fromJson<String>(json['id']),
      noeudId: serializer.fromJson<String>(json['noeudId']),
      nom: serializer.fromJson<String>(json['nom']),
      prenoms: serializer.fromJson<String>(json['prenoms']),
      dateNaissance: serializer.fromJson<DateTime>(json['dateNaissance']),
      sexe: serializer.fromJson<String>(json['sexe']),
      statutCivil: serializer.fromJson<String>(json['statutCivil']),
      statutSpirituel: serializer.fromJson<String>(json['statutSpirituel']),
      statut: serializer.fromJson<String>(json['statut']),
      dateConversion: serializer.fromJson<DateTime?>(json['dateConversion']),
      dateBapteme: serializer.fromJson<DateTime?>(json['dateBapteme']),
      egliseProvenance: serializer.fromJson<String?>(json['egliseProvenance']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      telephone: serializer.fromJson<String?>(json['telephone']),
      email: serializer.fromJson<String?>(json['email']),
      adresse: serializer.fromJson<String?>(json['adresse']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'noeudId': serializer.toJson<String>(noeudId),
      'nom': serializer.toJson<String>(nom),
      'prenoms': serializer.toJson<String>(prenoms),
      'dateNaissance': serializer.toJson<DateTime>(dateNaissance),
      'sexe': serializer.toJson<String>(sexe),
      'statutCivil': serializer.toJson<String>(statutCivil),
      'statutSpirituel': serializer.toJson<String>(statutSpirituel),
      'statut': serializer.toJson<String>(statut),
      'dateConversion': serializer.toJson<DateTime?>(dateConversion),
      'dateBapteme': serializer.toJson<DateTime?>(dateBapteme),
      'egliseProvenance': serializer.toJson<String?>(egliseProvenance),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'telephone': serializer.toJson<String?>(telephone),
      'email': serializer.toJson<String?>(email),
      'adresse': serializer.toJson<String?>(adresse),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FideleRow copyWith({
    String? id,
    String? noeudId,
    String? nom,
    String? prenoms,
    DateTime? dateNaissance,
    String? sexe,
    String? statutCivil,
    String? statutSpirituel,
    String? statut,
    Value<DateTime?> dateConversion = const Value.absent(),
    Value<DateTime?> dateBapteme = const Value.absent(),
    Value<String?> egliseProvenance = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> telephone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> adresse = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FideleRow(
    id: id ?? this.id,
    noeudId: noeudId ?? this.noeudId,
    nom: nom ?? this.nom,
    prenoms: prenoms ?? this.prenoms,
    dateNaissance: dateNaissance ?? this.dateNaissance,
    sexe: sexe ?? this.sexe,
    statutCivil: statutCivil ?? this.statutCivil,
    statutSpirituel: statutSpirituel ?? this.statutSpirituel,
    statut: statut ?? this.statut,
    dateConversion: dateConversion.present
        ? dateConversion.value
        : this.dateConversion,
    dateBapteme: dateBapteme.present ? dateBapteme.value : this.dateBapteme,
    egliseProvenance: egliseProvenance.present
        ? egliseProvenance.value
        : this.egliseProvenance,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    telephone: telephone.present ? telephone.value : this.telephone,
    email: email.present ? email.value : this.email,
    adresse: adresse.present ? adresse.value : this.adresse,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FideleRow copyWithCompanion(FidelesCompanion data) {
    return FideleRow(
      id: data.id.present ? data.id.value : this.id,
      noeudId: data.noeudId.present ? data.noeudId.value : this.noeudId,
      nom: data.nom.present ? data.nom.value : this.nom,
      prenoms: data.prenoms.present ? data.prenoms.value : this.prenoms,
      dateNaissance: data.dateNaissance.present
          ? data.dateNaissance.value
          : this.dateNaissance,
      sexe: data.sexe.present ? data.sexe.value : this.sexe,
      statutCivil: data.statutCivil.present
          ? data.statutCivil.value
          : this.statutCivil,
      statutSpirituel: data.statutSpirituel.present
          ? data.statutSpirituel.value
          : this.statutSpirituel,
      statut: data.statut.present ? data.statut.value : this.statut,
      dateConversion: data.dateConversion.present
          ? data.dateConversion.value
          : this.dateConversion,
      dateBapteme: data.dateBapteme.present
          ? data.dateBapteme.value
          : this.dateBapteme,
      egliseProvenance: data.egliseProvenance.present
          ? data.egliseProvenance.value
          : this.egliseProvenance,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      telephone: data.telephone.present ? data.telephone.value : this.telephone,
      email: data.email.present ? data.email.value : this.email,
      adresse: data.adresse.present ? data.adresse.value : this.adresse,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FideleRow(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('nom: $nom, ')
          ..write('prenoms: $prenoms, ')
          ..write('dateNaissance: $dateNaissance, ')
          ..write('sexe: $sexe, ')
          ..write('statutCivil: $statutCivil, ')
          ..write('statutSpirituel: $statutSpirituel, ')
          ..write('statut: $statut, ')
          ..write('dateConversion: $dateConversion, ')
          ..write('dateBapteme: $dateBapteme, ')
          ..write('egliseProvenance: $egliseProvenance, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('telephone: $telephone, ')
          ..write('email: $email, ')
          ..write('adresse: $adresse, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    noeudId,
    nom,
    prenoms,
    dateNaissance,
    sexe,
    statutCivil,
    statutSpirituel,
    statut,
    dateConversion,
    dateBapteme,
    egliseProvenance,
    photoUrl,
    telephone,
    email,
    adresse,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FideleRow &&
          other.id == this.id &&
          other.noeudId == this.noeudId &&
          other.nom == this.nom &&
          other.prenoms == this.prenoms &&
          other.dateNaissance == this.dateNaissance &&
          other.sexe == this.sexe &&
          other.statutCivil == this.statutCivil &&
          other.statutSpirituel == this.statutSpirituel &&
          other.statut == this.statut &&
          other.dateConversion == this.dateConversion &&
          other.dateBapteme == this.dateBapteme &&
          other.egliseProvenance == this.egliseProvenance &&
          other.photoUrl == this.photoUrl &&
          other.telephone == this.telephone &&
          other.email == this.email &&
          other.adresse == this.adresse &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FidelesCompanion extends UpdateCompanion<FideleRow> {
  final Value<String> id;
  final Value<String> noeudId;
  final Value<String> nom;
  final Value<String> prenoms;
  final Value<DateTime> dateNaissance;
  final Value<String> sexe;
  final Value<String> statutCivil;
  final Value<String> statutSpirituel;
  final Value<String> statut;
  final Value<DateTime?> dateConversion;
  final Value<DateTime?> dateBapteme;
  final Value<String?> egliseProvenance;
  final Value<String?> photoUrl;
  final Value<String?> telephone;
  final Value<String?> email;
  final Value<String?> adresse;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FidelesCompanion({
    this.id = const Value.absent(),
    this.noeudId = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenoms = const Value.absent(),
    this.dateNaissance = const Value.absent(),
    this.sexe = const Value.absent(),
    this.statutCivil = const Value.absent(),
    this.statutSpirituel = const Value.absent(),
    this.statut = const Value.absent(),
    this.dateConversion = const Value.absent(),
    this.dateBapteme = const Value.absent(),
    this.egliseProvenance = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.telephone = const Value.absent(),
    this.email = const Value.absent(),
    this.adresse = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FidelesCompanion.insert({
    required String id,
    required String noeudId,
    required String nom,
    required String prenoms,
    required DateTime dateNaissance,
    required String sexe,
    required String statutCivil,
    this.statutSpirituel = const Value.absent(),
    this.statut = const Value.absent(),
    this.dateConversion = const Value.absent(),
    this.dateBapteme = const Value.absent(),
    this.egliseProvenance = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.telephone = const Value.absent(),
    this.email = const Value.absent(),
    this.adresse = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       noeudId = Value(noeudId),
       nom = Value(nom),
       prenoms = Value(prenoms),
       dateNaissance = Value(dateNaissance),
       sexe = Value(sexe),
       statutCivil = Value(statutCivil),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FideleRow> custom({
    Expression<String>? id,
    Expression<String>? noeudId,
    Expression<String>? nom,
    Expression<String>? prenoms,
    Expression<DateTime>? dateNaissance,
    Expression<String>? sexe,
    Expression<String>? statutCivil,
    Expression<String>? statutSpirituel,
    Expression<String>? statut,
    Expression<DateTime>? dateConversion,
    Expression<DateTime>? dateBapteme,
    Expression<String>? egliseProvenance,
    Expression<String>? photoUrl,
    Expression<String>? telephone,
    Expression<String>? email,
    Expression<String>? adresse,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noeudId != null) 'noeud_id': noeudId,
      if (nom != null) 'nom': nom,
      if (prenoms != null) 'prenoms': prenoms,
      if (dateNaissance != null) 'date_naissance': dateNaissance,
      if (sexe != null) 'sexe': sexe,
      if (statutCivil != null) 'statut_civil': statutCivil,
      if (statutSpirituel != null) 'statut_spirituel': statutSpirituel,
      if (statut != null) 'statut': statut,
      if (dateConversion != null) 'date_conversion': dateConversion,
      if (dateBapteme != null) 'date_bapteme': dateBapteme,
      if (egliseProvenance != null) 'eglise_provenance': egliseProvenance,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
      if (adresse != null) 'adresse': adresse,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FidelesCompanion copyWith({
    Value<String>? id,
    Value<String>? noeudId,
    Value<String>? nom,
    Value<String>? prenoms,
    Value<DateTime>? dateNaissance,
    Value<String>? sexe,
    Value<String>? statutCivil,
    Value<String>? statutSpirituel,
    Value<String>? statut,
    Value<DateTime?>? dateConversion,
    Value<DateTime?>? dateBapteme,
    Value<String?>? egliseProvenance,
    Value<String?>? photoUrl,
    Value<String?>? telephone,
    Value<String?>? email,
    Value<String?>? adresse,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FidelesCompanion(
      id: id ?? this.id,
      noeudId: noeudId ?? this.noeudId,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      dateNaissance: dateNaissance ?? this.dateNaissance,
      sexe: sexe ?? this.sexe,
      statutCivil: statutCivil ?? this.statutCivil,
      statutSpirituel: statutSpirituel ?? this.statutSpirituel,
      statut: statut ?? this.statut,
      dateConversion: dateConversion ?? this.dateConversion,
      dateBapteme: dateBapteme ?? this.dateBapteme,
      egliseProvenance: egliseProvenance ?? this.egliseProvenance,
      photoUrl: photoUrl ?? this.photoUrl,
      telephone: telephone ?? this.telephone,
      email: email ?? this.email,
      adresse: adresse ?? this.adresse,
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
    if (noeudId.present) {
      map['noeud_id'] = Variable<String>(noeudId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenoms.present) {
      map['prenoms'] = Variable<String>(prenoms.value);
    }
    if (dateNaissance.present) {
      map['date_naissance'] = Variable<DateTime>(dateNaissance.value);
    }
    if (sexe.present) {
      map['sexe'] = Variable<String>(sexe.value);
    }
    if (statutCivil.present) {
      map['statut_civil'] = Variable<String>(statutCivil.value);
    }
    if (statutSpirituel.present) {
      map['statut_spirituel'] = Variable<String>(statutSpirituel.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (dateConversion.present) {
      map['date_conversion'] = Variable<DateTime>(dateConversion.value);
    }
    if (dateBapteme.present) {
      map['date_bapteme'] = Variable<DateTime>(dateBapteme.value);
    }
    if (egliseProvenance.present) {
      map['eglise_provenance'] = Variable<String>(egliseProvenance.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (telephone.present) {
      map['telephone'] = Variable<String>(telephone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (adresse.present) {
      map['adresse'] = Variable<String>(adresse.value);
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
    return (StringBuffer('FidelesCompanion(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('nom: $nom, ')
          ..write('prenoms: $prenoms, ')
          ..write('dateNaissance: $dateNaissance, ')
          ..write('sexe: $sexe, ')
          ..write('statutCivil: $statutCivil, ')
          ..write('statutSpirituel: $statutSpirituel, ')
          ..write('statut: $statut, ')
          ..write('dateConversion: $dateConversion, ')
          ..write('dateBapteme: $dateBapteme, ')
          ..write('egliseProvenance: $egliseProvenance, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('telephone: $telephone, ')
          ..write('email: $email, ')
          ..write('adresse: $adresse, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiensFamiliauxTable extends LiensFamiliaux
    with TableInfo<$LiensFamiliauxTable, LienFamilialRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiensFamiliauxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fideleId1Meta = const VerificationMeta(
    'fideleId1',
  );
  @override
  late final GeneratedColumn<String> fideleId1 = GeneratedColumn<String>(
    'fidele_id1',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  static const VerificationMeta _fideleId2Meta = const VerificationMeta(
    'fideleId2',
  );
  @override
  late final GeneratedColumn<String> fideleId2 = GeneratedColumn<String>(
    'fidele_id2',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  static const VerificationMeta _typeLienMeta = const VerificationMeta(
    'typeLien',
  );
  @override
  late final GeneratedColumn<String> typeLien = GeneratedColumn<String>(
    'type_lien',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fideleId1, fideleId2, typeLien];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liens_familiaux';
  @override
  VerificationContext validateIntegrity(
    Insertable<LienFamilialRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fidele_id1')) {
      context.handle(
        _fideleId1Meta,
        fideleId1.isAcceptableOrUnknown(data['fidele_id1']!, _fideleId1Meta),
      );
    } else if (isInserting) {
      context.missing(_fideleId1Meta);
    }
    if (data.containsKey('fidele_id2')) {
      context.handle(
        _fideleId2Meta,
        fideleId2.isAcceptableOrUnknown(data['fidele_id2']!, _fideleId2Meta),
      );
    } else if (isInserting) {
      context.missing(_fideleId2Meta);
    }
    if (data.containsKey('type_lien')) {
      context.handle(
        _typeLienMeta,
        typeLien.isAcceptableOrUnknown(data['type_lien']!, _typeLienMeta),
      );
    } else if (isInserting) {
      context.missing(_typeLienMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LienFamilialRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LienFamilialRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id1'],
      )!,
      fideleId2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id2'],
      )!,
      typeLien: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_lien'],
      )!,
    );
  }

  @override
  $LiensFamiliauxTable createAlias(String alias) {
    return $LiensFamiliauxTable(attachedDatabase, alias);
  }
}

class LienFamilialRow extends DataClass implements Insertable<LienFamilialRow> {
  final String id;
  final String fideleId1;
  final String fideleId2;
  final String typeLien;
  const LienFamilialRow({
    required this.id,
    required this.fideleId1,
    required this.fideleId2,
    required this.typeLien,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id1'] = Variable<String>(fideleId1);
    map['fidele_id2'] = Variable<String>(fideleId2);
    map['type_lien'] = Variable<String>(typeLien);
    return map;
  }

  LiensFamiliauxCompanion toCompanion(bool nullToAbsent) {
    return LiensFamiliauxCompanion(
      id: Value(id),
      fideleId1: Value(fideleId1),
      fideleId2: Value(fideleId2),
      typeLien: Value(typeLien),
    );
  }

  factory LienFamilialRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LienFamilialRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId1: serializer.fromJson<String>(json['fideleId1']),
      fideleId2: serializer.fromJson<String>(json['fideleId2']),
      typeLien: serializer.fromJson<String>(json['typeLien']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId1': serializer.toJson<String>(fideleId1),
      'fideleId2': serializer.toJson<String>(fideleId2),
      'typeLien': serializer.toJson<String>(typeLien),
    };
  }

  LienFamilialRow copyWith({
    String? id,
    String? fideleId1,
    String? fideleId2,
    String? typeLien,
  }) => LienFamilialRow(
    id: id ?? this.id,
    fideleId1: fideleId1 ?? this.fideleId1,
    fideleId2: fideleId2 ?? this.fideleId2,
    typeLien: typeLien ?? this.typeLien,
  );
  LienFamilialRow copyWithCompanion(LiensFamiliauxCompanion data) {
    return LienFamilialRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId1: data.fideleId1.present ? data.fideleId1.value : this.fideleId1,
      fideleId2: data.fideleId2.present ? data.fideleId2.value : this.fideleId2,
      typeLien: data.typeLien.present ? data.typeLien.value : this.typeLien,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LienFamilialRow(')
          ..write('id: $id, ')
          ..write('fideleId1: $fideleId1, ')
          ..write('fideleId2: $fideleId2, ')
          ..write('typeLien: $typeLien')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fideleId1, fideleId2, typeLien);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LienFamilialRow &&
          other.id == this.id &&
          other.fideleId1 == this.fideleId1 &&
          other.fideleId2 == this.fideleId2 &&
          other.typeLien == this.typeLien);
}

class LiensFamiliauxCompanion extends UpdateCompanion<LienFamilialRow> {
  final Value<String> id;
  final Value<String> fideleId1;
  final Value<String> fideleId2;
  final Value<String> typeLien;
  final Value<int> rowid;
  const LiensFamiliauxCompanion({
    this.id = const Value.absent(),
    this.fideleId1 = const Value.absent(),
    this.fideleId2 = const Value.absent(),
    this.typeLien = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiensFamiliauxCompanion.insert({
    required String id,
    required String fideleId1,
    required String fideleId2,
    required String typeLien,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId1 = Value(fideleId1),
       fideleId2 = Value(fideleId2),
       typeLien = Value(typeLien);
  static Insertable<LienFamilialRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId1,
    Expression<String>? fideleId2,
    Expression<String>? typeLien,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId1 != null) 'fidele_id1': fideleId1,
      if (fideleId2 != null) 'fidele_id2': fideleId2,
      if (typeLien != null) 'type_lien': typeLien,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiensFamiliauxCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId1,
    Value<String>? fideleId2,
    Value<String>? typeLien,
    Value<int>? rowid,
  }) {
    return LiensFamiliauxCompanion(
      id: id ?? this.id,
      fideleId1: fideleId1 ?? this.fideleId1,
      fideleId2: fideleId2 ?? this.fideleId2,
      typeLien: typeLien ?? this.typeLien,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fideleId1.present) {
      map['fidele_id1'] = Variable<String>(fideleId1.value);
    }
    if (fideleId2.present) {
      map['fidele_id2'] = Variable<String>(fideleId2.value);
    }
    if (typeLien.present) {
      map['type_lien'] = Variable<String>(typeLien.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiensFamiliauxCompanion(')
          ..write('id: $id, ')
          ..write('fideleId1: $fideleId1, ')
          ..write('fideleId2: $fideleId2, ')
          ..write('typeLien: $typeLien, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistoriqueFidelesTable extends HistoriqueFideles
    with TableInfo<$HistoriqueFidelesTable, HistoriqueFideleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriqueFidelesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fideleIdMeta = const VerificationMeta(
    'fideleId',
  );
  @override
  late final GeneratedColumn<String> fideleId = GeneratedColumn<String>(
    'fidele_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  static const VerificationMeta _champModifieMeta = const VerificationMeta(
    'champModifie',
  );
  @override
  late final GeneratedColumn<String> champModifie = GeneratedColumn<String>(
    'champ_modifie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ancienneValeurMeta = const VerificationMeta(
    'ancienneValeur',
  );
  @override
  late final GeneratedColumn<String> ancienneValeur = GeneratedColumn<String>(
    'ancienne_valeur',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nouvelleValeurMeta = const VerificationMeta(
    'nouvelleValeur',
  );
  @override
  late final GeneratedColumn<String> nouvelleValeur = GeneratedColumn<String>(
    'nouvelle_valeur',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _auteurFideleIdMeta = const VerificationMeta(
    'auteurFideleId',
  );
  @override
  late final GeneratedColumn<String> auteurFideleId = GeneratedColumn<String>(
    'auteur_fidele_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fideleId,
    champModifie,
    ancienneValeur,
    nouvelleValeur,
    auteurFideleId,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historique_fideles';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoriqueFideleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fidele_id')) {
      context.handle(
        _fideleIdMeta,
        fideleId.isAcceptableOrUnknown(data['fidele_id']!, _fideleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fideleIdMeta);
    }
    if (data.containsKey('champ_modifie')) {
      context.handle(
        _champModifieMeta,
        champModifie.isAcceptableOrUnknown(
          data['champ_modifie']!,
          _champModifieMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_champModifieMeta);
    }
    if (data.containsKey('ancienne_valeur')) {
      context.handle(
        _ancienneValeurMeta,
        ancienneValeur.isAcceptableOrUnknown(
          data['ancienne_valeur']!,
          _ancienneValeurMeta,
        ),
      );
    }
    if (data.containsKey('nouvelle_valeur')) {
      context.handle(
        _nouvelleValeurMeta,
        nouvelleValeur.isAcceptableOrUnknown(
          data['nouvelle_valeur']!,
          _nouvelleValeurMeta,
        ),
      );
    }
    if (data.containsKey('auteur_fidele_id')) {
      context.handle(
        _auteurFideleIdMeta,
        auteurFideleId.isAcceptableOrUnknown(
          data['auteur_fidele_id']!,
          _auteurFideleIdMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoriqueFideleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoriqueFideleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      champModifie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}champ_modifie'],
      )!,
      ancienneValeur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ancienne_valeur'],
      ),
      nouvelleValeur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nouvelle_valeur'],
      ),
      auteurFideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auteur_fidele_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $HistoriqueFidelesTable createAlias(String alias) {
    return $HistoriqueFidelesTable(attachedDatabase, alias);
  }
}

class HistoriqueFideleRow extends DataClass
    implements Insertable<HistoriqueFideleRow> {
  final String id;
  final String fideleId;
  final String champModifie;
  final String? ancienneValeur;
  final String? nouvelleValeur;
  final String? auteurFideleId;
  final DateTime date;
  const HistoriqueFideleRow({
    required this.id,
    required this.fideleId,
    required this.champModifie,
    this.ancienneValeur,
    this.nouvelleValeur,
    this.auteurFideleId,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id'] = Variable<String>(fideleId);
    map['champ_modifie'] = Variable<String>(champModifie);
    if (!nullToAbsent || ancienneValeur != null) {
      map['ancienne_valeur'] = Variable<String>(ancienneValeur);
    }
    if (!nullToAbsent || nouvelleValeur != null) {
      map['nouvelle_valeur'] = Variable<String>(nouvelleValeur);
    }
    if (!nullToAbsent || auteurFideleId != null) {
      map['auteur_fidele_id'] = Variable<String>(auteurFideleId);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  HistoriqueFidelesCompanion toCompanion(bool nullToAbsent) {
    return HistoriqueFidelesCompanion(
      id: Value(id),
      fideleId: Value(fideleId),
      champModifie: Value(champModifie),
      ancienneValeur: ancienneValeur == null && nullToAbsent
          ? const Value.absent()
          : Value(ancienneValeur),
      nouvelleValeur: nouvelleValeur == null && nullToAbsent
          ? const Value.absent()
          : Value(nouvelleValeur),
      auteurFideleId: auteurFideleId == null && nullToAbsent
          ? const Value.absent()
          : Value(auteurFideleId),
      date: Value(date),
    );
  }

  factory HistoriqueFideleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoriqueFideleRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      champModifie: serializer.fromJson<String>(json['champModifie']),
      ancienneValeur: serializer.fromJson<String?>(json['ancienneValeur']),
      nouvelleValeur: serializer.fromJson<String?>(json['nouvelleValeur']),
      auteurFideleId: serializer.fromJson<String?>(json['auteurFideleId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId': serializer.toJson<String>(fideleId),
      'champModifie': serializer.toJson<String>(champModifie),
      'ancienneValeur': serializer.toJson<String?>(ancienneValeur),
      'nouvelleValeur': serializer.toJson<String?>(nouvelleValeur),
      'auteurFideleId': serializer.toJson<String?>(auteurFideleId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  HistoriqueFideleRow copyWith({
    String? id,
    String? fideleId,
    String? champModifie,
    Value<String?> ancienneValeur = const Value.absent(),
    Value<String?> nouvelleValeur = const Value.absent(),
    Value<String?> auteurFideleId = const Value.absent(),
    DateTime? date,
  }) => HistoriqueFideleRow(
    id: id ?? this.id,
    fideleId: fideleId ?? this.fideleId,
    champModifie: champModifie ?? this.champModifie,
    ancienneValeur: ancienneValeur.present
        ? ancienneValeur.value
        : this.ancienneValeur,
    nouvelleValeur: nouvelleValeur.present
        ? nouvelleValeur.value
        : this.nouvelleValeur,
    auteurFideleId: auteurFideleId.present
        ? auteurFideleId.value
        : this.auteurFideleId,
    date: date ?? this.date,
  );
  HistoriqueFideleRow copyWithCompanion(HistoriqueFidelesCompanion data) {
    return HistoriqueFideleRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      champModifie: data.champModifie.present
          ? data.champModifie.value
          : this.champModifie,
      ancienneValeur: data.ancienneValeur.present
          ? data.ancienneValeur.value
          : this.ancienneValeur,
      nouvelleValeur: data.nouvelleValeur.present
          ? data.nouvelleValeur.value
          : this.nouvelleValeur,
      auteurFideleId: data.auteurFideleId.present
          ? data.auteurFideleId.value
          : this.auteurFideleId,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoriqueFideleRow(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('champModifie: $champModifie, ')
          ..write('ancienneValeur: $ancienneValeur, ')
          ..write('nouvelleValeur: $nouvelleValeur, ')
          ..write('auteurFideleId: $auteurFideleId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fideleId,
    champModifie,
    ancienneValeur,
    nouvelleValeur,
    auteurFideleId,
    date,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoriqueFideleRow &&
          other.id == this.id &&
          other.fideleId == this.fideleId &&
          other.champModifie == this.champModifie &&
          other.ancienneValeur == this.ancienneValeur &&
          other.nouvelleValeur == this.nouvelleValeur &&
          other.auteurFideleId == this.auteurFideleId &&
          other.date == this.date);
}

class HistoriqueFidelesCompanion extends UpdateCompanion<HistoriqueFideleRow> {
  final Value<String> id;
  final Value<String> fideleId;
  final Value<String> champModifie;
  final Value<String?> ancienneValeur;
  final Value<String?> nouvelleValeur;
  final Value<String?> auteurFideleId;
  final Value<DateTime> date;
  final Value<int> rowid;
  const HistoriqueFidelesCompanion({
    this.id = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.champModifie = const Value.absent(),
    this.ancienneValeur = const Value.absent(),
    this.nouvelleValeur = const Value.absent(),
    this.auteurFideleId = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistoriqueFidelesCompanion.insert({
    required String id,
    required String fideleId,
    required String champModifie,
    this.ancienneValeur = const Value.absent(),
    this.nouvelleValeur = const Value.absent(),
    this.auteurFideleId = const Value.absent(),
    required DateTime date,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId = Value(fideleId),
       champModifie = Value(champModifie),
       date = Value(date);
  static Insertable<HistoriqueFideleRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId,
    Expression<String>? champModifie,
    Expression<String>? ancienneValeur,
    Expression<String>? nouvelleValeur,
    Expression<String>? auteurFideleId,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId != null) 'fidele_id': fideleId,
      if (champModifie != null) 'champ_modifie': champModifie,
      if (ancienneValeur != null) 'ancienne_valeur': ancienneValeur,
      if (nouvelleValeur != null) 'nouvelle_valeur': nouvelleValeur,
      if (auteurFideleId != null) 'auteur_fidele_id': auteurFideleId,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistoriqueFidelesCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId,
    Value<String>? champModifie,
    Value<String?>? ancienneValeur,
    Value<String?>? nouvelleValeur,
    Value<String?>? auteurFideleId,
    Value<DateTime>? date,
    Value<int>? rowid,
  }) {
    return HistoriqueFidelesCompanion(
      id: id ?? this.id,
      fideleId: fideleId ?? this.fideleId,
      champModifie: champModifie ?? this.champModifie,
      ancienneValeur: ancienneValeur ?? this.ancienneValeur,
      nouvelleValeur: nouvelleValeur ?? this.nouvelleValeur,
      auteurFideleId: auteurFideleId ?? this.auteurFideleId,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fideleId.present) {
      map['fidele_id'] = Variable<String>(fideleId.value);
    }
    if (champModifie.present) {
      map['champ_modifie'] = Variable<String>(champModifie.value);
    }
    if (ancienneValeur.present) {
      map['ancienne_valeur'] = Variable<String>(ancienneValeur.value);
    }
    if (nouvelleValeur.present) {
      map['nouvelle_valeur'] = Variable<String>(nouvelleValeur.value);
    }
    if (auteurFideleId.present) {
      map['auteur_fidele_id'] = Variable<String>(auteurFideleId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriqueFidelesCompanion(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('champModifie: $champModifie, ')
          ..write('ancienneValeur: $ancienneValeur, ')
          ..write('nouvelleValeur: $nouvelleValeur, ')
          ..write('auteurFideleId: $auteurFideleId, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TuteursTable extends Tuteurs with TableInfo<$TuteursTable, TuteurRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TuteursTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mineurIdMeta = const VerificationMeta(
    'mineurId',
  );
  @override
  late final GeneratedColumn<String> mineurId = GeneratedColumn<String>(
    'mineur_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  static const VerificationMeta _lienMeta = const VerificationMeta('lien');
  @override
  late final GeneratedColumn<String> lien = GeneratedColumn<String>(
    'lien',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tuteurFideleIdMeta = const VerificationMeta(
    'tuteurFideleId',
  );
  @override
  late final GeneratedColumn<String> tuteurFideleId = GeneratedColumn<String>(
    'tuteur_fidele_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  static const VerificationMeta _tuteurTiersNomMeta = const VerificationMeta(
    'tuteurTiersNom',
  );
  @override
  late final GeneratedColumn<String> tuteurTiersNom = GeneratedColumn<String>(
    'tuteur_tiers_nom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tuteurTiersTelephoneMeta =
      const VerificationMeta('tuteurTiersTelephone');
  @override
  late final GeneratedColumn<String> tuteurTiersTelephone =
      GeneratedColumn<String>(
        'tuteur_tiers_telephone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mineurId,
    lien,
    tuteurFideleId,
    tuteurTiersNom,
    tuteurTiersTelephone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tuteurs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TuteurRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mineur_id')) {
      context.handle(
        _mineurIdMeta,
        mineurId.isAcceptableOrUnknown(data['mineur_id']!, _mineurIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mineurIdMeta);
    }
    if (data.containsKey('lien')) {
      context.handle(
        _lienMeta,
        lien.isAcceptableOrUnknown(data['lien']!, _lienMeta),
      );
    } else if (isInserting) {
      context.missing(_lienMeta);
    }
    if (data.containsKey('tuteur_fidele_id')) {
      context.handle(
        _tuteurFideleIdMeta,
        tuteurFideleId.isAcceptableOrUnknown(
          data['tuteur_fidele_id']!,
          _tuteurFideleIdMeta,
        ),
      );
    }
    if (data.containsKey('tuteur_tiers_nom')) {
      context.handle(
        _tuteurTiersNomMeta,
        tuteurTiersNom.isAcceptableOrUnknown(
          data['tuteur_tiers_nom']!,
          _tuteurTiersNomMeta,
        ),
      );
    }
    if (data.containsKey('tuteur_tiers_telephone')) {
      context.handle(
        _tuteurTiersTelephoneMeta,
        tuteurTiersTelephone.isAcceptableOrUnknown(
          data['tuteur_tiers_telephone']!,
          _tuteurTiersTelephoneMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TuteurRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TuteurRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mineurId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mineur_id'],
      )!,
      lien: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lien'],
      )!,
      tuteurFideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tuteur_fidele_id'],
      ),
      tuteurTiersNom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tuteur_tiers_nom'],
      ),
      tuteurTiersTelephone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tuteur_tiers_telephone'],
      ),
    );
  }

  @override
  $TuteursTable createAlias(String alias) {
    return $TuteursTable(attachedDatabase, alias);
  }
}

class TuteurRow extends DataClass implements Insertable<TuteurRow> {
  final String id;
  final String mineurId;
  final String lien;
  final String? tuteurFideleId;
  final String? tuteurTiersNom;
  final String? tuteurTiersTelephone;
  const TuteurRow({
    required this.id,
    required this.mineurId,
    required this.lien,
    this.tuteurFideleId,
    this.tuteurTiersNom,
    this.tuteurTiersTelephone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mineur_id'] = Variable<String>(mineurId);
    map['lien'] = Variable<String>(lien);
    if (!nullToAbsent || tuteurFideleId != null) {
      map['tuteur_fidele_id'] = Variable<String>(tuteurFideleId);
    }
    if (!nullToAbsent || tuteurTiersNom != null) {
      map['tuteur_tiers_nom'] = Variable<String>(tuteurTiersNom);
    }
    if (!nullToAbsent || tuteurTiersTelephone != null) {
      map['tuteur_tiers_telephone'] = Variable<String>(tuteurTiersTelephone);
    }
    return map;
  }

  TuteursCompanion toCompanion(bool nullToAbsent) {
    return TuteursCompanion(
      id: Value(id),
      mineurId: Value(mineurId),
      lien: Value(lien),
      tuteurFideleId: tuteurFideleId == null && nullToAbsent
          ? const Value.absent()
          : Value(tuteurFideleId),
      tuteurTiersNom: tuteurTiersNom == null && nullToAbsent
          ? const Value.absent()
          : Value(tuteurTiersNom),
      tuteurTiersTelephone: tuteurTiersTelephone == null && nullToAbsent
          ? const Value.absent()
          : Value(tuteurTiersTelephone),
    );
  }

  factory TuteurRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TuteurRow(
      id: serializer.fromJson<String>(json['id']),
      mineurId: serializer.fromJson<String>(json['mineurId']),
      lien: serializer.fromJson<String>(json['lien']),
      tuteurFideleId: serializer.fromJson<String?>(json['tuteurFideleId']),
      tuteurTiersNom: serializer.fromJson<String?>(json['tuteurTiersNom']),
      tuteurTiersTelephone: serializer.fromJson<String?>(
        json['tuteurTiersTelephone'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mineurId': serializer.toJson<String>(mineurId),
      'lien': serializer.toJson<String>(lien),
      'tuteurFideleId': serializer.toJson<String?>(tuteurFideleId),
      'tuteurTiersNom': serializer.toJson<String?>(tuteurTiersNom),
      'tuteurTiersTelephone': serializer.toJson<String?>(tuteurTiersTelephone),
    };
  }

  TuteurRow copyWith({
    String? id,
    String? mineurId,
    String? lien,
    Value<String?> tuteurFideleId = const Value.absent(),
    Value<String?> tuteurTiersNom = const Value.absent(),
    Value<String?> tuteurTiersTelephone = const Value.absent(),
  }) => TuteurRow(
    id: id ?? this.id,
    mineurId: mineurId ?? this.mineurId,
    lien: lien ?? this.lien,
    tuteurFideleId: tuteurFideleId.present
        ? tuteurFideleId.value
        : this.tuteurFideleId,
    tuteurTiersNom: tuteurTiersNom.present
        ? tuteurTiersNom.value
        : this.tuteurTiersNom,
    tuteurTiersTelephone: tuteurTiersTelephone.present
        ? tuteurTiersTelephone.value
        : this.tuteurTiersTelephone,
  );
  TuteurRow copyWithCompanion(TuteursCompanion data) {
    return TuteurRow(
      id: data.id.present ? data.id.value : this.id,
      mineurId: data.mineurId.present ? data.mineurId.value : this.mineurId,
      lien: data.lien.present ? data.lien.value : this.lien,
      tuteurFideleId: data.tuteurFideleId.present
          ? data.tuteurFideleId.value
          : this.tuteurFideleId,
      tuteurTiersNom: data.tuteurTiersNom.present
          ? data.tuteurTiersNom.value
          : this.tuteurTiersNom,
      tuteurTiersTelephone: data.tuteurTiersTelephone.present
          ? data.tuteurTiersTelephone.value
          : this.tuteurTiersTelephone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TuteurRow(')
          ..write('id: $id, ')
          ..write('mineurId: $mineurId, ')
          ..write('lien: $lien, ')
          ..write('tuteurFideleId: $tuteurFideleId, ')
          ..write('tuteurTiersNom: $tuteurTiersNom, ')
          ..write('tuteurTiersTelephone: $tuteurTiersTelephone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mineurId,
    lien,
    tuteurFideleId,
    tuteurTiersNom,
    tuteurTiersTelephone,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TuteurRow &&
          other.id == this.id &&
          other.mineurId == this.mineurId &&
          other.lien == this.lien &&
          other.tuteurFideleId == this.tuteurFideleId &&
          other.tuteurTiersNom == this.tuteurTiersNom &&
          other.tuteurTiersTelephone == this.tuteurTiersTelephone);
}

class TuteursCompanion extends UpdateCompanion<TuteurRow> {
  final Value<String> id;
  final Value<String> mineurId;
  final Value<String> lien;
  final Value<String?> tuteurFideleId;
  final Value<String?> tuteurTiersNom;
  final Value<String?> tuteurTiersTelephone;
  final Value<int> rowid;
  const TuteursCompanion({
    this.id = const Value.absent(),
    this.mineurId = const Value.absent(),
    this.lien = const Value.absent(),
    this.tuteurFideleId = const Value.absent(),
    this.tuteurTiersNom = const Value.absent(),
    this.tuteurTiersTelephone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TuteursCompanion.insert({
    required String id,
    required String mineurId,
    required String lien,
    this.tuteurFideleId = const Value.absent(),
    this.tuteurTiersNom = const Value.absent(),
    this.tuteurTiersTelephone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mineurId = Value(mineurId),
       lien = Value(lien);
  static Insertable<TuteurRow> custom({
    Expression<String>? id,
    Expression<String>? mineurId,
    Expression<String>? lien,
    Expression<String>? tuteurFideleId,
    Expression<String>? tuteurTiersNom,
    Expression<String>? tuteurTiersTelephone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mineurId != null) 'mineur_id': mineurId,
      if (lien != null) 'lien': lien,
      if (tuteurFideleId != null) 'tuteur_fidele_id': tuteurFideleId,
      if (tuteurTiersNom != null) 'tuteur_tiers_nom': tuteurTiersNom,
      if (tuteurTiersTelephone != null)
        'tuteur_tiers_telephone': tuteurTiersTelephone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TuteursCompanion copyWith({
    Value<String>? id,
    Value<String>? mineurId,
    Value<String>? lien,
    Value<String?>? tuteurFideleId,
    Value<String?>? tuteurTiersNom,
    Value<String?>? tuteurTiersTelephone,
    Value<int>? rowid,
  }) {
    return TuteursCompanion(
      id: id ?? this.id,
      mineurId: mineurId ?? this.mineurId,
      lien: lien ?? this.lien,
      tuteurFideleId: tuteurFideleId ?? this.tuteurFideleId,
      tuteurTiersNom: tuteurTiersNom ?? this.tuteurTiersNom,
      tuteurTiersTelephone: tuteurTiersTelephone ?? this.tuteurTiersTelephone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mineurId.present) {
      map['mineur_id'] = Variable<String>(mineurId.value);
    }
    if (lien.present) {
      map['lien'] = Variable<String>(lien.value);
    }
    if (tuteurFideleId.present) {
      map['tuteur_fidele_id'] = Variable<String>(tuteurFideleId.value);
    }
    if (tuteurTiersNom.present) {
      map['tuteur_tiers_nom'] = Variable<String>(tuteurTiersNom.value);
    }
    if (tuteurTiersTelephone.present) {
      map['tuteur_tiers_telephone'] = Variable<String>(
        tuteurTiersTelephone.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TuteursCompanion(')
          ..write('id: $id, ')
          ..write('mineurId: $mineurId, ')
          ..write('lien: $lien, ')
          ..write('tuteurFideleId: $tuteurFideleId, ')
          ..write('tuteurTiersNom: $tuteurTiersNom, ')
          ..write('tuteurTiersTelephone: $tuteurTiersTelephone, ')
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
  late final $FidelesTable fideles = $FidelesTable(this);
  late final $LiensFamiliauxTable liensFamiliaux = $LiensFamiliauxTable(this);
  late final $HistoriqueFidelesTable historiqueFideles =
      $HistoriqueFidelesTable(this);
  late final $TuteursTable tuteurs = $TuteursTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    organisationNodes,
    historiqueRattachements,
    fideles,
    liensFamiliaux,
    historiqueFideles,
    tuteurs,
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

final class $$OrganisationNodesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $OrganisationNodesTable,
          OrganisationNodeRow
        > {
  $$OrganisationNodesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$FidelesTable, List<FideleRow>> _fidelesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.fideles,
    aliasName: 'organisation_nodes__id__fideles__noeud_id',
  );

  $$FidelesTableProcessedTableManager get fidelesRefs {
    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.noeudId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fidelesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> fidelesRefs(
    Expression<bool> Function($$FidelesTableFilterComposer f) f,
  ) {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> fidelesRefs<T extends Object>(
    Expression<T> Function($$FidelesTableAnnotationComposer a) f,
  ) {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (OrganisationNodeRow, $$OrganisationNodesTableReferences),
          OrganisationNodeRow,
          PrefetchHooks Function({bool fidelesRefs})
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
              .map(
                (e) => (
                  e.readTable<$OrganisationNodesTable, OrganisationNodeRow>(
                    table,
                  ),
                  $$OrganisationNodesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fidelesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (fidelesRefs) db.fideles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fidelesRefs)
                    await $_getPrefetchedData<
                      OrganisationNodeRow,
                      $OrganisationNodesTable,
                      FideleRow
                    >(
                      currentTable: table,
                      referencedTable: $$OrganisationNodesTableReferences
                          ._fidelesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$OrganisationNodesTableReferences(
                            db,
                            table,
                            p0,
                          ).fidelesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.noeudId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (OrganisationNodeRow, $$OrganisationNodesTableReferences),
      OrganisationNodeRow,
      PrefetchHooks Function({bool fidelesRefs})
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
              .map(
                (e) => (
                  e.readTable<
                    $HistoriqueRattachementsTable,
                    HistoriqueRattachementRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $HistoriqueRattachementsTable,
                    HistoriqueRattachementRow
                  >(db, table, e),
                ),
              )
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
typedef $$FidelesTableCreateCompanionBuilder =
    FidelesCompanion Function({
      required String id,
      required String noeudId,
      required String nom,
      required String prenoms,
      required DateTime dateNaissance,
      required String sexe,
      required String statutCivil,
      Value<String> statutSpirituel,
      Value<String> statut,
      Value<DateTime?> dateConversion,
      Value<DateTime?> dateBapteme,
      Value<String?> egliseProvenance,
      Value<String?> photoUrl,
      Value<String?> telephone,
      Value<String?> email,
      Value<String?> adresse,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FidelesTableUpdateCompanionBuilder =
    FidelesCompanion Function({
      Value<String> id,
      Value<String> noeudId,
      Value<String> nom,
      Value<String> prenoms,
      Value<DateTime> dateNaissance,
      Value<String> sexe,
      Value<String> statutCivil,
      Value<String> statutSpirituel,
      Value<String> statut,
      Value<DateTime?> dateConversion,
      Value<DateTime?> dateBapteme,
      Value<String?> egliseProvenance,
      Value<String?> photoUrl,
      Value<String?> telephone,
      Value<String?> email,
      Value<String?> adresse,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FidelesTableReferences
    extends BaseReferences<_$AppDatabase, $FidelesTable, FideleRow> {
  $$FidelesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganisationNodesTable _noeudIdTable(_$AppDatabase db) => db
      .organisationNodes
      .createAlias('fideles__noeud_id__organisation_nodes__id');

  $$OrganisationNodesTableProcessedTableManager get noeudId {
    final $_column = $_itemColumn<String>('noeud_id')!;

    final manager = $$OrganisationNodesTableTableManager(
      $_db,
      $_db.organisationNodes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_noeudIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LiensFamiliauxTable, List<LienFamilialRow>>
  _liensCommeFidele1Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.liensFamiliaux,
    aliasName: 'fideles__id__liens_familiaux__fidele_id1',
  );

  $$LiensFamiliauxTableProcessedTableManager get liensCommeFidele1 {
    final manager = $$LiensFamiliauxTableTableManager(
      $_db,
      $_db.liensFamiliaux,
    ).filter((f) => f.fideleId1.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_liensCommeFidele1Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LiensFamiliauxTable, List<LienFamilialRow>>
  _liensCommeFidele2Table(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.liensFamiliaux,
    aliasName: 'fideles__id__liens_familiaux__fidele_id2',
  );

  $$LiensFamiliauxTableProcessedTableManager get liensCommeFidele2 {
    final manager = $$LiensFamiliauxTableTableManager(
      $_db,
      $_db.liensFamiliaux,
    ).filter((f) => f.fideleId2.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_liensCommeFidele2Table($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HistoriqueFidelesTable, List<HistoriqueFideleRow>>
  _historiqueFidelesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.historiqueFideles,
        aliasName: 'fideles__id__historique_fideles__fidele_id',
      );

  $$HistoriqueFidelesTableProcessedTableManager get historiqueFidelesRefs {
    final manager = $$HistoriqueFidelesTableTableManager(
      $_db,
      $_db.historiqueFideles,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _historiqueFidelesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TuteursTable, List<TuteurRow>>
  _tuteursCommeMineurTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tuteurs,
    aliasName: 'fideles__id__tuteurs__mineur_id',
  );

  $$TuteursTableProcessedTableManager get tuteursCommeMineur {
    final manager = $$TuteursTableTableManager(
      $_db,
      $_db.tuteurs,
    ).filter((f) => f.mineurId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tuteursCommeMineurTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TuteursTable, List<TuteurRow>>
  _tuteursCommeTuteurTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tuteurs,
    aliasName: 'fideles__id__tuteurs__tuteur_fidele_id',
  );

  $$TuteursTableProcessedTableManager get tuteursCommeTuteur {
    final manager = $$TuteursTableTableManager(
      $_db,
      $_db.tuteurs,
    ).filter((f) => f.tuteurFideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tuteursCommeTuteurTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FidelesTableFilterComposer
    extends Composer<_$AppDatabase, $FidelesTable> {
  $$FidelesTableFilterComposer({
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

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prenoms => $composableBuilder(
    column: $table.prenoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateNaissance => $composableBuilder(
    column: $table.dateNaissance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sexe => $composableBuilder(
    column: $table.sexe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statutCivil => $composableBuilder(
    column: $table.statutCivil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statutSpirituel => $composableBuilder(
    column: $table.statutSpirituel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateConversion => $composableBuilder(
    column: $table.dateConversion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateBapteme => $composableBuilder(
    column: $table.dateBapteme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get egliseProvenance => $composableBuilder(
    column: $table.egliseProvenance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adresse => $composableBuilder(
    column: $table.adresse,
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

  $$OrganisationNodesTableFilterComposer get noeudId {
    final $$OrganisationNodesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noeudId,
      referencedTable: $db.organisationNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganisationNodesTableFilterComposer(
            $db: $db,
            $table: $db.organisationNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> liensCommeFidele1(
    Expression<bool> Function($$LiensFamiliauxTableFilterComposer f) f,
  ) {
    final $$LiensFamiliauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liensFamiliaux,
      getReferencedColumn: (t) => t.fideleId1,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiensFamiliauxTableFilterComposer(
            $db: $db,
            $table: $db.liensFamiliaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> liensCommeFidele2(
    Expression<bool> Function($$LiensFamiliauxTableFilterComposer f) f,
  ) {
    final $$LiensFamiliauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liensFamiliaux,
      getReferencedColumn: (t) => t.fideleId2,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiensFamiliauxTableFilterComposer(
            $db: $db,
            $table: $db.liensFamiliaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> historiqueFidelesRefs(
    Expression<bool> Function($$HistoriqueFidelesTableFilterComposer f) f,
  ) {
    final $$HistoriqueFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.historiqueFideles,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistoriqueFidelesTableFilterComposer(
            $db: $db,
            $table: $db.historiqueFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tuteursCommeMineur(
    Expression<bool> Function($$TuteursTableFilterComposer f) f,
  ) {
    final $$TuteursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tuteurs,
      getReferencedColumn: (t) => t.mineurId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TuteursTableFilterComposer(
            $db: $db,
            $table: $db.tuteurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tuteursCommeTuteur(
    Expression<bool> Function($$TuteursTableFilterComposer f) f,
  ) {
    final $$TuteursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tuteurs,
      getReferencedColumn: (t) => t.tuteurFideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TuteursTableFilterComposer(
            $db: $db,
            $table: $db.tuteurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FidelesTableOrderingComposer
    extends Composer<_$AppDatabase, $FidelesTable> {
  $$FidelesTableOrderingComposer({
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

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prenoms => $composableBuilder(
    column: $table.prenoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateNaissance => $composableBuilder(
    column: $table.dateNaissance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sexe => $composableBuilder(
    column: $table.sexe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statutCivil => $composableBuilder(
    column: $table.statutCivil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statutSpirituel => $composableBuilder(
    column: $table.statutSpirituel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateConversion => $composableBuilder(
    column: $table.dateConversion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateBapteme => $composableBuilder(
    column: $table.dateBapteme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get egliseProvenance => $composableBuilder(
    column: $table.egliseProvenance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telephone => $composableBuilder(
    column: $table.telephone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adresse => $composableBuilder(
    column: $table.adresse,
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

  $$OrganisationNodesTableOrderingComposer get noeudId {
    final $$OrganisationNodesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noeudId,
      referencedTable: $db.organisationNodes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrganisationNodesTableOrderingComposer(
            $db: $db,
            $table: $db.organisationNodes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FidelesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FidelesTable> {
  $$FidelesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get prenoms =>
      $composableBuilder(column: $table.prenoms, builder: (column) => column);

  GeneratedColumn<DateTime> get dateNaissance => $composableBuilder(
    column: $table.dateNaissance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sexe =>
      $composableBuilder(column: $table.sexe, builder: (column) => column);

  GeneratedColumn<String> get statutCivil => $composableBuilder(
    column: $table.statutCivil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statutSpirituel => $composableBuilder(
    column: $table.statutSpirituel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<DateTime> get dateConversion => $composableBuilder(
    column: $table.dateConversion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateBapteme => $composableBuilder(
    column: $table.dateBapteme,
    builder: (column) => column,
  );

  GeneratedColumn<String> get egliseProvenance => $composableBuilder(
    column: $table.egliseProvenance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get telephone =>
      $composableBuilder(column: $table.telephone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get adresse =>
      $composableBuilder(column: $table.adresse, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OrganisationNodesTableAnnotationComposer get noeudId {
    final $$OrganisationNodesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.noeudId,
          referencedTable: $db.organisationNodes,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$OrganisationNodesTableAnnotationComposer(
                $db: $db,
                $table: $db.organisationNodes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> liensCommeFidele1<T extends Object>(
    Expression<T> Function($$LiensFamiliauxTableAnnotationComposer a) f,
  ) {
    final $$LiensFamiliauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liensFamiliaux,
      getReferencedColumn: (t) => t.fideleId1,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiensFamiliauxTableAnnotationComposer(
            $db: $db,
            $table: $db.liensFamiliaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> liensCommeFidele2<T extends Object>(
    Expression<T> Function($$LiensFamiliauxTableAnnotationComposer a) f,
  ) {
    final $$LiensFamiliauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.liensFamiliaux,
      getReferencedColumn: (t) => t.fideleId2,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LiensFamiliauxTableAnnotationComposer(
            $db: $db,
            $table: $db.liensFamiliaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> historiqueFidelesRefs<T extends Object>(
    Expression<T> Function($$HistoriqueFidelesTableAnnotationComposer a) f,
  ) {
    final $$HistoriqueFidelesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.historiqueFideles,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HistoriqueFidelesTableAnnotationComposer(
                $db: $db,
                $table: $db.historiqueFideles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> tuteursCommeMineur<T extends Object>(
    Expression<T> Function($$TuteursTableAnnotationComposer a) f,
  ) {
    final $$TuteursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tuteurs,
      getReferencedColumn: (t) => t.mineurId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TuteursTableAnnotationComposer(
            $db: $db,
            $table: $db.tuteurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tuteursCommeTuteur<T extends Object>(
    Expression<T> Function($$TuteursTableAnnotationComposer a) f,
  ) {
    final $$TuteursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tuteurs,
      getReferencedColumn: (t) => t.tuteurFideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TuteursTableAnnotationComposer(
            $db: $db,
            $table: $db.tuteurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FidelesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FidelesTable,
          FideleRow,
          $$FidelesTableFilterComposer,
          $$FidelesTableOrderingComposer,
          $$FidelesTableAnnotationComposer,
          $$FidelesTableCreateCompanionBuilder,
          $$FidelesTableUpdateCompanionBuilder,
          (FideleRow, $$FidelesTableReferences),
          FideleRow,
          PrefetchHooks Function({
            bool noeudId,
            bool liensCommeFidele1,
            bool liensCommeFidele2,
            bool historiqueFidelesRefs,
            bool tuteursCommeMineur,
            bool tuteursCommeTuteur,
          })
        > {
  $$FidelesTableTableManager(_$AppDatabase db, $FidelesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FidelesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FidelesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FidelesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> noeudId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> prenoms = const Value.absent(),
                Value<DateTime> dateNaissance = const Value.absent(),
                Value<String> sexe = const Value.absent(),
                Value<String> statutCivil = const Value.absent(),
                Value<String> statutSpirituel = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<DateTime?> dateConversion = const Value.absent(),
                Value<DateTime?> dateBapteme = const Value.absent(),
                Value<String?> egliseProvenance = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> telephone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> adresse = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FidelesCompanion(
                id: id,
                noeudId: noeudId,
                nom: nom,
                prenoms: prenoms,
                dateNaissance: dateNaissance,
                sexe: sexe,
                statutCivil: statutCivil,
                statutSpirituel: statutSpirituel,
                statut: statut,
                dateConversion: dateConversion,
                dateBapteme: dateBapteme,
                egliseProvenance: egliseProvenance,
                photoUrl: photoUrl,
                telephone: telephone,
                email: email,
                adresse: adresse,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String noeudId,
                required String nom,
                required String prenoms,
                required DateTime dateNaissance,
                required String sexe,
                required String statutCivil,
                Value<String> statutSpirituel = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<DateTime?> dateConversion = const Value.absent(),
                Value<DateTime?> dateBapteme = const Value.absent(),
                Value<String?> egliseProvenance = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> telephone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> adresse = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FidelesCompanion.insert(
                id: id,
                noeudId: noeudId,
                nom: nom,
                prenoms: prenoms,
                dateNaissance: dateNaissance,
                sexe: sexe,
                statutCivil: statutCivil,
                statutSpirituel: statutSpirituel,
                statut: statut,
                dateConversion: dateConversion,
                dateBapteme: dateBapteme,
                egliseProvenance: egliseProvenance,
                photoUrl: photoUrl,
                telephone: telephone,
                email: email,
                adresse: adresse,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FidelesTable, FideleRow>(table),
                  $$FidelesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                noeudId = false,
                liensCommeFidele1 = false,
                liensCommeFidele2 = false,
                historiqueFidelesRefs = false,
                tuteursCommeMineur = false,
                tuteursCommeTuteur = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (liensCommeFidele1) db.liensFamiliaux,
                    if (liensCommeFidele2) db.liensFamiliaux,
                    if (historiqueFidelesRefs) db.historiqueFideles,
                    if (tuteursCommeMineur) db.tuteurs,
                    if (tuteursCommeTuteur) db.tuteurs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (noeudId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.noeudId,
                                    referencedTable: $$FidelesTableReferences
                                        ._noeudIdTable(db),
                                    referencedColumn: $$FidelesTableReferences
                                        ._noeudIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (liensCommeFidele1)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          LienFamilialRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._liensCommeFidele1Table(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).liensCommeFidele1,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId1 == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (liensCommeFidele2)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          LienFamilialRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._liensCommeFidele2Table(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).liensCommeFidele2,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId2 == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (historiqueFidelesRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          HistoriqueFideleRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._historiqueFidelesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).historiqueFidelesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tuteursCommeMineur)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          TuteurRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._tuteursCommeMineurTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).tuteursCommeMineur,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mineurId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tuteursCommeTuteur)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          TuteurRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._tuteursCommeTuteurTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).tuteursCommeTuteur,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tuteurFideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FidelesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FidelesTable,
      FideleRow,
      $$FidelesTableFilterComposer,
      $$FidelesTableOrderingComposer,
      $$FidelesTableAnnotationComposer,
      $$FidelesTableCreateCompanionBuilder,
      $$FidelesTableUpdateCompanionBuilder,
      (FideleRow, $$FidelesTableReferences),
      FideleRow,
      PrefetchHooks Function({
        bool noeudId,
        bool liensCommeFidele1,
        bool liensCommeFidele2,
        bool historiqueFidelesRefs,
        bool tuteursCommeMineur,
        bool tuteursCommeTuteur,
      })
    >;
typedef $$LiensFamiliauxTableCreateCompanionBuilder =
    LiensFamiliauxCompanion Function({
      required String id,
      required String fideleId1,
      required String fideleId2,
      required String typeLien,
      Value<int> rowid,
    });
typedef $$LiensFamiliauxTableUpdateCompanionBuilder =
    LiensFamiliauxCompanion Function({
      Value<String> id,
      Value<String> fideleId1,
      Value<String> fideleId2,
      Value<String> typeLien,
      Value<int> rowid,
    });

final class $$LiensFamiliauxTableReferences
    extends
        BaseReferences<_$AppDatabase, $LiensFamiliauxTable, LienFamilialRow> {
  $$LiensFamiliauxTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FidelesTable _fideleId1Table(_$AppDatabase db) =>
      db.fideles.createAlias('liens_familiaux__fidele_id1__fideles__id');

  $$FidelesTableProcessedTableManager get fideleId1 {
    final $_column = $_itemColumn<String>('fidele_id1')!;

    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fideleId1Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _fideleId2Table(_$AppDatabase db) =>
      db.fideles.createAlias('liens_familiaux__fidele_id2__fideles__id');

  $$FidelesTableProcessedTableManager get fideleId2 {
    final $_column = $_itemColumn<String>('fidele_id2')!;

    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fideleId2Table($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LiensFamiliauxTableFilterComposer
    extends Composer<_$AppDatabase, $LiensFamiliauxTable> {
  $$LiensFamiliauxTableFilterComposer({
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

  ColumnFilters<String> get typeLien => $composableBuilder(
    column: $table.typeLien,
    builder: (column) => ColumnFilters(column),
  );

  $$FidelesTableFilterComposer get fideleId1 {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId1,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableFilterComposer get fideleId2 {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId2,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LiensFamiliauxTableOrderingComposer
    extends Composer<_$AppDatabase, $LiensFamiliauxTable> {
  $$LiensFamiliauxTableOrderingComposer({
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

  ColumnOrderings<String> get typeLien => $composableBuilder(
    column: $table.typeLien,
    builder: (column) => ColumnOrderings(column),
  );

  $$FidelesTableOrderingComposer get fideleId1 {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId1,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableOrderingComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableOrderingComposer get fideleId2 {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId2,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableOrderingComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LiensFamiliauxTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiensFamiliauxTable> {
  $$LiensFamiliauxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get typeLien =>
      $composableBuilder(column: $table.typeLien, builder: (column) => column);

  $$FidelesTableAnnotationComposer get fideleId1 {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId1,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableAnnotationComposer get fideleId2 {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId2,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LiensFamiliauxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LiensFamiliauxTable,
          LienFamilialRow,
          $$LiensFamiliauxTableFilterComposer,
          $$LiensFamiliauxTableOrderingComposer,
          $$LiensFamiliauxTableAnnotationComposer,
          $$LiensFamiliauxTableCreateCompanionBuilder,
          $$LiensFamiliauxTableUpdateCompanionBuilder,
          (LienFamilialRow, $$LiensFamiliauxTableReferences),
          LienFamilialRow,
          PrefetchHooks Function({bool fideleId1, bool fideleId2})
        > {
  $$LiensFamiliauxTableTableManager(
    _$AppDatabase db,
    $LiensFamiliauxTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiensFamiliauxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiensFamiliauxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiensFamiliauxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId1 = const Value.absent(),
                Value<String> fideleId2 = const Value.absent(),
                Value<String> typeLien = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiensFamiliauxCompanion(
                id: id,
                fideleId1: fideleId1,
                fideleId2: fideleId2,
                typeLien: typeLien,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId1,
                required String fideleId2,
                required String typeLien,
                Value<int> rowid = const Value.absent(),
              }) => LiensFamiliauxCompanion.insert(
                id: id,
                fideleId1: fideleId1,
                fideleId2: fideleId2,
                typeLien: typeLien,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LiensFamiliauxTable, LienFamilialRow>(table),
                  $$LiensFamiliauxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fideleId1 = false, fideleId2 = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fideleId1) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId1,
                                referencedTable: $$LiensFamiliauxTableReferences
                                    ._fideleId1Table(db),
                                referencedColumn:
                                    $$LiensFamiliauxTableReferences
                                        ._fideleId1Table(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fideleId2) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId2,
                                referencedTable: $$LiensFamiliauxTableReferences
                                    ._fideleId2Table(db),
                                referencedColumn:
                                    $$LiensFamiliauxTableReferences
                                        ._fideleId2Table(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LiensFamiliauxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LiensFamiliauxTable,
      LienFamilialRow,
      $$LiensFamiliauxTableFilterComposer,
      $$LiensFamiliauxTableOrderingComposer,
      $$LiensFamiliauxTableAnnotationComposer,
      $$LiensFamiliauxTableCreateCompanionBuilder,
      $$LiensFamiliauxTableUpdateCompanionBuilder,
      (LienFamilialRow, $$LiensFamiliauxTableReferences),
      LienFamilialRow,
      PrefetchHooks Function({bool fideleId1, bool fideleId2})
    >;
typedef $$HistoriqueFidelesTableCreateCompanionBuilder =
    HistoriqueFidelesCompanion Function({
      required String id,
      required String fideleId,
      required String champModifie,
      Value<String?> ancienneValeur,
      Value<String?> nouvelleValeur,
      Value<String?> auteurFideleId,
      required DateTime date,
      Value<int> rowid,
    });
typedef $$HistoriqueFidelesTableUpdateCompanionBuilder =
    HistoriqueFidelesCompanion Function({
      Value<String> id,
      Value<String> fideleId,
      Value<String> champModifie,
      Value<String?> ancienneValeur,
      Value<String?> nouvelleValeur,
      Value<String?> auteurFideleId,
      Value<DateTime> date,
      Value<int> rowid,
    });

final class $$HistoriqueFidelesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HistoriqueFidelesTable,
          HistoriqueFideleRow
        > {
  $$HistoriqueFidelesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('historique_fideles__fidele_id__fideles__id');

  $$FidelesTableProcessedTableManager get fideleId {
    final $_column = $_itemColumn<String>('fidele_id')!;

    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fideleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HistoriqueFidelesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoriqueFidelesTable> {
  $$HistoriqueFidelesTableFilterComposer({
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

  ColumnFilters<String> get champModifie => $composableBuilder(
    column: $table.champModifie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ancienneValeur => $composableBuilder(
    column: $table.ancienneValeur,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nouvelleValeur => $composableBuilder(
    column: $table.nouvelleValeur,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get auteurFideleId => $composableBuilder(
    column: $table.auteurFideleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$FidelesTableFilterComposer get fideleId {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoriqueFidelesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoriqueFidelesTable> {
  $$HistoriqueFidelesTableOrderingComposer({
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

  ColumnOrderings<String> get champModifie => $composableBuilder(
    column: $table.champModifie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ancienneValeur => $composableBuilder(
    column: $table.ancienneValeur,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nouvelleValeur => $composableBuilder(
    column: $table.nouvelleValeur,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get auteurFideleId => $composableBuilder(
    column: $table.auteurFideleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$FidelesTableOrderingComposer get fideleId {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableOrderingComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoriqueFidelesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoriqueFidelesTable> {
  $$HistoriqueFidelesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get champModifie => $composableBuilder(
    column: $table.champModifie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ancienneValeur => $composableBuilder(
    column: $table.ancienneValeur,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nouvelleValeur => $composableBuilder(
    column: $table.nouvelleValeur,
    builder: (column) => column,
  );

  GeneratedColumn<String> get auteurFideleId => $composableBuilder(
    column: $table.auteurFideleId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$FidelesTableAnnotationComposer get fideleId {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoriqueFidelesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoriqueFidelesTable,
          HistoriqueFideleRow,
          $$HistoriqueFidelesTableFilterComposer,
          $$HistoriqueFidelesTableOrderingComposer,
          $$HistoriqueFidelesTableAnnotationComposer,
          $$HistoriqueFidelesTableCreateCompanionBuilder,
          $$HistoriqueFidelesTableUpdateCompanionBuilder,
          (HistoriqueFideleRow, $$HistoriqueFidelesTableReferences),
          HistoriqueFideleRow,
          PrefetchHooks Function({bool fideleId})
        > {
  $$HistoriqueFidelesTableTableManager(
    _$AppDatabase db,
    $HistoriqueFidelesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoriqueFidelesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoriqueFidelesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoriqueFidelesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> champModifie = const Value.absent(),
                Value<String?> ancienneValeur = const Value.absent(),
                Value<String?> nouvelleValeur = const Value.absent(),
                Value<String?> auteurFideleId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistoriqueFidelesCompanion(
                id: id,
                fideleId: fideleId,
                champModifie: champModifie,
                ancienneValeur: ancienneValeur,
                nouvelleValeur: nouvelleValeur,
                auteurFideleId: auteurFideleId,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId,
                required String champModifie,
                Value<String?> ancienneValeur = const Value.absent(),
                Value<String?> nouvelleValeur = const Value.absent(),
                Value<String?> auteurFideleId = const Value.absent(),
                required DateTime date,
                Value<int> rowid = const Value.absent(),
              }) => HistoriqueFidelesCompanion.insert(
                id: id,
                fideleId: fideleId,
                champModifie: champModifie,
                ancienneValeur: ancienneValeur,
                nouvelleValeur: nouvelleValeur,
                auteurFideleId: auteurFideleId,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HistoriqueFidelesTable, HistoriqueFideleRow>(
                    table,
                  ),
                  $$HistoriqueFidelesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fideleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fideleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId,
                                referencedTable:
                                    $$HistoriqueFidelesTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$HistoriqueFidelesTableReferences
                                        ._fideleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HistoriqueFidelesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoriqueFidelesTable,
      HistoriqueFideleRow,
      $$HistoriqueFidelesTableFilterComposer,
      $$HistoriqueFidelesTableOrderingComposer,
      $$HistoriqueFidelesTableAnnotationComposer,
      $$HistoriqueFidelesTableCreateCompanionBuilder,
      $$HistoriqueFidelesTableUpdateCompanionBuilder,
      (HistoriqueFideleRow, $$HistoriqueFidelesTableReferences),
      HistoriqueFideleRow,
      PrefetchHooks Function({bool fideleId})
    >;
typedef $$TuteursTableCreateCompanionBuilder =
    TuteursCompanion Function({
      required String id,
      required String mineurId,
      required String lien,
      Value<String?> tuteurFideleId,
      Value<String?> tuteurTiersNom,
      Value<String?> tuteurTiersTelephone,
      Value<int> rowid,
    });
typedef $$TuteursTableUpdateCompanionBuilder =
    TuteursCompanion Function({
      Value<String> id,
      Value<String> mineurId,
      Value<String> lien,
      Value<String?> tuteurFideleId,
      Value<String?> tuteurTiersNom,
      Value<String?> tuteurTiersTelephone,
      Value<int> rowid,
    });

final class $$TuteursTableReferences
    extends BaseReferences<_$AppDatabase, $TuteursTable, TuteurRow> {
  $$TuteursTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FidelesTable _mineurIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('tuteurs__mineur_id__fideles__id');

  $$FidelesTableProcessedTableManager get mineurId {
    final $_column = $_itemColumn<String>('mineur_id')!;

    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mineurIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _tuteurFideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('tuteurs__tuteur_fidele_id__fideles__id');

  $$FidelesTableProcessedTableManager? get tuteurFideleId {
    final $_column = $_itemColumn<String>('tuteur_fidele_id');
    if ($_column == null) return null;
    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tuteurFideleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TuteursTableFilterComposer
    extends Composer<_$AppDatabase, $TuteursTable> {
  $$TuteursTableFilterComposer({
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

  ColumnFilters<String> get lien => $composableBuilder(
    column: $table.lien,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tuteurTiersNom => $composableBuilder(
    column: $table.tuteurTiersNom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tuteurTiersTelephone => $composableBuilder(
    column: $table.tuteurTiersTelephone,
    builder: (column) => ColumnFilters(column),
  );

  $$FidelesTableFilterComposer get mineurId {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mineurId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableFilterComposer get tuteurFideleId {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tuteurFideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableFilterComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TuteursTableOrderingComposer
    extends Composer<_$AppDatabase, $TuteursTable> {
  $$TuteursTableOrderingComposer({
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

  ColumnOrderings<String> get lien => $composableBuilder(
    column: $table.lien,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tuteurTiersNom => $composableBuilder(
    column: $table.tuteurTiersNom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tuteurTiersTelephone => $composableBuilder(
    column: $table.tuteurTiersTelephone,
    builder: (column) => ColumnOrderings(column),
  );

  $$FidelesTableOrderingComposer get mineurId {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mineurId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableOrderingComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableOrderingComposer get tuteurFideleId {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tuteurFideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableOrderingComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TuteursTableAnnotationComposer
    extends Composer<_$AppDatabase, $TuteursTable> {
  $$TuteursTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lien =>
      $composableBuilder(column: $table.lien, builder: (column) => column);

  GeneratedColumn<String> get tuteurTiersNom => $composableBuilder(
    column: $table.tuteurTiersNom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tuteurTiersTelephone => $composableBuilder(
    column: $table.tuteurTiersTelephone,
    builder: (column) => column,
  );

  $$FidelesTableAnnotationComposer get mineurId {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mineurId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableAnnotationComposer get tuteurFideleId {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tuteurFideleId,
      referencedTable: $db.fideles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.fideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TuteursTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TuteursTable,
          TuteurRow,
          $$TuteursTableFilterComposer,
          $$TuteursTableOrderingComposer,
          $$TuteursTableAnnotationComposer,
          $$TuteursTableCreateCompanionBuilder,
          $$TuteursTableUpdateCompanionBuilder,
          (TuteurRow, $$TuteursTableReferences),
          TuteurRow,
          PrefetchHooks Function({bool mineurId, bool tuteurFideleId})
        > {
  $$TuteursTableTableManager(_$AppDatabase db, $TuteursTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TuteursTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TuteursTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TuteursTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mineurId = const Value.absent(),
                Value<String> lien = const Value.absent(),
                Value<String?> tuteurFideleId = const Value.absent(),
                Value<String?> tuteurTiersNom = const Value.absent(),
                Value<String?> tuteurTiersTelephone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TuteursCompanion(
                id: id,
                mineurId: mineurId,
                lien: lien,
                tuteurFideleId: tuteurFideleId,
                tuteurTiersNom: tuteurTiersNom,
                tuteurTiersTelephone: tuteurTiersTelephone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mineurId,
                required String lien,
                Value<String?> tuteurFideleId = const Value.absent(),
                Value<String?> tuteurTiersNom = const Value.absent(),
                Value<String?> tuteurTiersTelephone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TuteursCompanion.insert(
                id: id,
                mineurId: mineurId,
                lien: lien,
                tuteurFideleId: tuteurFideleId,
                tuteurTiersNom: tuteurTiersNom,
                tuteurTiersTelephone: tuteurTiersTelephone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TuteursTable, TuteurRow>(table),
                  $$TuteursTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mineurId = false, tuteurFideleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mineurId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mineurId,
                                referencedTable: $$TuteursTableReferences
                                    ._mineurIdTable(db),
                                referencedColumn: $$TuteursTableReferences
                                    ._mineurIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tuteurFideleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tuteurFideleId,
                                referencedTable: $$TuteursTableReferences
                                    ._tuteurFideleIdTable(db),
                                referencedColumn: $$TuteursTableReferences
                                    ._tuteurFideleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TuteursTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TuteursTable,
      TuteurRow,
      $$TuteursTableFilterComposer,
      $$TuteursTableOrderingComposer,
      $$TuteursTableAnnotationComposer,
      $$TuteursTableCreateCompanionBuilder,
      $$TuteursTableUpdateCompanionBuilder,
      (TuteurRow, $$TuteursTableReferences),
      TuteurRow,
      PrefetchHooks Function({bool mineurId, bool tuteurFideleId})
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
              .map(
                (e) => (
                  e.readTable<$SyncOutboxTable, SyncOutboxRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncOutboxTable,
                    SyncOutboxRow
                  >(db, table, e),
                ),
              )
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
  $$FidelesTableTableManager get fideles =>
      $$FidelesTableTableManager(_db, _db.fideles);
  $$LiensFamiliauxTableTableManager get liensFamiliaux =>
      $$LiensFamiliauxTableTableManager(_db, _db.liensFamiliaux);
  $$HistoriqueFidelesTableTableManager get historiqueFideles =>
      $$HistoriqueFidelesTableTableManager(_db, _db.historiqueFideles);
  $$TuteursTableTableManager get tuteurs =>
      $$TuteursTableTableManager(_db, _db.tuteurs);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
}
