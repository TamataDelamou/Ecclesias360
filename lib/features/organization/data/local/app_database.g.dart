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

class $NodeResponsablesTable extends NodeResponsables
    with TableInfo<$NodeResponsablesTable, NodeResponsableRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NodeResponsablesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fonctionMeta = const VerificationMeta(
    'fonction',
  );
  @override
  late final GeneratedColumn<String> fonction = GeneratedColumn<String>(
    'fonction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDebutMeta = const VerificationMeta(
    'dateDebut',
  );
  @override
  late final GeneratedColumn<DateTime> dateDebut = GeneratedColumn<DateTime>(
    'date_debut',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFinMeta = const VerificationMeta(
    'dateFin',
  );
  @override
  late final GeneratedColumn<DateTime> dateFin = GeneratedColumn<DateTime>(
    'date_fin',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    noeudId,
    fideleId,
    fonction,
    dateDebut,
    dateFin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'node_responsables';
  @override
  VerificationContext validateIntegrity(
    Insertable<NodeResponsableRow> instance, {
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
    if (data.containsKey('fidele_id')) {
      context.handle(
        _fideleIdMeta,
        fideleId.isAcceptableOrUnknown(data['fidele_id']!, _fideleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fideleIdMeta);
    }
    if (data.containsKey('fonction')) {
      context.handle(
        _fonctionMeta,
        fonction.isAcceptableOrUnknown(data['fonction']!, _fonctionMeta),
      );
    } else if (isInserting) {
      context.missing(_fonctionMeta);
    }
    if (data.containsKey('date_debut')) {
      context.handle(
        _dateDebutMeta,
        dateDebut.isAcceptableOrUnknown(data['date_debut']!, _dateDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateDebutMeta);
    }
    if (data.containsKey('date_fin')) {
      context.handle(
        _dateFinMeta,
        dateFin.isAcceptableOrUnknown(data['date_fin']!, _dateFinMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NodeResponsableRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NodeResponsableRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      noeudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}noeud_id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      fonction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fonction'],
      )!,
      dateDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_debut'],
      )!,
      dateFin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fin'],
      ),
    );
  }

  @override
  $NodeResponsablesTable createAlias(String alias) {
    return $NodeResponsablesTable(attachedDatabase, alias);
  }
}

class NodeResponsableRow extends DataClass
    implements Insertable<NodeResponsableRow> {
  final String id;
  final String noeudId;
  final String fideleId;
  final String fonction;
  final DateTime dateDebut;
  final DateTime? dateFin;
  const NodeResponsableRow({
    required this.id,
    required this.noeudId,
    required this.fideleId,
    required this.fonction,
    required this.dateDebut,
    this.dateFin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['noeud_id'] = Variable<String>(noeudId);
    map['fidele_id'] = Variable<String>(fideleId);
    map['fonction'] = Variable<String>(fonction);
    map['date_debut'] = Variable<DateTime>(dateDebut);
    if (!nullToAbsent || dateFin != null) {
      map['date_fin'] = Variable<DateTime>(dateFin);
    }
    return map;
  }

  NodeResponsablesCompanion toCompanion(bool nullToAbsent) {
    return NodeResponsablesCompanion(
      id: Value(id),
      noeudId: Value(noeudId),
      fideleId: Value(fideleId),
      fonction: Value(fonction),
      dateDebut: Value(dateDebut),
      dateFin: dateFin == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFin),
    );
  }

  factory NodeResponsableRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NodeResponsableRow(
      id: serializer.fromJson<String>(json['id']),
      noeudId: serializer.fromJson<String>(json['noeudId']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      fonction: serializer.fromJson<String>(json['fonction']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      dateFin: serializer.fromJson<DateTime?>(json['dateFin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'noeudId': serializer.toJson<String>(noeudId),
      'fideleId': serializer.toJson<String>(fideleId),
      'fonction': serializer.toJson<String>(fonction),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'dateFin': serializer.toJson<DateTime?>(dateFin),
    };
  }

  NodeResponsableRow copyWith({
    String? id,
    String? noeudId,
    String? fideleId,
    String? fonction,
    DateTime? dateDebut,
    Value<DateTime?> dateFin = const Value.absent(),
  }) => NodeResponsableRow(
    id: id ?? this.id,
    noeudId: noeudId ?? this.noeudId,
    fideleId: fideleId ?? this.fideleId,
    fonction: fonction ?? this.fonction,
    dateDebut: dateDebut ?? this.dateDebut,
    dateFin: dateFin.present ? dateFin.value : this.dateFin,
  );
  NodeResponsableRow copyWithCompanion(NodeResponsablesCompanion data) {
    return NodeResponsableRow(
      id: data.id.present ? data.id.value : this.id,
      noeudId: data.noeudId.present ? data.noeudId.value : this.noeudId,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      fonction: data.fonction.present ? data.fonction.value : this.fonction,
      dateDebut: data.dateDebut.present ? data.dateDebut.value : this.dateDebut,
      dateFin: data.dateFin.present ? data.dateFin.value : this.dateFin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NodeResponsableRow(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('fideleId: $fideleId, ')
          ..write('fonction: $fonction, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noeudId, fideleId, fonction, dateDebut, dateFin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NodeResponsableRow &&
          other.id == this.id &&
          other.noeudId == this.noeudId &&
          other.fideleId == this.fideleId &&
          other.fonction == this.fonction &&
          other.dateDebut == this.dateDebut &&
          other.dateFin == this.dateFin);
}

class NodeResponsablesCompanion extends UpdateCompanion<NodeResponsableRow> {
  final Value<String> id;
  final Value<String> noeudId;
  final Value<String> fideleId;
  final Value<String> fonction;
  final Value<DateTime> dateDebut;
  final Value<DateTime?> dateFin;
  final Value<int> rowid;
  const NodeResponsablesCompanion({
    this.id = const Value.absent(),
    this.noeudId = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.fonction = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NodeResponsablesCompanion.insert({
    required String id,
    required String noeudId,
    required String fideleId,
    required String fonction,
    required DateTime dateDebut,
    this.dateFin = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       noeudId = Value(noeudId),
       fideleId = Value(fideleId),
       fonction = Value(fonction),
       dateDebut = Value(dateDebut);
  static Insertable<NodeResponsableRow> custom({
    Expression<String>? id,
    Expression<String>? noeudId,
    Expression<String>? fideleId,
    Expression<String>? fonction,
    Expression<DateTime>? dateDebut,
    Expression<DateTime>? dateFin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noeudId != null) 'noeud_id': noeudId,
      if (fideleId != null) 'fidele_id': fideleId,
      if (fonction != null) 'fonction': fonction,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (dateFin != null) 'date_fin': dateFin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NodeResponsablesCompanion copyWith({
    Value<String>? id,
    Value<String>? noeudId,
    Value<String>? fideleId,
    Value<String>? fonction,
    Value<DateTime>? dateDebut,
    Value<DateTime?>? dateFin,
    Value<int>? rowid,
  }) {
    return NodeResponsablesCompanion(
      id: id ?? this.id,
      noeudId: noeudId ?? this.noeudId,
      fideleId: fideleId ?? this.fideleId,
      fonction: fonction ?? this.fonction,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
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
    if (fideleId.present) {
      map['fidele_id'] = Variable<String>(fideleId.value);
    }
    if (fonction.present) {
      map['fonction'] = Variable<String>(fonction.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (dateFin.present) {
      map['date_fin'] = Variable<DateTime>(dateFin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NodeResponsablesCompanion(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('fideleId: $fideleId, ')
          ..write('fonction: $fonction, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
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

class $ZonesGeographiquesTable extends ZonesGeographiques
    with TableInfo<$ZonesGeographiquesTable, ZoneGeographiqueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZonesGeographiquesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<int> niveau = GeneratedColumn<int>(
    'niveau',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES zones_geographiques (id)',
    ),
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
  @override
  List<GeneratedColumn> get $columns => [id, libelle, niveau, parentId, statut];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zones_geographiques';
  @override
  VerificationContext validateIntegrity(
    Insertable<ZoneGeographiqueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('niveau')) {
      context.handle(
        _niveauMeta,
        niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta),
      );
    } else if (isInserting) {
      context.missing(_niveauMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZoneGeographiqueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZoneGeographiqueRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      niveau: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}niveau'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $ZonesGeographiquesTable createAlias(String alias) {
    return $ZonesGeographiquesTable(attachedDatabase, alias);
  }
}

class ZoneGeographiqueRow extends DataClass
    implements Insertable<ZoneGeographiqueRow> {
  final String id;
  final String libelle;
  final int niveau;
  final String? parentId;
  final String statut;
  const ZoneGeographiqueRow({
    required this.id,
    required this.libelle,
    required this.niveau,
    this.parentId,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['libelle'] = Variable<String>(libelle);
    map['niveau'] = Variable<int>(niveau);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['statut'] = Variable<String>(statut);
    return map;
  }

  ZonesGeographiquesCompanion toCompanion(bool nullToAbsent) {
    return ZonesGeographiquesCompanion(
      id: Value(id),
      libelle: Value(libelle),
      niveau: Value(niveau),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      statut: Value(statut),
    );
  }

  factory ZoneGeographiqueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZoneGeographiqueRow(
      id: serializer.fromJson<String>(json['id']),
      libelle: serializer.fromJson<String>(json['libelle']),
      niveau: serializer.fromJson<int>(json['niveau']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'libelle': serializer.toJson<String>(libelle),
      'niveau': serializer.toJson<int>(niveau),
      'parentId': serializer.toJson<String?>(parentId),
      'statut': serializer.toJson<String>(statut),
    };
  }

  ZoneGeographiqueRow copyWith({
    String? id,
    String? libelle,
    int? niveau,
    Value<String?> parentId = const Value.absent(),
    String? statut,
  }) => ZoneGeographiqueRow(
    id: id ?? this.id,
    libelle: libelle ?? this.libelle,
    niveau: niveau ?? this.niveau,
    parentId: parentId.present ? parentId.value : this.parentId,
    statut: statut ?? this.statut,
  );
  ZoneGeographiqueRow copyWithCompanion(ZonesGeographiquesCompanion data) {
    return ZoneGeographiqueRow(
      id: data.id.present ? data.id.value : this.id,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ZoneGeographiqueRow(')
          ..write('id: $id, ')
          ..write('libelle: $libelle, ')
          ..write('niveau: $niveau, ')
          ..write('parentId: $parentId, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, libelle, niveau, parentId, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZoneGeographiqueRow &&
          other.id == this.id &&
          other.libelle == this.libelle &&
          other.niveau == this.niveau &&
          other.parentId == this.parentId &&
          other.statut == this.statut);
}

class ZonesGeographiquesCompanion extends UpdateCompanion<ZoneGeographiqueRow> {
  final Value<String> id;
  final Value<String> libelle;
  final Value<int> niveau;
  final Value<String?> parentId;
  final Value<String> statut;
  final Value<int> rowid;
  const ZonesGeographiquesCompanion({
    this.id = const Value.absent(),
    this.libelle = const Value.absent(),
    this.niveau = const Value.absent(),
    this.parentId = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ZonesGeographiquesCompanion.insert({
    required String id,
    required String libelle,
    required int niveau,
    this.parentId = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       libelle = Value(libelle),
       niveau = Value(niveau);
  static Insertable<ZoneGeographiqueRow> custom({
    Expression<String>? id,
    Expression<String>? libelle,
    Expression<int>? niveau,
    Expression<String>? parentId,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (libelle != null) 'libelle': libelle,
      if (niveau != null) 'niveau': niveau,
      if (parentId != null) 'parent_id': parentId,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ZonesGeographiquesCompanion copyWith({
    Value<String>? id,
    Value<String>? libelle,
    Value<int>? niveau,
    Value<String?>? parentId,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return ZonesGeographiquesCompanion(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
      niveau: niveau ?? this.niveau,
      parentId: parentId ?? this.parentId,
      statut: statut ?? this.statut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<int>(niveau.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZonesGeographiquesCompanion(')
          ..write('id: $id, ')
          ..write('libelle: $libelle, ')
          ..write('niveau: $niveau, ')
          ..write('parentId: $parentId, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TypesMinisteresTable extends TypesMinisteres
    with TableInfo<$TypesMinisteresTable, TypeMinistereRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesMinisteresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _standardMeta = const VerificationMeta(
    'standard',
  );
  @override
  late final GeneratedColumn<bool> standard = GeneratedColumn<bool>(
    'standard',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("standard" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  @override
  List<GeneratedColumn> get $columns => [id, code, libelle, standard, statut];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'types_ministeres';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeMinistereRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('standard')) {
      context.handle(
        _standardMeta,
        standard.isAcceptableOrUnknown(data['standard']!, _standardMeta),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeMinistereRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeMinistereRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      standard: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}standard'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $TypesMinisteresTable createAlias(String alias) {
    return $TypesMinisteresTable(attachedDatabase, alias);
  }
}

class TypeMinistereRow extends DataClass
    implements Insertable<TypeMinistereRow> {
  final String id;
  final String code;
  final String libelle;
  final bool standard;
  final String statut;
  const TypeMinistereRow({
    required this.id,
    required this.code,
    required this.libelle,
    required this.standard,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['libelle'] = Variable<String>(libelle);
    map['standard'] = Variable<bool>(standard);
    map['statut'] = Variable<String>(statut);
    return map;
  }

  TypesMinisteresCompanion toCompanion(bool nullToAbsent) {
    return TypesMinisteresCompanion(
      id: Value(id),
      code: Value(code),
      libelle: Value(libelle),
      standard: Value(standard),
      statut: Value(statut),
    );
  }

  factory TypeMinistereRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeMinistereRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      libelle: serializer.fromJson<String>(json['libelle']),
      standard: serializer.fromJson<bool>(json['standard']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'libelle': serializer.toJson<String>(libelle),
      'standard': serializer.toJson<bool>(standard),
      'statut': serializer.toJson<String>(statut),
    };
  }

  TypeMinistereRow copyWith({
    String? id,
    String? code,
    String? libelle,
    bool? standard,
    String? statut,
  }) => TypeMinistereRow(
    id: id ?? this.id,
    code: code ?? this.code,
    libelle: libelle ?? this.libelle,
    standard: standard ?? this.standard,
    statut: statut ?? this.statut,
  );
  TypeMinistereRow copyWithCompanion(TypesMinisteresCompanion data) {
    return TypeMinistereRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      standard: data.standard.present ? data.standard.value : this.standard,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeMinistereRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('standard: $standard, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, libelle, standard, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeMinistereRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.libelle == this.libelle &&
          other.standard == this.standard &&
          other.statut == this.statut);
}

class TypesMinisteresCompanion extends UpdateCompanion<TypeMinistereRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> libelle;
  final Value<bool> standard;
  final Value<String> statut;
  final Value<int> rowid;
  const TypesMinisteresCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.libelle = const Value.absent(),
    this.standard = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TypesMinisteresCompanion.insert({
    required String id,
    required String code,
    required String libelle,
    this.standard = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       libelle = Value(libelle);
  static Insertable<TypeMinistereRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? libelle,
    Expression<bool>? standard,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (libelle != null) 'libelle': libelle,
      if (standard != null) 'standard': standard,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TypesMinisteresCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? libelle,
    Value<bool>? standard,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return TypesMinisteresCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
      standard: standard ?? this.standard,
      statut: statut ?? this.statut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (standard.present) {
      map['standard'] = Variable<bool>(standard.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesMinisteresCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('standard: $standard, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MinisteresTable extends Ministeres
    with TableInfo<$MinisteresTable, MinistereRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MinisteresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMinistereIdMeta = const VerificationMeta(
    'typeMinistereId',
  );
  @override
  late final GeneratedColumn<String> typeMinistereId = GeneratedColumn<String>(
    'type_ministere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types_ministeres (id)',
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
  static const VerificationMeta _dateCreationMeta = const VerificationMeta(
    'dateCreation',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreation = GeneratedColumn<DateTime>(
    'date_creation',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
    defaultValue: const Constant('actif'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    noeudId,
    typeMinistereId,
    nom,
    dateCreation,
    statut,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ministeres';
  @override
  VerificationContext validateIntegrity(
    Insertable<MinistereRow> instance, {
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
    if (data.containsKey('type_ministere_id')) {
      context.handle(
        _typeMinistereIdMeta,
        typeMinistereId.isAcceptableOrUnknown(
          data['type_ministere_id']!,
          _typeMinistereIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_typeMinistereIdMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('date_creation')) {
      context.handle(
        _dateCreationMeta,
        dateCreation.isAcceptableOrUnknown(
          data['date_creation']!,
          _dateCreationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateCreationMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MinistereRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MinistereRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      noeudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}noeud_id'],
      )!,
      typeMinistereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_ministere_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      dateCreation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_creation'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $MinisteresTable createAlias(String alias) {
    return $MinisteresTable(attachedDatabase, alias);
  }
}

class MinistereRow extends DataClass implements Insertable<MinistereRow> {
  final String id;
  final String noeudId;
  final String typeMinistereId;
  final String nom;
  final DateTime dateCreation;
  final String statut;
  const MinistereRow({
    required this.id,
    required this.noeudId,
    required this.typeMinistereId,
    required this.nom,
    required this.dateCreation,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['noeud_id'] = Variable<String>(noeudId);
    map['type_ministere_id'] = Variable<String>(typeMinistereId);
    map['nom'] = Variable<String>(nom);
    map['date_creation'] = Variable<DateTime>(dateCreation);
    map['statut'] = Variable<String>(statut);
    return map;
  }

  MinisteresCompanion toCompanion(bool nullToAbsent) {
    return MinisteresCompanion(
      id: Value(id),
      noeudId: Value(noeudId),
      typeMinistereId: Value(typeMinistereId),
      nom: Value(nom),
      dateCreation: Value(dateCreation),
      statut: Value(statut),
    );
  }

  factory MinistereRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MinistereRow(
      id: serializer.fromJson<String>(json['id']),
      noeudId: serializer.fromJson<String>(json['noeudId']),
      typeMinistereId: serializer.fromJson<String>(json['typeMinistereId']),
      nom: serializer.fromJson<String>(json['nom']),
      dateCreation: serializer.fromJson<DateTime>(json['dateCreation']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'noeudId': serializer.toJson<String>(noeudId),
      'typeMinistereId': serializer.toJson<String>(typeMinistereId),
      'nom': serializer.toJson<String>(nom),
      'dateCreation': serializer.toJson<DateTime>(dateCreation),
      'statut': serializer.toJson<String>(statut),
    };
  }

  MinistereRow copyWith({
    String? id,
    String? noeudId,
    String? typeMinistereId,
    String? nom,
    DateTime? dateCreation,
    String? statut,
  }) => MinistereRow(
    id: id ?? this.id,
    noeudId: noeudId ?? this.noeudId,
    typeMinistereId: typeMinistereId ?? this.typeMinistereId,
    nom: nom ?? this.nom,
    dateCreation: dateCreation ?? this.dateCreation,
    statut: statut ?? this.statut,
  );
  MinistereRow copyWithCompanion(MinisteresCompanion data) {
    return MinistereRow(
      id: data.id.present ? data.id.value : this.id,
      noeudId: data.noeudId.present ? data.noeudId.value : this.noeudId,
      typeMinistereId: data.typeMinistereId.present
          ? data.typeMinistereId.value
          : this.typeMinistereId,
      nom: data.nom.present ? data.nom.value : this.nom,
      dateCreation: data.dateCreation.present
          ? data.dateCreation.value
          : this.dateCreation,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MinistereRow(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('typeMinistereId: $typeMinistereId, ')
          ..write('nom: $nom, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noeudId, typeMinistereId, nom, dateCreation, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MinistereRow &&
          other.id == this.id &&
          other.noeudId == this.noeudId &&
          other.typeMinistereId == this.typeMinistereId &&
          other.nom == this.nom &&
          other.dateCreation == this.dateCreation &&
          other.statut == this.statut);
}

class MinisteresCompanion extends UpdateCompanion<MinistereRow> {
  final Value<String> id;
  final Value<String> noeudId;
  final Value<String> typeMinistereId;
  final Value<String> nom;
  final Value<DateTime> dateCreation;
  final Value<String> statut;
  final Value<int> rowid;
  const MinisteresCompanion({
    this.id = const Value.absent(),
    this.noeudId = const Value.absent(),
    this.typeMinistereId = const Value.absent(),
    this.nom = const Value.absent(),
    this.dateCreation = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MinisteresCompanion.insert({
    required String id,
    required String noeudId,
    required String typeMinistereId,
    required String nom,
    required DateTime dateCreation,
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       noeudId = Value(noeudId),
       typeMinistereId = Value(typeMinistereId),
       nom = Value(nom),
       dateCreation = Value(dateCreation);
  static Insertable<MinistereRow> custom({
    Expression<String>? id,
    Expression<String>? noeudId,
    Expression<String>? typeMinistereId,
    Expression<String>? nom,
    Expression<DateTime>? dateCreation,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noeudId != null) 'noeud_id': noeudId,
      if (typeMinistereId != null) 'type_ministere_id': typeMinistereId,
      if (nom != null) 'nom': nom,
      if (dateCreation != null) 'date_creation': dateCreation,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MinisteresCompanion copyWith({
    Value<String>? id,
    Value<String>? noeudId,
    Value<String>? typeMinistereId,
    Value<String>? nom,
    Value<DateTime>? dateCreation,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return MinisteresCompanion(
      id: id ?? this.id,
      noeudId: noeudId ?? this.noeudId,
      typeMinistereId: typeMinistereId ?? this.typeMinistereId,
      nom: nom ?? this.nom,
      dateCreation: dateCreation ?? this.dateCreation,
      statut: statut ?? this.statut,
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
    if (typeMinistereId.present) {
      map['type_ministere_id'] = Variable<String>(typeMinistereId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (dateCreation.present) {
      map['date_creation'] = Variable<DateTime>(dateCreation.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MinisteresCompanion(')
          ..write('id: $id, ')
          ..write('noeudId: $noeudId, ')
          ..write('typeMinistereId: $typeMinistereId, ')
          ..write('nom: $nom, ')
          ..write('dateCreation: $dateCreation, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AffectationsMinisteresTable extends AffectationsMinisteres
    with TableInfo<$AffectationsMinisteresTable, AffectationMinistereRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AffectationsMinisteresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ministereIdMeta = const VerificationMeta(
    'ministereId',
  );
  @override
  late final GeneratedColumn<String> ministereId = GeneratedColumn<String>(
    'ministere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ministeres (id)',
    ),
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDebutMeta = const VerificationMeta(
    'dateDebut',
  );
  @override
  late final GeneratedColumn<DateTime> dateDebut = GeneratedColumn<DateTime>(
    'date_debut',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFinMeta = const VerificationMeta(
    'dateFin',
  );
  @override
  late final GeneratedColumn<DateTime> dateFin = GeneratedColumn<DateTime>(
    'date_fin',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ministereId,
    fideleId,
    role,
    dateDebut,
    dateFin,
    statut,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'affectations_ministeres';
  @override
  VerificationContext validateIntegrity(
    Insertable<AffectationMinistereRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ministere_id')) {
      context.handle(
        _ministereIdMeta,
        ministereId.isAcceptableOrUnknown(
          data['ministere_id']!,
          _ministereIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ministereIdMeta);
    }
    if (data.containsKey('fidele_id')) {
      context.handle(
        _fideleIdMeta,
        fideleId.isAcceptableOrUnknown(data['fidele_id']!, _fideleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fideleIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('date_debut')) {
      context.handle(
        _dateDebutMeta,
        dateDebut.isAcceptableOrUnknown(data['date_debut']!, _dateDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateDebutMeta);
    }
    if (data.containsKey('date_fin')) {
      context.handle(
        _dateFinMeta,
        dateFin.isAcceptableOrUnknown(data['date_fin']!, _dateFinMeta),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AffectationMinistereRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AffectationMinistereRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ministereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ministere_id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      dateDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_debut'],
      )!,
      dateFin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fin'],
      ),
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $AffectationsMinisteresTable createAlias(String alias) {
    return $AffectationsMinisteresTable(attachedDatabase, alias);
  }
}

class AffectationMinistereRow extends DataClass
    implements Insertable<AffectationMinistereRow> {
  final String id;
  final String ministereId;
  final String fideleId;
  final String role;
  final DateTime dateDebut;
  final DateTime? dateFin;
  final String statut;
  const AffectationMinistereRow({
    required this.id,
    required this.ministereId,
    required this.fideleId,
    required this.role,
    required this.dateDebut,
    this.dateFin,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ministere_id'] = Variable<String>(ministereId);
    map['fidele_id'] = Variable<String>(fideleId);
    map['role'] = Variable<String>(role);
    map['date_debut'] = Variable<DateTime>(dateDebut);
    if (!nullToAbsent || dateFin != null) {
      map['date_fin'] = Variable<DateTime>(dateFin);
    }
    map['statut'] = Variable<String>(statut);
    return map;
  }

  AffectationsMinisteresCompanion toCompanion(bool nullToAbsent) {
    return AffectationsMinisteresCompanion(
      id: Value(id),
      ministereId: Value(ministereId),
      fideleId: Value(fideleId),
      role: Value(role),
      dateDebut: Value(dateDebut),
      dateFin: dateFin == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFin),
      statut: Value(statut),
    );
  }

  factory AffectationMinistereRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AffectationMinistereRow(
      id: serializer.fromJson<String>(json['id']),
      ministereId: serializer.fromJson<String>(json['ministereId']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      role: serializer.fromJson<String>(json['role']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      dateFin: serializer.fromJson<DateTime?>(json['dateFin']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ministereId': serializer.toJson<String>(ministereId),
      'fideleId': serializer.toJson<String>(fideleId),
      'role': serializer.toJson<String>(role),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'dateFin': serializer.toJson<DateTime?>(dateFin),
      'statut': serializer.toJson<String>(statut),
    };
  }

  AffectationMinistereRow copyWith({
    String? id,
    String? ministereId,
    String? fideleId,
    String? role,
    DateTime? dateDebut,
    Value<DateTime?> dateFin = const Value.absent(),
    String? statut,
  }) => AffectationMinistereRow(
    id: id ?? this.id,
    ministereId: ministereId ?? this.ministereId,
    fideleId: fideleId ?? this.fideleId,
    role: role ?? this.role,
    dateDebut: dateDebut ?? this.dateDebut,
    dateFin: dateFin.present ? dateFin.value : this.dateFin,
    statut: statut ?? this.statut,
  );
  AffectationMinistereRow copyWithCompanion(
    AffectationsMinisteresCompanion data,
  ) {
    return AffectationMinistereRow(
      id: data.id.present ? data.id.value : this.id,
      ministereId: data.ministereId.present
          ? data.ministereId.value
          : this.ministereId,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      role: data.role.present ? data.role.value : this.role,
      dateDebut: data.dateDebut.present ? data.dateDebut.value : this.dateDebut,
      dateFin: data.dateFin.present ? data.dateFin.value : this.dateFin,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AffectationMinistereRow(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('fideleId: $fideleId, ')
          ..write('role: $role, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ministereId, fideleId, role, dateDebut, dateFin, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AffectationMinistereRow &&
          other.id == this.id &&
          other.ministereId == this.ministereId &&
          other.fideleId == this.fideleId &&
          other.role == this.role &&
          other.dateDebut == this.dateDebut &&
          other.dateFin == this.dateFin &&
          other.statut == this.statut);
}

class AffectationsMinisteresCompanion
    extends UpdateCompanion<AffectationMinistereRow> {
  final Value<String> id;
  final Value<String> ministereId;
  final Value<String> fideleId;
  final Value<String> role;
  final Value<DateTime> dateDebut;
  final Value<DateTime?> dateFin;
  final Value<String> statut;
  final Value<int> rowid;
  const AffectationsMinisteresCompanion({
    this.id = const Value.absent(),
    this.ministereId = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.role = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFin = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AffectationsMinisteresCompanion.insert({
    required String id,
    required String ministereId,
    required String fideleId,
    required String role,
    required DateTime dateDebut,
    this.dateFin = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ministereId = Value(ministereId),
       fideleId = Value(fideleId),
       role = Value(role),
       dateDebut = Value(dateDebut);
  static Insertable<AffectationMinistereRow> custom({
    Expression<String>? id,
    Expression<String>? ministereId,
    Expression<String>? fideleId,
    Expression<String>? role,
    Expression<DateTime>? dateDebut,
    Expression<DateTime>? dateFin,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ministereId != null) 'ministere_id': ministereId,
      if (fideleId != null) 'fidele_id': fideleId,
      if (role != null) 'role': role,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (dateFin != null) 'date_fin': dateFin,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AffectationsMinisteresCompanion copyWith({
    Value<String>? id,
    Value<String>? ministereId,
    Value<String>? fideleId,
    Value<String>? role,
    Value<DateTime>? dateDebut,
    Value<DateTime?>? dateFin,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return AffectationsMinisteresCompanion(
      id: id ?? this.id,
      ministereId: ministereId ?? this.ministereId,
      fideleId: fideleId ?? this.fideleId,
      role: role ?? this.role,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      statut: statut ?? this.statut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ministereId.present) {
      map['ministere_id'] = Variable<String>(ministereId.value);
    }
    if (fideleId.present) {
      map['fidele_id'] = Variable<String>(fideleId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (dateFin.present) {
      map['date_fin'] = Variable<DateTime>(dateFin.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AffectationsMinisteresCompanion(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('fideleId: $fideleId, ')
          ..write('role: $role, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MandatsResponsablesTable extends MandatsResponsables
    with TableInfo<$MandatsResponsablesTable, MandatResponsableRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MandatsResponsablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ministereIdMeta = const VerificationMeta(
    'ministereId',
  );
  @override
  late final GeneratedColumn<String> ministereId = GeneratedColumn<String>(
    'ministere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ministeres (id)',
    ),
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
  static const VerificationMeta _dateDebutMeta = const VerificationMeta(
    'dateDebut',
  );
  @override
  late final GeneratedColumn<DateTime> dateDebut = GeneratedColumn<DateTime>(
    'date_debut',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFinPrevueMeta = const VerificationMeta(
    'dateFinPrevue',
  );
  @override
  late final GeneratedColumn<DateTime> dateFinPrevue =
      GeneratedColumn<DateTime>(
        'date_fin_prevue',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _dateFinReelleMeta = const VerificationMeta(
    'dateFinReelle',
  );
  @override
  late final GeneratedColumn<DateTime> dateFinReelle =
      GeneratedColumn<DateTime>(
        'date_fin_reelle',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ministereId,
    fideleId,
    dateDebut,
    dateFinPrevue,
    dateFinReelle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mandats_responsables';
  @override
  VerificationContext validateIntegrity(
    Insertable<MandatResponsableRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ministere_id')) {
      context.handle(
        _ministereIdMeta,
        ministereId.isAcceptableOrUnknown(
          data['ministere_id']!,
          _ministereIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ministereIdMeta);
    }
    if (data.containsKey('fidele_id')) {
      context.handle(
        _fideleIdMeta,
        fideleId.isAcceptableOrUnknown(data['fidele_id']!, _fideleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fideleIdMeta);
    }
    if (data.containsKey('date_debut')) {
      context.handle(
        _dateDebutMeta,
        dateDebut.isAcceptableOrUnknown(data['date_debut']!, _dateDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateDebutMeta);
    }
    if (data.containsKey('date_fin_prevue')) {
      context.handle(
        _dateFinPrevueMeta,
        dateFinPrevue.isAcceptableOrUnknown(
          data['date_fin_prevue']!,
          _dateFinPrevueMeta,
        ),
      );
    }
    if (data.containsKey('date_fin_reelle')) {
      context.handle(
        _dateFinReelleMeta,
        dateFinReelle.isAcceptableOrUnknown(
          data['date_fin_reelle']!,
          _dateFinReelleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MandatResponsableRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MandatResponsableRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ministereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ministere_id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      dateDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_debut'],
      )!,
      dateFinPrevue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fin_prevue'],
      ),
      dateFinReelle: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fin_reelle'],
      ),
    );
  }

  @override
  $MandatsResponsablesTable createAlias(String alias) {
    return $MandatsResponsablesTable(attachedDatabase, alias);
  }
}

class MandatResponsableRow extends DataClass
    implements Insertable<MandatResponsableRow> {
  final String id;
  final String ministereId;
  final String fideleId;
  final DateTime dateDebut;
  final DateTime? dateFinPrevue;
  final DateTime? dateFinReelle;
  const MandatResponsableRow({
    required this.id,
    required this.ministereId,
    required this.fideleId,
    required this.dateDebut,
    this.dateFinPrevue,
    this.dateFinReelle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ministere_id'] = Variable<String>(ministereId);
    map['fidele_id'] = Variable<String>(fideleId);
    map['date_debut'] = Variable<DateTime>(dateDebut);
    if (!nullToAbsent || dateFinPrevue != null) {
      map['date_fin_prevue'] = Variable<DateTime>(dateFinPrevue);
    }
    if (!nullToAbsent || dateFinReelle != null) {
      map['date_fin_reelle'] = Variable<DateTime>(dateFinReelle);
    }
    return map;
  }

  MandatsResponsablesCompanion toCompanion(bool nullToAbsent) {
    return MandatsResponsablesCompanion(
      id: Value(id),
      ministereId: Value(ministereId),
      fideleId: Value(fideleId),
      dateDebut: Value(dateDebut),
      dateFinPrevue: dateFinPrevue == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFinPrevue),
      dateFinReelle: dateFinReelle == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFinReelle),
    );
  }

  factory MandatResponsableRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MandatResponsableRow(
      id: serializer.fromJson<String>(json['id']),
      ministereId: serializer.fromJson<String>(json['ministereId']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      dateFinPrevue: serializer.fromJson<DateTime?>(json['dateFinPrevue']),
      dateFinReelle: serializer.fromJson<DateTime?>(json['dateFinReelle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ministereId': serializer.toJson<String>(ministereId),
      'fideleId': serializer.toJson<String>(fideleId),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'dateFinPrevue': serializer.toJson<DateTime?>(dateFinPrevue),
      'dateFinReelle': serializer.toJson<DateTime?>(dateFinReelle),
    };
  }

  MandatResponsableRow copyWith({
    String? id,
    String? ministereId,
    String? fideleId,
    DateTime? dateDebut,
    Value<DateTime?> dateFinPrevue = const Value.absent(),
    Value<DateTime?> dateFinReelle = const Value.absent(),
  }) => MandatResponsableRow(
    id: id ?? this.id,
    ministereId: ministereId ?? this.ministereId,
    fideleId: fideleId ?? this.fideleId,
    dateDebut: dateDebut ?? this.dateDebut,
    dateFinPrevue: dateFinPrevue.present
        ? dateFinPrevue.value
        : this.dateFinPrevue,
    dateFinReelle: dateFinReelle.present
        ? dateFinReelle.value
        : this.dateFinReelle,
  );
  MandatResponsableRow copyWithCompanion(MandatsResponsablesCompanion data) {
    return MandatResponsableRow(
      id: data.id.present ? data.id.value : this.id,
      ministereId: data.ministereId.present
          ? data.ministereId.value
          : this.ministereId,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      dateDebut: data.dateDebut.present ? data.dateDebut.value : this.dateDebut,
      dateFinPrevue: data.dateFinPrevue.present
          ? data.dateFinPrevue.value
          : this.dateFinPrevue,
      dateFinReelle: data.dateFinReelle.present
          ? data.dateFinReelle.value
          : this.dateFinReelle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MandatResponsableRow(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('fideleId: $fideleId, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFinPrevue: $dateFinPrevue, ')
          ..write('dateFinReelle: $dateFinReelle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ministereId,
    fideleId,
    dateDebut,
    dateFinPrevue,
    dateFinReelle,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MandatResponsableRow &&
          other.id == this.id &&
          other.ministereId == this.ministereId &&
          other.fideleId == this.fideleId &&
          other.dateDebut == this.dateDebut &&
          other.dateFinPrevue == this.dateFinPrevue &&
          other.dateFinReelle == this.dateFinReelle);
}

class MandatsResponsablesCompanion
    extends UpdateCompanion<MandatResponsableRow> {
  final Value<String> id;
  final Value<String> ministereId;
  final Value<String> fideleId;
  final Value<DateTime> dateDebut;
  final Value<DateTime?> dateFinPrevue;
  final Value<DateTime?> dateFinReelle;
  final Value<int> rowid;
  const MandatsResponsablesCompanion({
    this.id = const Value.absent(),
    this.ministereId = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFinPrevue = const Value.absent(),
    this.dateFinReelle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MandatsResponsablesCompanion.insert({
    required String id,
    required String ministereId,
    required String fideleId,
    required DateTime dateDebut,
    this.dateFinPrevue = const Value.absent(),
    this.dateFinReelle = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ministereId = Value(ministereId),
       fideleId = Value(fideleId),
       dateDebut = Value(dateDebut);
  static Insertable<MandatResponsableRow> custom({
    Expression<String>? id,
    Expression<String>? ministereId,
    Expression<String>? fideleId,
    Expression<DateTime>? dateDebut,
    Expression<DateTime>? dateFinPrevue,
    Expression<DateTime>? dateFinReelle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ministereId != null) 'ministere_id': ministereId,
      if (fideleId != null) 'fidele_id': fideleId,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (dateFinPrevue != null) 'date_fin_prevue': dateFinPrevue,
      if (dateFinReelle != null) 'date_fin_reelle': dateFinReelle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MandatsResponsablesCompanion copyWith({
    Value<String>? id,
    Value<String>? ministereId,
    Value<String>? fideleId,
    Value<DateTime>? dateDebut,
    Value<DateTime?>? dateFinPrevue,
    Value<DateTime?>? dateFinReelle,
    Value<int>? rowid,
  }) {
    return MandatsResponsablesCompanion(
      id: id ?? this.id,
      ministereId: ministereId ?? this.ministereId,
      fideleId: fideleId ?? this.fideleId,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFinPrevue: dateFinPrevue ?? this.dateFinPrevue,
      dateFinReelle: dateFinReelle ?? this.dateFinReelle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ministereId.present) {
      map['ministere_id'] = Variable<String>(ministereId.value);
    }
    if (fideleId.present) {
      map['fidele_id'] = Variable<String>(fideleId.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (dateFinPrevue.present) {
      map['date_fin_prevue'] = Variable<DateTime>(dateFinPrevue.value);
    }
    if (dateFinReelle.present) {
      map['date_fin_reelle'] = Variable<DateTime>(dateFinReelle.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MandatsResponsablesCompanion(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('fideleId: $fideleId, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFinPrevue: $dateFinPrevue, ')
          ..write('dateFinReelle: $dateFinReelle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitesMinisteresTable extends ActivitesMinisteres
    with TableInfo<$ActivitesMinisteresTable, ActiviteMinistereRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitesMinisteresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ministereIdMeta = const VerificationMeta(
    'ministereId',
  );
  @override
  late final GeneratedColumn<String> ministereId = GeneratedColumn<String>(
    'ministere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ministeres (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fideles (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ministereId,
    type,
    description,
    date,
    auteurFideleId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activites_ministeres';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiviteMinistereRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ministere_id')) {
      context.handle(
        _ministereIdMeta,
        ministereId.isAcceptableOrUnknown(
          data['ministere_id']!,
          _ministereIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ministereIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiviteMinistereRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiviteMinistereRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ministereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ministere_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      auteurFideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auteur_fidele_id'],
      ),
    );
  }

  @override
  $ActivitesMinisteresTable createAlias(String alias) {
    return $ActivitesMinisteresTable(attachedDatabase, alias);
  }
}

class ActiviteMinistereRow extends DataClass
    implements Insertable<ActiviteMinistereRow> {
  final String id;
  final String ministereId;
  final String type;
  final String description;
  final DateTime date;
  final String? auteurFideleId;
  const ActiviteMinistereRow({
    required this.id,
    required this.ministereId,
    required this.type,
    required this.description,
    required this.date,
    this.auteurFideleId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ministere_id'] = Variable<String>(ministereId);
    map['type'] = Variable<String>(type);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || auteurFideleId != null) {
      map['auteur_fidele_id'] = Variable<String>(auteurFideleId);
    }
    return map;
  }

  ActivitesMinisteresCompanion toCompanion(bool nullToAbsent) {
    return ActivitesMinisteresCompanion(
      id: Value(id),
      ministereId: Value(ministereId),
      type: Value(type),
      description: Value(description),
      date: Value(date),
      auteurFideleId: auteurFideleId == null && nullToAbsent
          ? const Value.absent()
          : Value(auteurFideleId),
    );
  }

  factory ActiviteMinistereRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiviteMinistereRow(
      id: serializer.fromJson<String>(json['id']),
      ministereId: serializer.fromJson<String>(json['ministereId']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      auteurFideleId: serializer.fromJson<String?>(json['auteurFideleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ministereId': serializer.toJson<String>(ministereId),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'auteurFideleId': serializer.toJson<String?>(auteurFideleId),
    };
  }

  ActiviteMinistereRow copyWith({
    String? id,
    String? ministereId,
    String? type,
    String? description,
    DateTime? date,
    Value<String?> auteurFideleId = const Value.absent(),
  }) => ActiviteMinistereRow(
    id: id ?? this.id,
    ministereId: ministereId ?? this.ministereId,
    type: type ?? this.type,
    description: description ?? this.description,
    date: date ?? this.date,
    auteurFideleId: auteurFideleId.present
        ? auteurFideleId.value
        : this.auteurFideleId,
  );
  ActiviteMinistereRow copyWithCompanion(ActivitesMinisteresCompanion data) {
    return ActiviteMinistereRow(
      id: data.id.present ? data.id.value : this.id,
      ministereId: data.ministereId.present
          ? data.ministereId.value
          : this.ministereId,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      auteurFideleId: data.auteurFideleId.present
          ? data.auteurFideleId.value
          : this.auteurFideleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiviteMinistereRow(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('auteurFideleId: $auteurFideleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ministereId, type, description, date, auteurFideleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiviteMinistereRow &&
          other.id == this.id &&
          other.ministereId == this.ministereId &&
          other.type == this.type &&
          other.description == this.description &&
          other.date == this.date &&
          other.auteurFideleId == this.auteurFideleId);
}

class ActivitesMinisteresCompanion
    extends UpdateCompanion<ActiviteMinistereRow> {
  final Value<String> id;
  final Value<String> ministereId;
  final Value<String> type;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<String?> auteurFideleId;
  final Value<int> rowid;
  const ActivitesMinisteresCompanion({
    this.id = const Value.absent(),
    this.ministereId = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.auteurFideleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitesMinisteresCompanion.insert({
    required String id,
    required String ministereId,
    required String type,
    required String description,
    required DateTime date,
    this.auteurFideleId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ministereId = Value(ministereId),
       type = Value(type),
       description = Value(description),
       date = Value(date);
  static Insertable<ActiviteMinistereRow> custom({
    Expression<String>? id,
    Expression<String>? ministereId,
    Expression<String>? type,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? auteurFideleId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ministereId != null) 'ministere_id': ministereId,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (auteurFideleId != null) 'auteur_fidele_id': auteurFideleId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitesMinisteresCompanion copyWith({
    Value<String>? id,
    Value<String>? ministereId,
    Value<String>? type,
    Value<String>? description,
    Value<DateTime>? date,
    Value<String?>? auteurFideleId,
    Value<int>? rowid,
  }) {
    return ActivitesMinisteresCompanion(
      id: id ?? this.id,
      ministereId: ministereId ?? this.ministereId,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      auteurFideleId: auteurFideleId ?? this.auteurFideleId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ministereId.present) {
      map['ministere_id'] = Variable<String>(ministereId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (auteurFideleId.present) {
      map['auteur_fidele_id'] = Variable<String>(auteurFideleId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitesMinisteresCompanion(')
          ..write('id: $id, ')
          ..write('ministereId: $ministereId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('auteurFideleId: $auteurFideleId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DonsSpirituelsTable extends DonsSpirituels
    with TableInfo<$DonsSpirituelsTable, DonSpirituelRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonsSpirituelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionBibliqueMeta =
      const VerificationMeta('descriptionBiblique');
  @override
  late final GeneratedColumn<String> descriptionBiblique =
      GeneratedColumn<String>(
        'description_biblique',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    libelle,
    descriptionBiblique,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dons_spirituels';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonSpirituelRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('description_biblique')) {
      context.handle(
        _descriptionBibliqueMeta,
        descriptionBiblique.isAcceptableOrUnknown(
          data['description_biblique']!,
          _descriptionBibliqueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionBibliqueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonSpirituelRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonSpirituelRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      descriptionBiblique: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_biblique'],
      )!,
    );
  }

  @override
  $DonsSpirituelsTable createAlias(String alias) {
    return $DonsSpirituelsTable(attachedDatabase, alias);
  }
}

class DonSpirituelRow extends DataClass implements Insertable<DonSpirituelRow> {
  final String id;
  final String code;
  final String libelle;
  final String descriptionBiblique;
  const DonSpirituelRow({
    required this.id,
    required this.code,
    required this.libelle,
    required this.descriptionBiblique,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['libelle'] = Variable<String>(libelle);
    map['description_biblique'] = Variable<String>(descriptionBiblique);
    return map;
  }

  DonsSpirituelsCompanion toCompanion(bool nullToAbsent) {
    return DonsSpirituelsCompanion(
      id: Value(id),
      code: Value(code),
      libelle: Value(libelle),
      descriptionBiblique: Value(descriptionBiblique),
    );
  }

  factory DonSpirituelRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonSpirituelRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      libelle: serializer.fromJson<String>(json['libelle']),
      descriptionBiblique: serializer.fromJson<String>(
        json['descriptionBiblique'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'libelle': serializer.toJson<String>(libelle),
      'descriptionBiblique': serializer.toJson<String>(descriptionBiblique),
    };
  }

  DonSpirituelRow copyWith({
    String? id,
    String? code,
    String? libelle,
    String? descriptionBiblique,
  }) => DonSpirituelRow(
    id: id ?? this.id,
    code: code ?? this.code,
    libelle: libelle ?? this.libelle,
    descriptionBiblique: descriptionBiblique ?? this.descriptionBiblique,
  );
  DonSpirituelRow copyWithCompanion(DonsSpirituelsCompanion data) {
    return DonSpirituelRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      descriptionBiblique: data.descriptionBiblique.present
          ? data.descriptionBiblique.value
          : this.descriptionBiblique,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonSpirituelRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('descriptionBiblique: $descriptionBiblique')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, libelle, descriptionBiblique);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonSpirituelRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.libelle == this.libelle &&
          other.descriptionBiblique == this.descriptionBiblique);
}

class DonsSpirituelsCompanion extends UpdateCompanion<DonSpirituelRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> libelle;
  final Value<String> descriptionBiblique;
  final Value<int> rowid;
  const DonsSpirituelsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.libelle = const Value.absent(),
    this.descriptionBiblique = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DonsSpirituelsCompanion.insert({
    required String id,
    required String code,
    required String libelle,
    required String descriptionBiblique,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       libelle = Value(libelle),
       descriptionBiblique = Value(descriptionBiblique);
  static Insertable<DonSpirituelRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? libelle,
    Expression<String>? descriptionBiblique,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (libelle != null) 'libelle': libelle,
      if (descriptionBiblique != null)
        'description_biblique': descriptionBiblique,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DonsSpirituelsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? libelle,
    Value<String>? descriptionBiblique,
    Value<int>? rowid,
  }) {
    return DonsSpirituelsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
      descriptionBiblique: descriptionBiblique ?? this.descriptionBiblique,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (descriptionBiblique.present) {
      map['description_biblique'] = Variable<String>(descriptionBiblique.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonsSpirituelsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('descriptionBiblique: $descriptionBiblique, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DonsFidelesTable extends DonsFideles
    with TableInfo<$DonsFidelesTable, DonFideleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonsFidelesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _donIdMeta = const VerificationMeta('donId');
  @override
  late final GeneratedColumn<String> donId = GeneratedColumn<String>(
    'don_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dons_spirituels (id)',
    ),
  );
  static const VerificationMeta _niveauMaturiteMeta = const VerificationMeta(
    'niveauMaturite',
  );
  @override
  late final GeneratedColumn<String> niveauMaturite = GeneratedColumn<String>(
    'niveau_maturite',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responsableSuiviIdMeta =
      const VerificationMeta('responsableSuiviId');
  @override
  late final GeneratedColumn<String> responsableSuiviId =
      GeneratedColumn<String>(
        'responsable_suivi_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES fideles (id)',
        ),
      );
  static const VerificationMeta _dateEvaluationMeta = const VerificationMeta(
    'dateEvaluation',
  );
  @override
  late final GeneratedColumn<DateTime> dateEvaluation =
      GeneratedColumn<DateTime>(
        'date_evaluation',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _observationsMeta = const VerificationMeta(
    'observations',
  );
  @override
  late final GeneratedColumn<String> observations = GeneratedColumn<String>(
    'observations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fideleId,
    donId,
    niveauMaturite,
    responsableSuiviId,
    dateEvaluation,
    observations,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dons_fideles';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonFideleRow> instance, {
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
    if (data.containsKey('don_id')) {
      context.handle(
        _donIdMeta,
        donId.isAcceptableOrUnknown(data['don_id']!, _donIdMeta),
      );
    } else if (isInserting) {
      context.missing(_donIdMeta);
    }
    if (data.containsKey('niveau_maturite')) {
      context.handle(
        _niveauMaturiteMeta,
        niveauMaturite.isAcceptableOrUnknown(
          data['niveau_maturite']!,
          _niveauMaturiteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_niveauMaturiteMeta);
    }
    if (data.containsKey('responsable_suivi_id')) {
      context.handle(
        _responsableSuiviIdMeta,
        responsableSuiviId.isAcceptableOrUnknown(
          data['responsable_suivi_id']!,
          _responsableSuiviIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responsableSuiviIdMeta);
    }
    if (data.containsKey('date_evaluation')) {
      context.handle(
        _dateEvaluationMeta,
        dateEvaluation.isAcceptableOrUnknown(
          data['date_evaluation']!,
          _dateEvaluationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateEvaluationMeta);
    }
    if (data.containsKey('observations')) {
      context.handle(
        _observationsMeta,
        observations.isAcceptableOrUnknown(
          data['observations']!,
          _observationsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonFideleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonFideleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      donId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}don_id'],
      )!,
      niveauMaturite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau_maturite'],
      )!,
      responsableSuiviId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}responsable_suivi_id'],
      )!,
      dateEvaluation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_evaluation'],
      )!,
      observations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observations'],
      ),
    );
  }

  @override
  $DonsFidelesTable createAlias(String alias) {
    return $DonsFidelesTable(attachedDatabase, alias);
  }
}

class DonFideleRow extends DataClass implements Insertable<DonFideleRow> {
  final String id;
  final String fideleId;
  final String donId;
  final String niveauMaturite;
  final String responsableSuiviId;
  final DateTime dateEvaluation;
  final String? observations;
  const DonFideleRow({
    required this.id,
    required this.fideleId,
    required this.donId,
    required this.niveauMaturite,
    required this.responsableSuiviId,
    required this.dateEvaluation,
    this.observations,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id'] = Variable<String>(fideleId);
    map['don_id'] = Variable<String>(donId);
    map['niveau_maturite'] = Variable<String>(niveauMaturite);
    map['responsable_suivi_id'] = Variable<String>(responsableSuiviId);
    map['date_evaluation'] = Variable<DateTime>(dateEvaluation);
    if (!nullToAbsent || observations != null) {
      map['observations'] = Variable<String>(observations);
    }
    return map;
  }

  DonsFidelesCompanion toCompanion(bool nullToAbsent) {
    return DonsFidelesCompanion(
      id: Value(id),
      fideleId: Value(fideleId),
      donId: Value(donId),
      niveauMaturite: Value(niveauMaturite),
      responsableSuiviId: Value(responsableSuiviId),
      dateEvaluation: Value(dateEvaluation),
      observations: observations == null && nullToAbsent
          ? const Value.absent()
          : Value(observations),
    );
  }

  factory DonFideleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonFideleRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      donId: serializer.fromJson<String>(json['donId']),
      niveauMaturite: serializer.fromJson<String>(json['niveauMaturite']),
      responsableSuiviId: serializer.fromJson<String>(
        json['responsableSuiviId'],
      ),
      dateEvaluation: serializer.fromJson<DateTime>(json['dateEvaluation']),
      observations: serializer.fromJson<String?>(json['observations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId': serializer.toJson<String>(fideleId),
      'donId': serializer.toJson<String>(donId),
      'niveauMaturite': serializer.toJson<String>(niveauMaturite),
      'responsableSuiviId': serializer.toJson<String>(responsableSuiviId),
      'dateEvaluation': serializer.toJson<DateTime>(dateEvaluation),
      'observations': serializer.toJson<String?>(observations),
    };
  }

  DonFideleRow copyWith({
    String? id,
    String? fideleId,
    String? donId,
    String? niveauMaturite,
    String? responsableSuiviId,
    DateTime? dateEvaluation,
    Value<String?> observations = const Value.absent(),
  }) => DonFideleRow(
    id: id ?? this.id,
    fideleId: fideleId ?? this.fideleId,
    donId: donId ?? this.donId,
    niveauMaturite: niveauMaturite ?? this.niveauMaturite,
    responsableSuiviId: responsableSuiviId ?? this.responsableSuiviId,
    dateEvaluation: dateEvaluation ?? this.dateEvaluation,
    observations: observations.present ? observations.value : this.observations,
  );
  DonFideleRow copyWithCompanion(DonsFidelesCompanion data) {
    return DonFideleRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      donId: data.donId.present ? data.donId.value : this.donId,
      niveauMaturite: data.niveauMaturite.present
          ? data.niveauMaturite.value
          : this.niveauMaturite,
      responsableSuiviId: data.responsableSuiviId.present
          ? data.responsableSuiviId.value
          : this.responsableSuiviId,
      dateEvaluation: data.dateEvaluation.present
          ? data.dateEvaluation.value
          : this.dateEvaluation,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonFideleRow(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('donId: $donId, ')
          ..write('niveauMaturite: $niveauMaturite, ')
          ..write('responsableSuiviId: $responsableSuiviId, ')
          ..write('dateEvaluation: $dateEvaluation, ')
          ..write('observations: $observations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fideleId,
    donId,
    niveauMaturite,
    responsableSuiviId,
    dateEvaluation,
    observations,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonFideleRow &&
          other.id == this.id &&
          other.fideleId == this.fideleId &&
          other.donId == this.donId &&
          other.niveauMaturite == this.niveauMaturite &&
          other.responsableSuiviId == this.responsableSuiviId &&
          other.dateEvaluation == this.dateEvaluation &&
          other.observations == this.observations);
}

class DonsFidelesCompanion extends UpdateCompanion<DonFideleRow> {
  final Value<String> id;
  final Value<String> fideleId;
  final Value<String> donId;
  final Value<String> niveauMaturite;
  final Value<String> responsableSuiviId;
  final Value<DateTime> dateEvaluation;
  final Value<String?> observations;
  final Value<int> rowid;
  const DonsFidelesCompanion({
    this.id = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.donId = const Value.absent(),
    this.niveauMaturite = const Value.absent(),
    this.responsableSuiviId = const Value.absent(),
    this.dateEvaluation = const Value.absent(),
    this.observations = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DonsFidelesCompanion.insert({
    required String id,
    required String fideleId,
    required String donId,
    required String niveauMaturite,
    required String responsableSuiviId,
    required DateTime dateEvaluation,
    this.observations = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId = Value(fideleId),
       donId = Value(donId),
       niveauMaturite = Value(niveauMaturite),
       responsableSuiviId = Value(responsableSuiviId),
       dateEvaluation = Value(dateEvaluation);
  static Insertable<DonFideleRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId,
    Expression<String>? donId,
    Expression<String>? niveauMaturite,
    Expression<String>? responsableSuiviId,
    Expression<DateTime>? dateEvaluation,
    Expression<String>? observations,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId != null) 'fidele_id': fideleId,
      if (donId != null) 'don_id': donId,
      if (niveauMaturite != null) 'niveau_maturite': niveauMaturite,
      if (responsableSuiviId != null)
        'responsable_suivi_id': responsableSuiviId,
      if (dateEvaluation != null) 'date_evaluation': dateEvaluation,
      if (observations != null) 'observations': observations,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DonsFidelesCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId,
    Value<String>? donId,
    Value<String>? niveauMaturite,
    Value<String>? responsableSuiviId,
    Value<DateTime>? dateEvaluation,
    Value<String?>? observations,
    Value<int>? rowid,
  }) {
    return DonsFidelesCompanion(
      id: id ?? this.id,
      fideleId: fideleId ?? this.fideleId,
      donId: donId ?? this.donId,
      niveauMaturite: niveauMaturite ?? this.niveauMaturite,
      responsableSuiviId: responsableSuiviId ?? this.responsableSuiviId,
      dateEvaluation: dateEvaluation ?? this.dateEvaluation,
      observations: observations ?? this.observations,
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
    if (donId.present) {
      map['don_id'] = Variable<String>(donId.value);
    }
    if (niveauMaturite.present) {
      map['niveau_maturite'] = Variable<String>(niveauMaturite.value);
    }
    if (responsableSuiviId.present) {
      map['responsable_suivi_id'] = Variable<String>(responsableSuiviId.value);
    }
    if (dateEvaluation.present) {
      map['date_evaluation'] = Variable<DateTime>(dateEvaluation.value);
    }
    if (observations.present) {
      map['observations'] = Variable<String>(observations.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonsFidelesCompanion(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('donId: $donId, ')
          ..write('niveauMaturite: $niveauMaturite, ')
          ..write('responsableSuiviId: $responsableSuiviId, ')
          ..write('dateEvaluation: $dateEvaluation, ')
          ..write('observations: $observations, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DonsMinisteresCompatiblesTable extends DonsMinisteresCompatibles
    with TableInfo<$DonsMinisteresCompatiblesTable, DonMinistereCompatibleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonsMinisteresCompatiblesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _donIdMeta = const VerificationMeta('donId');
  @override
  late final GeneratedColumn<String> donId = GeneratedColumn<String>(
    'don_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dons_spirituels (id)',
    ),
  );
  static const VerificationMeta _typeMinistereIdMeta = const VerificationMeta(
    'typeMinistereId',
  );
  @override
  late final GeneratedColumn<String> typeMinistereId = GeneratedColumn<String>(
    'type_ministere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types_ministeres (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, donId, typeMinistereId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dons_ministeres_compatibles';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonMinistereCompatibleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('don_id')) {
      context.handle(
        _donIdMeta,
        donId.isAcceptableOrUnknown(data['don_id']!, _donIdMeta),
      );
    } else if (isInserting) {
      context.missing(_donIdMeta);
    }
    if (data.containsKey('type_ministere_id')) {
      context.handle(
        _typeMinistereIdMeta,
        typeMinistereId.isAcceptableOrUnknown(
          data['type_ministere_id']!,
          _typeMinistereIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_typeMinistereIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonMinistereCompatibleRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonMinistereCompatibleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      donId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}don_id'],
      )!,
      typeMinistereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_ministere_id'],
      )!,
    );
  }

  @override
  $DonsMinisteresCompatiblesTable createAlias(String alias) {
    return $DonsMinisteresCompatiblesTable(attachedDatabase, alias);
  }
}

class DonMinistereCompatibleRow extends DataClass
    implements Insertable<DonMinistereCompatibleRow> {
  final String id;
  final String donId;
  final String typeMinistereId;
  const DonMinistereCompatibleRow({
    required this.id,
    required this.donId,
    required this.typeMinistereId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['don_id'] = Variable<String>(donId);
    map['type_ministere_id'] = Variable<String>(typeMinistereId);
    return map;
  }

  DonsMinisteresCompatiblesCompanion toCompanion(bool nullToAbsent) {
    return DonsMinisteresCompatiblesCompanion(
      id: Value(id),
      donId: Value(donId),
      typeMinistereId: Value(typeMinistereId),
    );
  }

  factory DonMinistereCompatibleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonMinistereCompatibleRow(
      id: serializer.fromJson<String>(json['id']),
      donId: serializer.fromJson<String>(json['donId']),
      typeMinistereId: serializer.fromJson<String>(json['typeMinistereId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'donId': serializer.toJson<String>(donId),
      'typeMinistereId': serializer.toJson<String>(typeMinistereId),
    };
  }

  DonMinistereCompatibleRow copyWith({
    String? id,
    String? donId,
    String? typeMinistereId,
  }) => DonMinistereCompatibleRow(
    id: id ?? this.id,
    donId: donId ?? this.donId,
    typeMinistereId: typeMinistereId ?? this.typeMinistereId,
  );
  DonMinistereCompatibleRow copyWithCompanion(
    DonsMinisteresCompatiblesCompanion data,
  ) {
    return DonMinistereCompatibleRow(
      id: data.id.present ? data.id.value : this.id,
      donId: data.donId.present ? data.donId.value : this.donId,
      typeMinistereId: data.typeMinistereId.present
          ? data.typeMinistereId.value
          : this.typeMinistereId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonMinistereCompatibleRow(')
          ..write('id: $id, ')
          ..write('donId: $donId, ')
          ..write('typeMinistereId: $typeMinistereId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, donId, typeMinistereId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonMinistereCompatibleRow &&
          other.id == this.id &&
          other.donId == this.donId &&
          other.typeMinistereId == this.typeMinistereId);
}

class DonsMinisteresCompatiblesCompanion
    extends UpdateCompanion<DonMinistereCompatibleRow> {
  final Value<String> id;
  final Value<String> donId;
  final Value<String> typeMinistereId;
  final Value<int> rowid;
  const DonsMinisteresCompatiblesCompanion({
    this.id = const Value.absent(),
    this.donId = const Value.absent(),
    this.typeMinistereId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DonsMinisteresCompatiblesCompanion.insert({
    required String id,
    required String donId,
    required String typeMinistereId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       donId = Value(donId),
       typeMinistereId = Value(typeMinistereId);
  static Insertable<DonMinistereCompatibleRow> custom({
    Expression<String>? id,
    Expression<String>? donId,
    Expression<String>? typeMinistereId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donId != null) 'don_id': donId,
      if (typeMinistereId != null) 'type_ministere_id': typeMinistereId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DonsMinisteresCompatiblesCompanion copyWith({
    Value<String>? id,
    Value<String>? donId,
    Value<String>? typeMinistereId,
    Value<int>? rowid,
  }) {
    return DonsMinisteresCompatiblesCompanion(
      id: id ?? this.id,
      donId: donId ?? this.donId,
      typeMinistereId: typeMinistereId ?? this.typeMinistereId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (donId.present) {
      map['don_id'] = Variable<String>(donId.value);
    }
    if (typeMinistereId.present) {
      map['type_ministere_id'] = Variable<String>(typeMinistereId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonsMinisteresCompatiblesCompanion(')
          ..write('id: $id, ')
          ..write('donId: $donId, ')
          ..write('typeMinistereId: $typeMinistereId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfessionsTable extends Professions
    with TableInfo<$ProfessionsTable, ProfessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categorieMeta = const VerificationMeta(
    'categorie',
  );
  @override
  late final GeneratedColumn<String> categorie = GeneratedColumn<String>(
    'categorie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
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
    defaultValue: const Constant('actif'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, code, categorie, libelle, statut];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'professions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('categorie')) {
      context.handle(
        _categorieMeta,
        categorie.isAcceptableOrUnknown(data['categorie']!, _categorieMeta),
      );
    } else if (isInserting) {
      context.missing(_categorieMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      categorie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categorie'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $ProfessionsTable createAlias(String alias) {
    return $ProfessionsTable(attachedDatabase, alias);
  }
}

class ProfessionRow extends DataClass implements Insertable<ProfessionRow> {
  final String id;
  final String code;
  final String categorie;
  final String libelle;
  final String statut;
  const ProfessionRow({
    required this.id,
    required this.code,
    required this.categorie,
    required this.libelle,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['categorie'] = Variable<String>(categorie);
    map['libelle'] = Variable<String>(libelle);
    map['statut'] = Variable<String>(statut);
    return map;
  }

  ProfessionsCompanion toCompanion(bool nullToAbsent) {
    return ProfessionsCompanion(
      id: Value(id),
      code: Value(code),
      categorie: Value(categorie),
      libelle: Value(libelle),
      statut: Value(statut),
    );
  }

  factory ProfessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfessionRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      categorie: serializer.fromJson<String>(json['categorie']),
      libelle: serializer.fromJson<String>(json['libelle']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'categorie': serializer.toJson<String>(categorie),
      'libelle': serializer.toJson<String>(libelle),
      'statut': serializer.toJson<String>(statut),
    };
  }

  ProfessionRow copyWith({
    String? id,
    String? code,
    String? categorie,
    String? libelle,
    String? statut,
  }) => ProfessionRow(
    id: id ?? this.id,
    code: code ?? this.code,
    categorie: categorie ?? this.categorie,
    libelle: libelle ?? this.libelle,
    statut: statut ?? this.statut,
  );
  ProfessionRow copyWithCompanion(ProfessionsCompanion data) {
    return ProfessionRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      categorie: data.categorie.present ? data.categorie.value : this.categorie,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfessionRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('categorie: $categorie, ')
          ..write('libelle: $libelle, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, categorie, libelle, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfessionRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.categorie == this.categorie &&
          other.libelle == this.libelle &&
          other.statut == this.statut);
}

class ProfessionsCompanion extends UpdateCompanion<ProfessionRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> categorie;
  final Value<String> libelle;
  final Value<String> statut;
  final Value<int> rowid;
  const ProfessionsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.categorie = const Value.absent(),
    this.libelle = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfessionsCompanion.insert({
    required String id,
    required String code,
    required String categorie,
    required String libelle,
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       categorie = Value(categorie),
       libelle = Value(libelle);
  static Insertable<ProfessionRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? categorie,
    Expression<String>? libelle,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (categorie != null) 'categorie': categorie,
      if (libelle != null) 'libelle': libelle,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? categorie,
    Value<String>? libelle,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return ProfessionsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      categorie: categorie ?? this.categorie,
      libelle: libelle ?? this.libelle,
      statut: statut ?? this.statut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (categorie.present) {
      map['categorie'] = Variable<String>(categorie.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfessionsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('categorie: $categorie, ')
          ..write('libelle: $libelle, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfessionsFidelesTable extends ProfessionsFideles
    with TableInfo<$ProfessionsFidelesTable, ProfessionFideleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfessionsFidelesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _professionIdMeta = const VerificationMeta(
    'professionId',
  );
  @override
  late final GeneratedColumn<String> professionId = GeneratedColumn<String>(
    'profession_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES professions (id)',
    ),
  );
  static const VerificationMeta _statutVerificationMeta =
      const VerificationMeta('statutVerification');
  @override
  late final GeneratedColumn<String> statutVerification =
      GeneratedColumn<String>(
        'statut_verification',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('declare'),
      );
  static const VerificationMeta _anneesExperienceMeta = const VerificationMeta(
    'anneesExperience',
  );
  @override
  late final GeneratedColumn<int> anneesExperience = GeneratedColumn<int>(
    'annees_experience',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fideleId,
    professionId,
    statutVerification,
    anneesExperience,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'professions_fideles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfessionFideleRow> instance, {
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
    if (data.containsKey('profession_id')) {
      context.handle(
        _professionIdMeta,
        professionId.isAcceptableOrUnknown(
          data['profession_id']!,
          _professionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_professionIdMeta);
    }
    if (data.containsKey('statut_verification')) {
      context.handle(
        _statutVerificationMeta,
        statutVerification.isAcceptableOrUnknown(
          data['statut_verification']!,
          _statutVerificationMeta,
        ),
      );
    }
    if (data.containsKey('annees_experience')) {
      context.handle(
        _anneesExperienceMeta,
        anneesExperience.isAcceptableOrUnknown(
          data['annees_experience']!,
          _anneesExperienceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfessionFideleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfessionFideleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      professionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profession_id'],
      )!,
      statutVerification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut_verification'],
      )!,
      anneesExperience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}annees_experience'],
      ),
    );
  }

  @override
  $ProfessionsFidelesTable createAlias(String alias) {
    return $ProfessionsFidelesTable(attachedDatabase, alias);
  }
}

class ProfessionFideleRow extends DataClass
    implements Insertable<ProfessionFideleRow> {
  final String id;
  final String fideleId;
  final String professionId;
  final String statutVerification;
  final int? anneesExperience;
  const ProfessionFideleRow({
    required this.id,
    required this.fideleId,
    required this.professionId,
    required this.statutVerification,
    this.anneesExperience,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id'] = Variable<String>(fideleId);
    map['profession_id'] = Variable<String>(professionId);
    map['statut_verification'] = Variable<String>(statutVerification);
    if (!nullToAbsent || anneesExperience != null) {
      map['annees_experience'] = Variable<int>(anneesExperience);
    }
    return map;
  }

  ProfessionsFidelesCompanion toCompanion(bool nullToAbsent) {
    return ProfessionsFidelesCompanion(
      id: Value(id),
      fideleId: Value(fideleId),
      professionId: Value(professionId),
      statutVerification: Value(statutVerification),
      anneesExperience: anneesExperience == null && nullToAbsent
          ? const Value.absent()
          : Value(anneesExperience),
    );
  }

  factory ProfessionFideleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfessionFideleRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      professionId: serializer.fromJson<String>(json['professionId']),
      statutVerification: serializer.fromJson<String>(
        json['statutVerification'],
      ),
      anneesExperience: serializer.fromJson<int?>(json['anneesExperience']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId': serializer.toJson<String>(fideleId),
      'professionId': serializer.toJson<String>(professionId),
      'statutVerification': serializer.toJson<String>(statutVerification),
      'anneesExperience': serializer.toJson<int?>(anneesExperience),
    };
  }

  ProfessionFideleRow copyWith({
    String? id,
    String? fideleId,
    String? professionId,
    String? statutVerification,
    Value<int?> anneesExperience = const Value.absent(),
  }) => ProfessionFideleRow(
    id: id ?? this.id,
    fideleId: fideleId ?? this.fideleId,
    professionId: professionId ?? this.professionId,
    statutVerification: statutVerification ?? this.statutVerification,
    anneesExperience: anneesExperience.present
        ? anneesExperience.value
        : this.anneesExperience,
  );
  ProfessionFideleRow copyWithCompanion(ProfessionsFidelesCompanion data) {
    return ProfessionFideleRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      professionId: data.professionId.present
          ? data.professionId.value
          : this.professionId,
      statutVerification: data.statutVerification.present
          ? data.statutVerification.value
          : this.statutVerification,
      anneesExperience: data.anneesExperience.present
          ? data.anneesExperience.value
          : this.anneesExperience,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfessionFideleRow(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('professionId: $professionId, ')
          ..write('statutVerification: $statutVerification, ')
          ..write('anneesExperience: $anneesExperience')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fideleId,
    professionId,
    statutVerification,
    anneesExperience,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfessionFideleRow &&
          other.id == this.id &&
          other.fideleId == this.fideleId &&
          other.professionId == this.professionId &&
          other.statutVerification == this.statutVerification &&
          other.anneesExperience == this.anneesExperience);
}

class ProfessionsFidelesCompanion extends UpdateCompanion<ProfessionFideleRow> {
  final Value<String> id;
  final Value<String> fideleId;
  final Value<String> professionId;
  final Value<String> statutVerification;
  final Value<int?> anneesExperience;
  final Value<int> rowid;
  const ProfessionsFidelesCompanion({
    this.id = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.professionId = const Value.absent(),
    this.statutVerification = const Value.absent(),
    this.anneesExperience = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfessionsFidelesCompanion.insert({
    required String id,
    required String fideleId,
    required String professionId,
    this.statutVerification = const Value.absent(),
    this.anneesExperience = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId = Value(fideleId),
       professionId = Value(professionId);
  static Insertable<ProfessionFideleRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId,
    Expression<String>? professionId,
    Expression<String>? statutVerification,
    Expression<int>? anneesExperience,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId != null) 'fidele_id': fideleId,
      if (professionId != null) 'profession_id': professionId,
      if (statutVerification != null) 'statut_verification': statutVerification,
      if (anneesExperience != null) 'annees_experience': anneesExperience,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfessionsFidelesCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId,
    Value<String>? professionId,
    Value<String>? statutVerification,
    Value<int?>? anneesExperience,
    Value<int>? rowid,
  }) {
    return ProfessionsFidelesCompanion(
      id: id ?? this.id,
      fideleId: fideleId ?? this.fideleId,
      professionId: professionId ?? this.professionId,
      statutVerification: statutVerification ?? this.statutVerification,
      anneesExperience: anneesExperience ?? this.anneesExperience,
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
    if (professionId.present) {
      map['profession_id'] = Variable<String>(professionId.value);
    }
    if (statutVerification.present) {
      map['statut_verification'] = Variable<String>(statutVerification.value);
    }
    if (anneesExperience.present) {
      map['annees_experience'] = Variable<int>(anneesExperience.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfessionsFidelesCompanion(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('professionId: $professionId, ')
          ..write('statutVerification: $statutVerification, ')
          ..write('anneesExperience: $anneesExperience, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SollicitationsTable extends Sollicitations
    with TableInfo<$SollicitationsTable, SollicitationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SollicitationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _objetMeta = const VerificationMeta('objet');
  @override
  late final GeneratedColumn<String> objet = GeneratedColumn<String>(
    'objet',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _reponseMeta = const VerificationMeta(
    'reponse',
  );
  @override
  late final GeneratedColumn<String> reponse = GeneratedColumn<String>(
    'reponse',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fideleId, objet, date, reponse];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sollicitations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SollicitationRow> instance, {
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
    if (data.containsKey('objet')) {
      context.handle(
        _objetMeta,
        objet.isAcceptableOrUnknown(data['objet']!, _objetMeta),
      );
    } else if (isInserting) {
      context.missing(_objetMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('reponse')) {
      context.handle(
        _reponseMeta,
        reponse.isAcceptableOrUnknown(data['reponse']!, _reponseMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SollicitationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SollicitationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      objet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objet'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      reponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reponse'],
      ),
    );
  }

  @override
  $SollicitationsTable createAlias(String alias) {
    return $SollicitationsTable(attachedDatabase, alias);
  }
}

class SollicitationRow extends DataClass
    implements Insertable<SollicitationRow> {
  final String id;
  final String fideleId;
  final String objet;
  final DateTime date;
  final String? reponse;
  const SollicitationRow({
    required this.id,
    required this.fideleId,
    required this.objet,
    required this.date,
    this.reponse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id'] = Variable<String>(fideleId);
    map['objet'] = Variable<String>(objet);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || reponse != null) {
      map['reponse'] = Variable<String>(reponse);
    }
    return map;
  }

  SollicitationsCompanion toCompanion(bool nullToAbsent) {
    return SollicitationsCompanion(
      id: Value(id),
      fideleId: Value(fideleId),
      objet: Value(objet),
      date: Value(date),
      reponse: reponse == null && nullToAbsent
          ? const Value.absent()
          : Value(reponse),
    );
  }

  factory SollicitationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SollicitationRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      objet: serializer.fromJson<String>(json['objet']),
      date: serializer.fromJson<DateTime>(json['date']),
      reponse: serializer.fromJson<String?>(json['reponse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId': serializer.toJson<String>(fideleId),
      'objet': serializer.toJson<String>(objet),
      'date': serializer.toJson<DateTime>(date),
      'reponse': serializer.toJson<String?>(reponse),
    };
  }

  SollicitationRow copyWith({
    String? id,
    String? fideleId,
    String? objet,
    DateTime? date,
    Value<String?> reponse = const Value.absent(),
  }) => SollicitationRow(
    id: id ?? this.id,
    fideleId: fideleId ?? this.fideleId,
    objet: objet ?? this.objet,
    date: date ?? this.date,
    reponse: reponse.present ? reponse.value : this.reponse,
  );
  SollicitationRow copyWithCompanion(SollicitationsCompanion data) {
    return SollicitationRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      objet: data.objet.present ? data.objet.value : this.objet,
      date: data.date.present ? data.date.value : this.date,
      reponse: data.reponse.present ? data.reponse.value : this.reponse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SollicitationRow(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('objet: $objet, ')
          ..write('date: $date, ')
          ..write('reponse: $reponse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fideleId, objet, date, reponse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SollicitationRow &&
          other.id == this.id &&
          other.fideleId == this.fideleId &&
          other.objet == this.objet &&
          other.date == this.date &&
          other.reponse == this.reponse);
}

class SollicitationsCompanion extends UpdateCompanion<SollicitationRow> {
  final Value<String> id;
  final Value<String> fideleId;
  final Value<String> objet;
  final Value<DateTime> date;
  final Value<String?> reponse;
  final Value<int> rowid;
  const SollicitationsCompanion({
    this.id = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.objet = const Value.absent(),
    this.date = const Value.absent(),
    this.reponse = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SollicitationsCompanion.insert({
    required String id,
    required String fideleId,
    required String objet,
    required DateTime date,
    this.reponse = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId = Value(fideleId),
       objet = Value(objet),
       date = Value(date);
  static Insertable<SollicitationRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId,
    Expression<String>? objet,
    Expression<DateTime>? date,
    Expression<String>? reponse,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId != null) 'fidele_id': fideleId,
      if (objet != null) 'objet': objet,
      if (date != null) 'date': date,
      if (reponse != null) 'reponse': reponse,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SollicitationsCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId,
    Value<String>? objet,
    Value<DateTime>? date,
    Value<String?>? reponse,
    Value<int>? rowid,
  }) {
    return SollicitationsCompanion(
      id: id ?? this.id,
      fideleId: fideleId ?? this.fideleId,
      objet: objet ?? this.objet,
      date: date ?? this.date,
      reponse: reponse ?? this.reponse,
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
    if (objet.present) {
      map['objet'] = Variable<String>(objet.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (reponse.present) {
      map['reponse'] = Variable<String>(reponse.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SollicitationsCompanion(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('objet: $objet, ')
          ..write('date: $date, ')
          ..write('reponse: $reponse, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupesEgliseTable extends GroupesEglise
    with TableInfo<$GroupesEgliseTable, GroupeEgliseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupesEgliseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeRegleMeta = const VerificationMeta(
    'typeRegle',
  );
  @override
  late final GeneratedColumn<String> typeRegle = GeneratedColumn<String>(
    'type_regle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criteresJsonMeta = const VerificationMeta(
    'criteresJson',
  );
  @override
  late final GeneratedColumn<String> criteresJson = GeneratedColumn<String>(
    'criteres_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    libelle,
    typeRegle,
    criteresJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groupes_eglise';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupeEgliseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('type_regle')) {
      context.handle(
        _typeRegleMeta,
        typeRegle.isAcceptableOrUnknown(data['type_regle']!, _typeRegleMeta),
      );
    } else if (isInserting) {
      context.missing(_typeRegleMeta);
    }
    if (data.containsKey('criteres_json')) {
      context.handle(
        _criteresJsonMeta,
        criteresJson.isAcceptableOrUnknown(
          data['criteres_json']!,
          _criteresJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupeEgliseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupeEgliseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      typeRegle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_regle'],
      )!,
      criteresJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}criteres_json'],
      ),
    );
  }

  @override
  $GroupesEgliseTable createAlias(String alias) {
    return $GroupesEgliseTable(attachedDatabase, alias);
  }
}

class GroupeEgliseRow extends DataClass implements Insertable<GroupeEgliseRow> {
  final String id;
  final String code;
  final String libelle;
  final String typeRegle;
  final String? criteresJson;
  const GroupeEgliseRow({
    required this.id,
    required this.code,
    required this.libelle,
    required this.typeRegle,
    this.criteresJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['libelle'] = Variable<String>(libelle);
    map['type_regle'] = Variable<String>(typeRegle);
    if (!nullToAbsent || criteresJson != null) {
      map['criteres_json'] = Variable<String>(criteresJson);
    }
    return map;
  }

  GroupesEgliseCompanion toCompanion(bool nullToAbsent) {
    return GroupesEgliseCompanion(
      id: Value(id),
      code: Value(code),
      libelle: Value(libelle),
      typeRegle: Value(typeRegle),
      criteresJson: criteresJson == null && nullToAbsent
          ? const Value.absent()
          : Value(criteresJson),
    );
  }

  factory GroupeEgliseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupeEgliseRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      libelle: serializer.fromJson<String>(json['libelle']),
      typeRegle: serializer.fromJson<String>(json['typeRegle']),
      criteresJson: serializer.fromJson<String?>(json['criteresJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'libelle': serializer.toJson<String>(libelle),
      'typeRegle': serializer.toJson<String>(typeRegle),
      'criteresJson': serializer.toJson<String?>(criteresJson),
    };
  }

  GroupeEgliseRow copyWith({
    String? id,
    String? code,
    String? libelle,
    String? typeRegle,
    Value<String?> criteresJson = const Value.absent(),
  }) => GroupeEgliseRow(
    id: id ?? this.id,
    code: code ?? this.code,
    libelle: libelle ?? this.libelle,
    typeRegle: typeRegle ?? this.typeRegle,
    criteresJson: criteresJson.present ? criteresJson.value : this.criteresJson,
  );
  GroupeEgliseRow copyWithCompanion(GroupesEgliseCompanion data) {
    return GroupeEgliseRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      typeRegle: data.typeRegle.present ? data.typeRegle.value : this.typeRegle,
      criteresJson: data.criteresJson.present
          ? data.criteresJson.value
          : this.criteresJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupeEgliseRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('typeRegle: $typeRegle, ')
          ..write('criteresJson: $criteresJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, libelle, typeRegle, criteresJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupeEgliseRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.libelle == this.libelle &&
          other.typeRegle == this.typeRegle &&
          other.criteresJson == this.criteresJson);
}

class GroupesEgliseCompanion extends UpdateCompanion<GroupeEgliseRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> libelle;
  final Value<String> typeRegle;
  final Value<String?> criteresJson;
  final Value<int> rowid;
  const GroupesEgliseCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.libelle = const Value.absent(),
    this.typeRegle = const Value.absent(),
    this.criteresJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupesEgliseCompanion.insert({
    required String id,
    required String code,
    required String libelle,
    required String typeRegle,
    this.criteresJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       libelle = Value(libelle),
       typeRegle = Value(typeRegle);
  static Insertable<GroupeEgliseRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? libelle,
    Expression<String>? typeRegle,
    Expression<String>? criteresJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (libelle != null) 'libelle': libelle,
      if (typeRegle != null) 'type_regle': typeRegle,
      if (criteresJson != null) 'criteres_json': criteresJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupesEgliseCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? libelle,
    Value<String>? typeRegle,
    Value<String?>? criteresJson,
    Value<int>? rowid,
  }) {
    return GroupesEgliseCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
      typeRegle: typeRegle ?? this.typeRegle,
      criteresJson: criteresJson ?? this.criteresJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (typeRegle.present) {
      map['type_regle'] = Variable<String>(typeRegle.value);
    }
    if (criteresJson.present) {
      map['criteres_json'] = Variable<String>(criteresJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupesEgliseCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('typeRegle: $typeRegle, ')
          ..write('criteresJson: $criteresJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppartenancesGroupeTable extends AppartenancesGroupe
    with TableInfo<$AppartenancesGroupeTable, AppartenanceGroupeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppartenancesGroupeTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _groupeIdMeta = const VerificationMeta(
    'groupeId',
  );
  @override
  late final GeneratedColumn<String> groupeId = GeneratedColumn<String>(
    'groupe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES groupes_eglise (id)',
    ),
  );
  static const VerificationMeta _dateAffectationMeta = const VerificationMeta(
    'dateAffectation',
  );
  @override
  late final GeneratedColumn<DateTime> dateAffectation =
      GeneratedColumn<DateTime>(
        'date_affectation',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _origineMeta = const VerificationMeta(
    'origine',
  );
  @override
  late final GeneratedColumn<String> origine = GeneratedColumn<String>(
    'origine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motifDerogationMeta = const VerificationMeta(
    'motifDerogation',
  );
  @override
  late final GeneratedColumn<String> motifDerogation = GeneratedColumn<String>(
    'motif_derogation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fideleId,
    groupeId,
    dateAffectation,
    origine,
    motifDerogation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appartenances_groupe';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppartenanceGroupeRow> instance, {
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
    if (data.containsKey('groupe_id')) {
      context.handle(
        _groupeIdMeta,
        groupeId.isAcceptableOrUnknown(data['groupe_id']!, _groupeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupeIdMeta);
    }
    if (data.containsKey('date_affectation')) {
      context.handle(
        _dateAffectationMeta,
        dateAffectation.isAcceptableOrUnknown(
          data['date_affectation']!,
          _dateAffectationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateAffectationMeta);
    }
    if (data.containsKey('origine')) {
      context.handle(
        _origineMeta,
        origine.isAcceptableOrUnknown(data['origine']!, _origineMeta),
      );
    } else if (isInserting) {
      context.missing(_origineMeta);
    }
    if (data.containsKey('motif_derogation')) {
      context.handle(
        _motifDerogationMeta,
        motifDerogation.isAcceptableOrUnknown(
          data['motif_derogation']!,
          _motifDerogationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppartenanceGroupeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppartenanceGroupeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fideleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fidele_id'],
      )!,
      groupeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}groupe_id'],
      )!,
      dateAffectation: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_affectation'],
      )!,
      origine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origine'],
      )!,
      motifDerogation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motif_derogation'],
      ),
    );
  }

  @override
  $AppartenancesGroupeTable createAlias(String alias) {
    return $AppartenancesGroupeTable(attachedDatabase, alias);
  }
}

class AppartenanceGroupeRow extends DataClass
    implements Insertable<AppartenanceGroupeRow> {
  final String id;
  final String fideleId;
  final String groupeId;
  final DateTime dateAffectation;
  final String origine;
  final String? motifDerogation;
  const AppartenanceGroupeRow({
    required this.id,
    required this.fideleId,
    required this.groupeId,
    required this.dateAffectation,
    required this.origine,
    this.motifDerogation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fidele_id'] = Variable<String>(fideleId);
    map['groupe_id'] = Variable<String>(groupeId);
    map['date_affectation'] = Variable<DateTime>(dateAffectation);
    map['origine'] = Variable<String>(origine);
    if (!nullToAbsent || motifDerogation != null) {
      map['motif_derogation'] = Variable<String>(motifDerogation);
    }
    return map;
  }

  AppartenancesGroupeCompanion toCompanion(bool nullToAbsent) {
    return AppartenancesGroupeCompanion(
      id: Value(id),
      fideleId: Value(fideleId),
      groupeId: Value(groupeId),
      dateAffectation: Value(dateAffectation),
      origine: Value(origine),
      motifDerogation: motifDerogation == null && nullToAbsent
          ? const Value.absent()
          : Value(motifDerogation),
    );
  }

  factory AppartenanceGroupeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppartenanceGroupeRow(
      id: serializer.fromJson<String>(json['id']),
      fideleId: serializer.fromJson<String>(json['fideleId']),
      groupeId: serializer.fromJson<String>(json['groupeId']),
      dateAffectation: serializer.fromJson<DateTime>(json['dateAffectation']),
      origine: serializer.fromJson<String>(json['origine']),
      motifDerogation: serializer.fromJson<String?>(json['motifDerogation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fideleId': serializer.toJson<String>(fideleId),
      'groupeId': serializer.toJson<String>(groupeId),
      'dateAffectation': serializer.toJson<DateTime>(dateAffectation),
      'origine': serializer.toJson<String>(origine),
      'motifDerogation': serializer.toJson<String?>(motifDerogation),
    };
  }

  AppartenanceGroupeRow copyWith({
    String? id,
    String? fideleId,
    String? groupeId,
    DateTime? dateAffectation,
    String? origine,
    Value<String?> motifDerogation = const Value.absent(),
  }) => AppartenanceGroupeRow(
    id: id ?? this.id,
    fideleId: fideleId ?? this.fideleId,
    groupeId: groupeId ?? this.groupeId,
    dateAffectation: dateAffectation ?? this.dateAffectation,
    origine: origine ?? this.origine,
    motifDerogation: motifDerogation.present
        ? motifDerogation.value
        : this.motifDerogation,
  );
  AppartenanceGroupeRow copyWithCompanion(AppartenancesGroupeCompanion data) {
    return AppartenanceGroupeRow(
      id: data.id.present ? data.id.value : this.id,
      fideleId: data.fideleId.present ? data.fideleId.value : this.fideleId,
      groupeId: data.groupeId.present ? data.groupeId.value : this.groupeId,
      dateAffectation: data.dateAffectation.present
          ? data.dateAffectation.value
          : this.dateAffectation,
      origine: data.origine.present ? data.origine.value : this.origine,
      motifDerogation: data.motifDerogation.present
          ? data.motifDerogation.value
          : this.motifDerogation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppartenanceGroupeRow(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('groupeId: $groupeId, ')
          ..write('dateAffectation: $dateAffectation, ')
          ..write('origine: $origine, ')
          ..write('motifDerogation: $motifDerogation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fideleId,
    groupeId,
    dateAffectation,
    origine,
    motifDerogation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppartenanceGroupeRow &&
          other.id == this.id &&
          other.fideleId == this.fideleId &&
          other.groupeId == this.groupeId &&
          other.dateAffectation == this.dateAffectation &&
          other.origine == this.origine &&
          other.motifDerogation == this.motifDerogation);
}

class AppartenancesGroupeCompanion
    extends UpdateCompanion<AppartenanceGroupeRow> {
  final Value<String> id;
  final Value<String> fideleId;
  final Value<String> groupeId;
  final Value<DateTime> dateAffectation;
  final Value<String> origine;
  final Value<String?> motifDerogation;
  final Value<int> rowid;
  const AppartenancesGroupeCompanion({
    this.id = const Value.absent(),
    this.fideleId = const Value.absent(),
    this.groupeId = const Value.absent(),
    this.dateAffectation = const Value.absent(),
    this.origine = const Value.absent(),
    this.motifDerogation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppartenancesGroupeCompanion.insert({
    required String id,
    required String fideleId,
    required String groupeId,
    required DateTime dateAffectation,
    required String origine,
    this.motifDerogation = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fideleId = Value(fideleId),
       groupeId = Value(groupeId),
       dateAffectation = Value(dateAffectation),
       origine = Value(origine);
  static Insertable<AppartenanceGroupeRow> custom({
    Expression<String>? id,
    Expression<String>? fideleId,
    Expression<String>? groupeId,
    Expression<DateTime>? dateAffectation,
    Expression<String>? origine,
    Expression<String>? motifDerogation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fideleId != null) 'fidele_id': fideleId,
      if (groupeId != null) 'groupe_id': groupeId,
      if (dateAffectation != null) 'date_affectation': dateAffectation,
      if (origine != null) 'origine': origine,
      if (motifDerogation != null) 'motif_derogation': motifDerogation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppartenancesGroupeCompanion copyWith({
    Value<String>? id,
    Value<String>? fideleId,
    Value<String>? groupeId,
    Value<DateTime>? dateAffectation,
    Value<String>? origine,
    Value<String?>? motifDerogation,
    Value<int>? rowid,
  }) {
    return AppartenancesGroupeCompanion(
      id: id ?? this.id,
      fideleId: fideleId ?? this.fideleId,
      groupeId: groupeId ?? this.groupeId,
      dateAffectation: dateAffectation ?? this.dateAffectation,
      origine: origine ?? this.origine,
      motifDerogation: motifDerogation ?? this.motifDerogation,
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
    if (groupeId.present) {
      map['groupe_id'] = Variable<String>(groupeId.value);
    }
    if (dateAffectation.present) {
      map['date_affectation'] = Variable<DateTime>(dateAffectation.value);
    }
    if (origine.present) {
      map['origine'] = Variable<String>(origine.value);
    }
    if (motifDerogation.present) {
      map['motif_derogation'] = Variable<String>(motifDerogation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppartenancesGroupeCompanion(')
          ..write('id: $id, ')
          ..write('fideleId: $fideleId, ')
          ..write('groupeId: $groupeId, ')
          ..write('dateAffectation: $dateAffectation, ')
          ..write('origine: $origine, ')
          ..write('motifDerogation: $motifDerogation, ')
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
  late final $NodeResponsablesTable nodeResponsables = $NodeResponsablesTable(
    this,
  );
  late final $LiensFamiliauxTable liensFamiliaux = $LiensFamiliauxTable(this);
  late final $HistoriqueFidelesTable historiqueFideles =
      $HistoriqueFidelesTable(this);
  late final $TuteursTable tuteurs = $TuteursTable(this);
  late final $ZonesGeographiquesTable zonesGeographiques =
      $ZonesGeographiquesTable(this);
  late final $TypesMinisteresTable typesMinisteres = $TypesMinisteresTable(
    this,
  );
  late final $MinisteresTable ministeres = $MinisteresTable(this);
  late final $AffectationsMinisteresTable affectationsMinisteres =
      $AffectationsMinisteresTable(this);
  late final $MandatsResponsablesTable mandatsResponsables =
      $MandatsResponsablesTable(this);
  late final $ActivitesMinisteresTable activitesMinisteres =
      $ActivitesMinisteresTable(this);
  late final $DonsSpirituelsTable donsSpirituels = $DonsSpirituelsTable(this);
  late final $DonsFidelesTable donsFideles = $DonsFidelesTable(this);
  late final $DonsMinisteresCompatiblesTable donsMinisteresCompatibles =
      $DonsMinisteresCompatiblesTable(this);
  late final $ProfessionsTable professions = $ProfessionsTable(this);
  late final $ProfessionsFidelesTable professionsFideles =
      $ProfessionsFidelesTable(this);
  late final $SollicitationsTable sollicitations = $SollicitationsTable(this);
  late final $GroupesEgliseTable groupesEglise = $GroupesEgliseTable(this);
  late final $AppartenancesGroupeTable appartenancesGroupe =
      $AppartenancesGroupeTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    organisationNodes,
    historiqueRattachements,
    fideles,
    nodeResponsables,
    liensFamiliaux,
    historiqueFideles,
    tuteurs,
    zonesGeographiques,
    typesMinisteres,
    ministeres,
    affectationsMinisteres,
    mandatsResponsables,
    activitesMinisteres,
    donsSpirituels,
    donsFideles,
    donsMinisteresCompatibles,
    professions,
    professionsFideles,
    sollicitations,
    groupesEglise,
    appartenancesGroupe,
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

  static MultiTypedResultKey<$NodeResponsablesTable, List<NodeResponsableRow>>
  _nodeResponsablesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.nodeResponsables,
    aliasName: 'organisation_nodes__id__node_responsables__noeud_id',
  );

  $$NodeResponsablesTableProcessedTableManager get nodeResponsablesRefs {
    final manager = $$NodeResponsablesTableTableManager(
      $_db,
      $_db.nodeResponsables,
    ).filter((f) => f.noeudId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _nodeResponsablesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MinisteresTable, List<MinistereRow>>
  _ministeresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ministeres,
    aliasName: 'organisation_nodes__id__ministeres__noeud_id',
  );

  $$MinisteresTableProcessedTableManager get ministeresRefs {
    final manager = $$MinisteresTableTableManager(
      $_db,
      $_db.ministeres,
    ).filter((f) => f.noeudId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ministeresRefsTable($_db));
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

  Expression<bool> nodeResponsablesRefs(
    Expression<bool> Function($$NodeResponsablesTableFilterComposer f) f,
  ) {
    final $$NodeResponsablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeResponsables,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeResponsablesTableFilterComposer(
            $db: $db,
            $table: $db.nodeResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ministeresRefs(
    Expression<bool> Function($$MinisteresTableFilterComposer f) f,
  ) {
    final $$MinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableFilterComposer(
            $db: $db,
            $table: $db.ministeres,
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

  Expression<T> nodeResponsablesRefs<T extends Object>(
    Expression<T> Function($$NodeResponsablesTableAnnotationComposer a) f,
  ) {
    final $$NodeResponsablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeResponsables,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeResponsablesTableAnnotationComposer(
            $db: $db,
            $table: $db.nodeResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ministeresRefs<T extends Object>(
    Expression<T> Function($$MinisteresTableAnnotationComposer a) f,
  ) {
    final $$MinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.noeudId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.ministeres,
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
          PrefetchHooks Function({
            bool fidelesRefs,
            bool nodeResponsablesRefs,
            bool ministeresRefs,
          })
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
          prefetchHooksCallback:
              ({
                fidelesRefs = false,
                nodeResponsablesRefs = false,
                ministeresRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fidelesRefs) db.fideles,
                    if (nodeResponsablesRefs) db.nodeResponsables,
                    if (ministeresRefs) db.ministeres,
                  ],
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
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.noeudId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (nodeResponsablesRefs)
                        await $_getPrefetchedData<
                          OrganisationNodeRow,
                          $OrganisationNodesTable,
                          NodeResponsableRow
                        >(
                          currentTable: table,
                          referencedTable: $$OrganisationNodesTableReferences
                              ._nodeResponsablesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganisationNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).nodeResponsablesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.noeudId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ministeresRefs)
                        await $_getPrefetchedData<
                          OrganisationNodeRow,
                          $OrganisationNodesTable,
                          MinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$OrganisationNodesTableReferences
                              ._ministeresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrganisationNodesTableReferences(
                                db,
                                table,
                                p0,
                              ).ministeresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.noeudId == item.id,
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
      PrefetchHooks Function({
        bool fidelesRefs,
        bool nodeResponsablesRefs,
        bool ministeresRefs,
      })
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

  static MultiTypedResultKey<$NodeResponsablesTable, List<NodeResponsableRow>>
  _nodeResponsablesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.nodeResponsables,
    aliasName: 'fideles__id__node_responsables__fidele_id',
  );

  $$NodeResponsablesTableProcessedTableManager get nodeResponsablesRefs {
    final manager = $$NodeResponsablesTableTableManager(
      $_db,
      $_db.nodeResponsables,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _nodeResponsablesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  static MultiTypedResultKey<
    $AffectationsMinisteresTable,
    List<AffectationMinistereRow>
  >
  _affectationsMinisteresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.affectationsMinisteres,
        aliasName: 'fideles__id__affectations_ministeres__fidele_id',
      );

  $$AffectationsMinisteresTableProcessedTableManager
  get affectationsMinisteresRefs {
    final manager = $$AffectationsMinisteresTableTableManager(
      $_db,
      $_db.affectationsMinisteres,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _affectationsMinisteresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MandatsResponsablesTable,
    List<MandatResponsableRow>
  >
  _mandatsResponsablesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mandatsResponsables,
        aliasName: 'fideles__id__mandats_responsables__fidele_id',
      );

  $$MandatsResponsablesTableProcessedTableManager get mandatsResponsablesRefs {
    final manager = $$MandatsResponsablesTableTableManager(
      $_db,
      $_db.mandatsResponsables,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mandatsResponsablesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ActivitesMinisteresTable,
    List<ActiviteMinistereRow>
  >
  _activitesCommeAuteurTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activitesMinisteres,
    aliasName: 'fideles__id__activites_ministeres__auteur_fidele_id',
  );

  $$ActivitesMinisteresTableProcessedTableManager get activitesCommeAuteur {
    final manager = $$ActivitesMinisteresTableTableManager(
      $_db,
      $_db.activitesMinisteres,
    ).filter((f) => f.auteurFideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _activitesCommeAuteurTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DonsFidelesTable, List<DonFideleRow>>
  _donsFidelesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.donsFideles,
    aliasName: 'fideles__id__dons_fideles__fidele_id',
  );

  $$DonsFidelesTableProcessedTableManager get donsFidelesRefs {
    final manager = $$DonsFidelesTableTableManager(
      $_db,
      $_db.donsFideles,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_donsFidelesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DonsFidelesTable, List<DonFideleRow>>
  _evaluationsCommeResponsableTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.donsFideles,
        aliasName: 'fideles__id__dons_fideles__responsable_suivi_id',
      );

  $$DonsFidelesTableProcessedTableManager get evaluationsCommeResponsable {
    final manager = $$DonsFidelesTableTableManager($_db, $_db.donsFideles)
        .filter(
          (f) => f.responsableSuiviId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _evaluationsCommeResponsableTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProfessionsFidelesTable,
    List<ProfessionFideleRow>
  >
  _professionsFidelesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.professionsFideles,
        aliasName: 'fideles__id__professions_fideles__fidele_id',
      );

  $$ProfessionsFidelesTableProcessedTableManager get professionsFidelesRefs {
    final manager = $$ProfessionsFidelesTableTableManager(
      $_db,
      $_db.professionsFideles,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _professionsFidelesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SollicitationsTable, List<SollicitationRow>>
  _sollicitationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sollicitations,
    aliasName: 'fideles__id__sollicitations__fidele_id',
  );

  $$SollicitationsTableProcessedTableManager get sollicitationsRefs {
    final manager = $$SollicitationsTableTableManager(
      $_db,
      $_db.sollicitations,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sollicitationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $AppartenancesGroupeTable,
    List<AppartenanceGroupeRow>
  >
  _appartenancesGroupeRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.appartenancesGroupe,
        aliasName: 'fideles__id__appartenances_groupe__fidele_id',
      );

  $$AppartenancesGroupeTableProcessedTableManager get appartenancesGroupeRefs {
    final manager = $$AppartenancesGroupeTableTableManager(
      $_db,
      $_db.appartenancesGroupe,
    ).filter((f) => f.fideleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _appartenancesGroupeRefsTable($_db),
    );
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

  Expression<bool> nodeResponsablesRefs(
    Expression<bool> Function($$NodeResponsablesTableFilterComposer f) f,
  ) {
    final $$NodeResponsablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeResponsables,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeResponsablesTableFilterComposer(
            $db: $db,
            $table: $db.nodeResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  Expression<bool> affectationsMinisteresRefs(
    Expression<bool> Function($$AffectationsMinisteresTableFilterComposer f) f,
  ) {
    final $$AffectationsMinisteresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.affectationsMinisteres,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AffectationsMinisteresTableFilterComposer(
                $db: $db,
                $table: $db.affectationsMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> mandatsResponsablesRefs(
    Expression<bool> Function($$MandatsResponsablesTableFilterComposer f) f,
  ) {
    final $$MandatsResponsablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mandatsResponsables,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MandatsResponsablesTableFilterComposer(
            $db: $db,
            $table: $db.mandatsResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activitesCommeAuteur(
    Expression<bool> Function($$ActivitesMinisteresTableFilterComposer f) f,
  ) {
    final $$ActivitesMinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activitesMinisteres,
      getReferencedColumn: (t) => t.auteurFideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitesMinisteresTableFilterComposer(
            $db: $db,
            $table: $db.activitesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> donsFidelesRefs(
    Expression<bool> Function($$DonsFidelesTableFilterComposer f) f,
  ) {
    final $$DonsFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableFilterComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> evaluationsCommeResponsable(
    Expression<bool> Function($$DonsFidelesTableFilterComposer f) f,
  ) {
    final $$DonsFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.responsableSuiviId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableFilterComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> professionsFidelesRefs(
    Expression<bool> Function($$ProfessionsFidelesTableFilterComposer f) f,
  ) {
    final $$ProfessionsFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.professionsFideles,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfessionsFidelesTableFilterComposer(
            $db: $db,
            $table: $db.professionsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sollicitationsRefs(
    Expression<bool> Function($$SollicitationsTableFilterComposer f) f,
  ) {
    final $$SollicitationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sollicitations,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SollicitationsTableFilterComposer(
            $db: $db,
            $table: $db.sollicitations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appartenancesGroupeRefs(
    Expression<bool> Function($$AppartenancesGroupeTableFilterComposer f) f,
  ) {
    final $$AppartenancesGroupeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenancesGroupe,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesGroupeTableFilterComposer(
            $db: $db,
            $table: $db.appartenancesGroupe,
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

  Expression<T> nodeResponsablesRefs<T extends Object>(
    Expression<T> Function($$NodeResponsablesTableAnnotationComposer a) f,
  ) {
    final $$NodeResponsablesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.nodeResponsables,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NodeResponsablesTableAnnotationComposer(
            $db: $db,
            $table: $db.nodeResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  Expression<T> affectationsMinisteresRefs<T extends Object>(
    Expression<T> Function($$AffectationsMinisteresTableAnnotationComposer a) f,
  ) {
    final $$AffectationsMinisteresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.affectationsMinisteres,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AffectationsMinisteresTableAnnotationComposer(
                $db: $db,
                $table: $db.affectationsMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mandatsResponsablesRefs<T extends Object>(
    Expression<T> Function($$MandatsResponsablesTableAnnotationComposer a) f,
  ) {
    final $$MandatsResponsablesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.mandatsResponsables,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MandatsResponsablesTableAnnotationComposer(
                $db: $db,
                $table: $db.mandatsResponsables,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> activitesCommeAuteur<T extends Object>(
    Expression<T> Function($$ActivitesMinisteresTableAnnotationComposer a) f,
  ) {
    final $$ActivitesMinisteresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.activitesMinisteres,
          getReferencedColumn: (t) => t.auteurFideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActivitesMinisteresTableAnnotationComposer(
                $db: $db,
                $table: $db.activitesMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> donsFidelesRefs<T extends Object>(
    Expression<T> Function($$DonsFidelesTableAnnotationComposer a) f,
  ) {
    final $$DonsFidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> evaluationsCommeResponsable<T extends Object>(
    Expression<T> Function($$DonsFidelesTableAnnotationComposer a) f,
  ) {
    final $$DonsFidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.responsableSuiviId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> professionsFidelesRefs<T extends Object>(
    Expression<T> Function($$ProfessionsFidelesTableAnnotationComposer a) f,
  ) {
    final $$ProfessionsFidelesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.professionsFideles,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProfessionsFidelesTableAnnotationComposer(
                $db: $db,
                $table: $db.professionsFideles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> sollicitationsRefs<T extends Object>(
    Expression<T> Function($$SollicitationsTableAnnotationComposer a) f,
  ) {
    final $$SollicitationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sollicitations,
      getReferencedColumn: (t) => t.fideleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SollicitationsTableAnnotationComposer(
            $db: $db,
            $table: $db.sollicitations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appartenancesGroupeRefs<T extends Object>(
    Expression<T> Function($$AppartenancesGroupeTableAnnotationComposer a) f,
  ) {
    final $$AppartenancesGroupeTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.appartenancesGroupe,
          getReferencedColumn: (t) => t.fideleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AppartenancesGroupeTableAnnotationComposer(
                $db: $db,
                $table: $db.appartenancesGroupe,
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
            bool nodeResponsablesRefs,
            bool liensCommeFidele1,
            bool liensCommeFidele2,
            bool historiqueFidelesRefs,
            bool tuteursCommeMineur,
            bool tuteursCommeTuteur,
            bool affectationsMinisteresRefs,
            bool mandatsResponsablesRefs,
            bool activitesCommeAuteur,
            bool donsFidelesRefs,
            bool evaluationsCommeResponsable,
            bool professionsFidelesRefs,
            bool sollicitationsRefs,
            bool appartenancesGroupeRefs,
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
                nodeResponsablesRefs = false,
                liensCommeFidele1 = false,
                liensCommeFidele2 = false,
                historiqueFidelesRefs = false,
                tuteursCommeMineur = false,
                tuteursCommeTuteur = false,
                affectationsMinisteresRefs = false,
                mandatsResponsablesRefs = false,
                activitesCommeAuteur = false,
                donsFidelesRefs = false,
                evaluationsCommeResponsable = false,
                professionsFidelesRefs = false,
                sollicitationsRefs = false,
                appartenancesGroupeRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (nodeResponsablesRefs) db.nodeResponsables,
                    if (liensCommeFidele1) db.liensFamiliaux,
                    if (liensCommeFidele2) db.liensFamiliaux,
                    if (historiqueFidelesRefs) db.historiqueFideles,
                    if (tuteursCommeMineur) db.tuteurs,
                    if (tuteursCommeTuteur) db.tuteurs,
                    if (affectationsMinisteresRefs) db.affectationsMinisteres,
                    if (mandatsResponsablesRefs) db.mandatsResponsables,
                    if (activitesCommeAuteur) db.activitesMinisteres,
                    if (donsFidelesRefs) db.donsFideles,
                    if (evaluationsCommeResponsable) db.donsFideles,
                    if (professionsFidelesRefs) db.professionsFideles,
                    if (sollicitationsRefs) db.sollicitations,
                    if (appartenancesGroupeRefs) db.appartenancesGroupe,
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
                      if (nodeResponsablesRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          NodeResponsableRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._nodeResponsablesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).nodeResponsablesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
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
                      if (affectationsMinisteresRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          AffectationMinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._affectationsMinisteresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).affectationsMinisteresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mandatsResponsablesRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          MandatResponsableRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._mandatsResponsablesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).mandatsResponsablesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activitesCommeAuteur)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          ActiviteMinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._activitesCommeAuteurTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).activitesCommeAuteur,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.auteurFideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (donsFidelesRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          DonFideleRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._donsFidelesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).donsFidelesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (evaluationsCommeResponsable)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          DonFideleRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._evaluationsCommeResponsableTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).evaluationsCommeResponsable,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.responsableSuiviId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (professionsFidelesRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          ProfessionFideleRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._professionsFidelesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).professionsFidelesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sollicitationsRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          SollicitationRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._sollicitationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).sollicitationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (appartenancesGroupeRefs)
                        await $_getPrefetchedData<
                          FideleRow,
                          $FidelesTable,
                          AppartenanceGroupeRow
                        >(
                          currentTable: table,
                          referencedTable: $$FidelesTableReferences
                              ._appartenancesGroupeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FidelesTableReferences(
                                db,
                                table,
                                p0,
                              ).appartenancesGroupeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fideleId == item.id,
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
        bool nodeResponsablesRefs,
        bool liensCommeFidele1,
        bool liensCommeFidele2,
        bool historiqueFidelesRefs,
        bool tuteursCommeMineur,
        bool tuteursCommeTuteur,
        bool affectationsMinisteresRefs,
        bool mandatsResponsablesRefs,
        bool activitesCommeAuteur,
        bool donsFidelesRefs,
        bool evaluationsCommeResponsable,
        bool professionsFidelesRefs,
        bool sollicitationsRefs,
        bool appartenancesGroupeRefs,
      })
    >;
typedef $$NodeResponsablesTableCreateCompanionBuilder =
    NodeResponsablesCompanion Function({
      required String id,
      required String noeudId,
      required String fideleId,
      required String fonction,
      required DateTime dateDebut,
      Value<DateTime?> dateFin,
      Value<int> rowid,
    });
typedef $$NodeResponsablesTableUpdateCompanionBuilder =
    NodeResponsablesCompanion Function({
      Value<String> id,
      Value<String> noeudId,
      Value<String> fideleId,
      Value<String> fonction,
      Value<DateTime> dateDebut,
      Value<DateTime?> dateFin,
      Value<int> rowid,
    });

final class $$NodeResponsablesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NodeResponsablesTable,
          NodeResponsableRow
        > {
  $$NodeResponsablesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrganisationNodesTable _noeudIdTable(_$AppDatabase db) => db
      .organisationNodes
      .createAlias('node_responsables__noeud_id__organisation_nodes__id');

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

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('node_responsables__fidele_id__fideles__id');

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

class $$NodeResponsablesTableFilterComposer
    extends Composer<_$AppDatabase, $NodeResponsablesTable> {
  $$NodeResponsablesTableFilterComposer({
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

  ColumnFilters<String> get fonction => $composableBuilder(
    column: $table.fonction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
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

class $$NodeResponsablesTableOrderingComposer
    extends Composer<_$AppDatabase, $NodeResponsablesTable> {
  $$NodeResponsablesTableOrderingComposer({
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

  ColumnOrderings<String> get fonction => $composableBuilder(
    column: $table.fonction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
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

class $$NodeResponsablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NodeResponsablesTable> {
  $$NodeResponsablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fonction =>
      $composableBuilder(column: $table.fonction, builder: (column) => column);

  GeneratedColumn<DateTime> get dateDebut =>
      $composableBuilder(column: $table.dateDebut, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFin =>
      $composableBuilder(column: $table.dateFin, builder: (column) => column);

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

class $$NodeResponsablesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NodeResponsablesTable,
          NodeResponsableRow,
          $$NodeResponsablesTableFilterComposer,
          $$NodeResponsablesTableOrderingComposer,
          $$NodeResponsablesTableAnnotationComposer,
          $$NodeResponsablesTableCreateCompanionBuilder,
          $$NodeResponsablesTableUpdateCompanionBuilder,
          (NodeResponsableRow, $$NodeResponsablesTableReferences),
          NodeResponsableRow,
          PrefetchHooks Function({bool noeudId, bool fideleId})
        > {
  $$NodeResponsablesTableTableManager(
    _$AppDatabase db,
    $NodeResponsablesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NodeResponsablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NodeResponsablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NodeResponsablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> noeudId = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> fonction = const Value.absent(),
                Value<DateTime> dateDebut = const Value.absent(),
                Value<DateTime?> dateFin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NodeResponsablesCompanion(
                id: id,
                noeudId: noeudId,
                fideleId: fideleId,
                fonction: fonction,
                dateDebut: dateDebut,
                dateFin: dateFin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String noeudId,
                required String fideleId,
                required String fonction,
                required DateTime dateDebut,
                Value<DateTime?> dateFin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NodeResponsablesCompanion.insert(
                id: id,
                noeudId: noeudId,
                fideleId: fideleId,
                fonction: fonction,
                dateDebut: dateDebut,
                dateFin: dateFin,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NodeResponsablesTable, NodeResponsableRow>(
                    table,
                  ),
                  $$NodeResponsablesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({noeudId = false, fideleId = false}) {
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
                    if (noeudId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.noeudId,
                                referencedTable:
                                    $$NodeResponsablesTableReferences
                                        ._noeudIdTable(db),
                                referencedColumn:
                                    $$NodeResponsablesTableReferences
                                        ._noeudIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fideleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId,
                                referencedTable:
                                    $$NodeResponsablesTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$NodeResponsablesTableReferences
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

typedef $$NodeResponsablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NodeResponsablesTable,
      NodeResponsableRow,
      $$NodeResponsablesTableFilterComposer,
      $$NodeResponsablesTableOrderingComposer,
      $$NodeResponsablesTableAnnotationComposer,
      $$NodeResponsablesTableCreateCompanionBuilder,
      $$NodeResponsablesTableUpdateCompanionBuilder,
      (NodeResponsableRow, $$NodeResponsablesTableReferences),
      NodeResponsableRow,
      PrefetchHooks Function({bool noeudId, bool fideleId})
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
typedef $$ZonesGeographiquesTableCreateCompanionBuilder =
    ZonesGeographiquesCompanion Function({
      required String id,
      required String libelle,
      required int niveau,
      Value<String?> parentId,
      Value<String> statut,
      Value<int> rowid,
    });
typedef $$ZonesGeographiquesTableUpdateCompanionBuilder =
    ZonesGeographiquesCompanion Function({
      Value<String> id,
      Value<String> libelle,
      Value<int> niveau,
      Value<String?> parentId,
      Value<String> statut,
      Value<int> rowid,
    });

final class $$ZonesGeographiquesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ZonesGeographiquesTable,
          ZoneGeographiqueRow
        > {
  $$ZonesGeographiquesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ZonesGeographiquesTable _parentIdTable(_$AppDatabase db) => db
      .zonesGeographiques
      .createAlias('zones_geographiques__parent_id__zones_geographiques__id');

  $$ZonesGeographiquesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$ZonesGeographiquesTableTableManager(
      $_db,
      $_db.zonesGeographiques,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ZonesGeographiquesTableFilterComposer
    extends Composer<_$AppDatabase, $ZonesGeographiquesTable> {
  $$ZonesGeographiquesTableFilterComposer({
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

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  $$ZonesGeographiquesTableFilterComposer get parentId {
    final $$ZonesGeographiquesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.zonesGeographiques,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesGeographiquesTableFilterComposer(
            $db: $db,
            $table: $db.zonesGeographiques,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ZonesGeographiquesTableOrderingComposer
    extends Composer<_$AppDatabase, $ZonesGeographiquesTable> {
  $$ZonesGeographiquesTableOrderingComposer({
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

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  $$ZonesGeographiquesTableOrderingComposer get parentId {
    final $$ZonesGeographiquesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.zonesGeographiques,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonesGeographiquesTableOrderingComposer(
            $db: $db,
            $table: $db.zonesGeographiques,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ZonesGeographiquesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ZonesGeographiquesTable> {
  $$ZonesGeographiquesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<int> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  $$ZonesGeographiquesTableAnnotationComposer get parentId {
    final $$ZonesGeographiquesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.parentId,
          referencedTable: $db.zonesGeographiques,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ZonesGeographiquesTableAnnotationComposer(
                $db: $db,
                $table: $db.zonesGeographiques,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ZonesGeographiquesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ZonesGeographiquesTable,
          ZoneGeographiqueRow,
          $$ZonesGeographiquesTableFilterComposer,
          $$ZonesGeographiquesTableOrderingComposer,
          $$ZonesGeographiquesTableAnnotationComposer,
          $$ZonesGeographiquesTableCreateCompanionBuilder,
          $$ZonesGeographiquesTableUpdateCompanionBuilder,
          (ZoneGeographiqueRow, $$ZonesGeographiquesTableReferences),
          ZoneGeographiqueRow,
          PrefetchHooks Function({bool parentId})
        > {
  $$ZonesGeographiquesTableTableManager(
    _$AppDatabase db,
    $ZonesGeographiquesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ZonesGeographiquesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ZonesGeographiquesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ZonesGeographiquesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<int> niveau = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ZonesGeographiquesCompanion(
                id: id,
                libelle: libelle,
                niveau: niveau,
                parentId: parentId,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String libelle,
                required int niveau,
                Value<String?> parentId = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ZonesGeographiquesCompanion.insert(
                id: id,
                libelle: libelle,
                niveau: niveau,
                parentId: parentId,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ZonesGeographiquesTable, ZoneGeographiqueRow>(
                    table,
                  ),
                  $$ZonesGeographiquesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentId = false}) {
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
                    if (parentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentId,
                                referencedTable:
                                    $$ZonesGeographiquesTableReferences
                                        ._parentIdTable(db),
                                referencedColumn:
                                    $$ZonesGeographiquesTableReferences
                                        ._parentIdTable(db)
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

typedef $$ZonesGeographiquesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ZonesGeographiquesTable,
      ZoneGeographiqueRow,
      $$ZonesGeographiquesTableFilterComposer,
      $$ZonesGeographiquesTableOrderingComposer,
      $$ZonesGeographiquesTableAnnotationComposer,
      $$ZonesGeographiquesTableCreateCompanionBuilder,
      $$ZonesGeographiquesTableUpdateCompanionBuilder,
      (ZoneGeographiqueRow, $$ZonesGeographiquesTableReferences),
      ZoneGeographiqueRow,
      PrefetchHooks Function({bool parentId})
    >;
typedef $$TypesMinisteresTableCreateCompanionBuilder =
    TypesMinisteresCompanion Function({
      required String id,
      required String code,
      required String libelle,
      Value<bool> standard,
      Value<String> statut,
      Value<int> rowid,
    });
typedef $$TypesMinisteresTableUpdateCompanionBuilder =
    TypesMinisteresCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> libelle,
      Value<bool> standard,
      Value<String> statut,
      Value<int> rowid,
    });

final class $$TypesMinisteresTableReferences
    extends
        BaseReferences<_$AppDatabase, $TypesMinisteresTable, TypeMinistereRow> {
  $$TypesMinisteresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MinisteresTable, List<MinistereRow>>
  _ministeresRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ministeres,
    aliasName: 'types_ministeres__id__ministeres__type_ministere_id',
  );

  $$MinisteresTableProcessedTableManager get ministeresRefs {
    final manager = $$MinisteresTableTableManager($_db, $_db.ministeres).filter(
      (f) => f.typeMinistereId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_ministeresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DonsMinisteresCompatiblesTable,
    List<DonMinistereCompatibleRow>
  >
  _donsMinisteresCompatiblesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.donsMinisteresCompatibles,
    aliasName:
        'types_ministeres__id__dons_ministeres_compatibles__type_ministere_id',
  );

  $$DonsMinisteresCompatiblesTableProcessedTableManager
  get donsMinisteresCompatiblesRefs {
    final manager =
        $$DonsMinisteresCompatiblesTableTableManager(
          $_db,
          $_db.donsMinisteresCompatibles,
        ).filter(
          (f) => f.typeMinistereId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _donsMinisteresCompatiblesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesMinisteresTableFilterComposer
    extends Composer<_$AppDatabase, $TypesMinisteresTable> {
  $$TypesMinisteresTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get standard => $composableBuilder(
    column: $table.standard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ministeresRefs(
    Expression<bool> Function($$MinisteresTableFilterComposer f) f,
  ) {
    final $$MinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.typeMinistereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableFilterComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> donsMinisteresCompatiblesRefs(
    Expression<bool> Function($$DonsMinisteresCompatiblesTableFilterComposer f)
    f,
  ) {
    final $$DonsMinisteresCompatiblesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.donsMinisteresCompatibles,
          getReferencedColumn: (t) => t.typeMinistereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DonsMinisteresCompatiblesTableFilterComposer(
                $db: $db,
                $table: $db.donsMinisteresCompatibles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TypesMinisteresTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesMinisteresTable> {
  $$TypesMinisteresTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get standard => $composableBuilder(
    column: $table.standard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesMinisteresTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesMinisteresTable> {
  $$TypesMinisteresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<bool> get standard =>
      $composableBuilder(column: $table.standard, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  Expression<T> ministeresRefs<T extends Object>(
    Expression<T> Function($$MinisteresTableAnnotationComposer a) f,
  ) {
    final $$MinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.typeMinistereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> donsMinisteresCompatiblesRefs<T extends Object>(
    Expression<T> Function($$DonsMinisteresCompatiblesTableAnnotationComposer a)
    f,
  ) {
    final $$DonsMinisteresCompatiblesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.donsMinisteresCompatibles,
          getReferencedColumn: (t) => t.typeMinistereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DonsMinisteresCompatiblesTableAnnotationComposer(
                $db: $db,
                $table: $db.donsMinisteresCompatibles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TypesMinisteresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesMinisteresTable,
          TypeMinistereRow,
          $$TypesMinisteresTableFilterComposer,
          $$TypesMinisteresTableOrderingComposer,
          $$TypesMinisteresTableAnnotationComposer,
          $$TypesMinisteresTableCreateCompanionBuilder,
          $$TypesMinisteresTableUpdateCompanionBuilder,
          (TypeMinistereRow, $$TypesMinisteresTableReferences),
          TypeMinistereRow,
          PrefetchHooks Function({
            bool ministeresRefs,
            bool donsMinisteresCompatiblesRefs,
          })
        > {
  $$TypesMinisteresTableTableManager(
    _$AppDatabase db,
    $TypesMinisteresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesMinisteresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesMinisteresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesMinisteresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<bool> standard = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypesMinisteresCompanion(
                id: id,
                code: code,
                libelle: libelle,
                standard: standard,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String libelle,
                Value<bool> standard = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TypesMinisteresCompanion.insert(
                id: id,
                code: code,
                libelle: libelle,
                standard: standard,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypesMinisteresTable, TypeMinistereRow>(table),
                  $$TypesMinisteresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ministeresRefs = false,
                donsMinisteresCompatiblesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ministeresRefs) db.ministeres,
                    if (donsMinisteresCompatiblesRefs)
                      db.donsMinisteresCompatibles,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ministeresRefs)
                        await $_getPrefetchedData<
                          TypeMinistereRow,
                          $TypesMinisteresTable,
                          MinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$TypesMinisteresTableReferences
                              ._ministeresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesMinisteresTableReferences(
                                db,
                                table,
                                p0,
                              ).ministeresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.typeMinistereId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (donsMinisteresCompatiblesRefs)
                        await $_getPrefetchedData<
                          TypeMinistereRow,
                          $TypesMinisteresTable,
                          DonMinistereCompatibleRow
                        >(
                          currentTable: table,
                          referencedTable: $$TypesMinisteresTableReferences
                              ._donsMinisteresCompatiblesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesMinisteresTableReferences(
                                db,
                                table,
                                p0,
                              ).donsMinisteresCompatiblesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.typeMinistereId == item.id,
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

typedef $$TypesMinisteresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesMinisteresTable,
      TypeMinistereRow,
      $$TypesMinisteresTableFilterComposer,
      $$TypesMinisteresTableOrderingComposer,
      $$TypesMinisteresTableAnnotationComposer,
      $$TypesMinisteresTableCreateCompanionBuilder,
      $$TypesMinisteresTableUpdateCompanionBuilder,
      (TypeMinistereRow, $$TypesMinisteresTableReferences),
      TypeMinistereRow,
      PrefetchHooks Function({
        bool ministeresRefs,
        bool donsMinisteresCompatiblesRefs,
      })
    >;
typedef $$MinisteresTableCreateCompanionBuilder =
    MinisteresCompanion Function({
      required String id,
      required String noeudId,
      required String typeMinistereId,
      required String nom,
      required DateTime dateCreation,
      Value<String> statut,
      Value<int> rowid,
    });
typedef $$MinisteresTableUpdateCompanionBuilder =
    MinisteresCompanion Function({
      Value<String> id,
      Value<String> noeudId,
      Value<String> typeMinistereId,
      Value<String> nom,
      Value<DateTime> dateCreation,
      Value<String> statut,
      Value<int> rowid,
    });

final class $$MinisteresTableReferences
    extends BaseReferences<_$AppDatabase, $MinisteresTable, MinistereRow> {
  $$MinisteresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrganisationNodesTable _noeudIdTable(_$AppDatabase db) => db
      .organisationNodes
      .createAlias('ministeres__noeud_id__organisation_nodes__id');

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

  static $TypesMinisteresTable _typeMinistereIdTable(_$AppDatabase db) => db
      .typesMinisteres
      .createAlias('ministeres__type_ministere_id__types_ministeres__id');

  $$TypesMinisteresTableProcessedTableManager get typeMinistereId {
    final $_column = $_itemColumn<String>('type_ministere_id')!;

    final manager = $$TypesMinisteresTableTableManager(
      $_db,
      $_db.typesMinisteres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeMinistereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $AffectationsMinisteresTable,
    List<AffectationMinistereRow>
  >
  _affectationsMinisteresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.affectationsMinisteres,
        aliasName: 'ministeres__id__affectations_ministeres__ministere_id',
      );

  $$AffectationsMinisteresTableProcessedTableManager
  get affectationsMinisteresRefs {
    final manager = $$AffectationsMinisteresTableTableManager(
      $_db,
      $_db.affectationsMinisteres,
    ).filter((f) => f.ministereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _affectationsMinisteresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MandatsResponsablesTable,
    List<MandatResponsableRow>
  >
  _mandatsResponsablesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mandatsResponsables,
        aliasName: 'ministeres__id__mandats_responsables__ministere_id',
      );

  $$MandatsResponsablesTableProcessedTableManager get mandatsResponsablesRefs {
    final manager = $$MandatsResponsablesTableTableManager(
      $_db,
      $_db.mandatsResponsables,
    ).filter((f) => f.ministereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mandatsResponsablesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ActivitesMinisteresTable,
    List<ActiviteMinistereRow>
  >
  _activitesMinisteresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.activitesMinisteres,
        aliasName: 'ministeres__id__activites_ministeres__ministere_id',
      );

  $$ActivitesMinisteresTableProcessedTableManager get activitesMinisteresRefs {
    final manager = $$ActivitesMinisteresTableTableManager(
      $_db,
      $_db.activitesMinisteres,
    ).filter((f) => f.ministereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _activitesMinisteresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MinisteresTableFilterComposer
    extends Composer<_$AppDatabase, $MinisteresTable> {
  $$MinisteresTableFilterComposer({
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

  ColumnFilters<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
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

  $$TypesMinisteresTableFilterComposer get typeMinistereId {
    final $$TypesMinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableFilterComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> affectationsMinisteresRefs(
    Expression<bool> Function($$AffectationsMinisteresTableFilterComposer f) f,
  ) {
    final $$AffectationsMinisteresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.affectationsMinisteres,
          getReferencedColumn: (t) => t.ministereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AffectationsMinisteresTableFilterComposer(
                $db: $db,
                $table: $db.affectationsMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> mandatsResponsablesRefs(
    Expression<bool> Function($$MandatsResponsablesTableFilterComposer f) f,
  ) {
    final $$MandatsResponsablesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mandatsResponsables,
      getReferencedColumn: (t) => t.ministereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MandatsResponsablesTableFilterComposer(
            $db: $db,
            $table: $db.mandatsResponsables,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activitesMinisteresRefs(
    Expression<bool> Function($$ActivitesMinisteresTableFilterComposer f) f,
  ) {
    final $$ActivitesMinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activitesMinisteres,
      getReferencedColumn: (t) => t.ministereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitesMinisteresTableFilterComposer(
            $db: $db,
            $table: $db.activitesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MinisteresTableOrderingComposer
    extends Composer<_$AppDatabase, $MinisteresTable> {
  $$MinisteresTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
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

  $$TypesMinisteresTableOrderingComposer get typeMinistereId {
    final $$TypesMinisteresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableOrderingComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MinisteresTableAnnotationComposer
    extends Composer<_$AppDatabase, $MinisteresTable> {
  $$MinisteresTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get dateCreation => $composableBuilder(
    column: $table.dateCreation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

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

  $$TypesMinisteresTableAnnotationComposer get typeMinistereId {
    final $$TypesMinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> affectationsMinisteresRefs<T extends Object>(
    Expression<T> Function($$AffectationsMinisteresTableAnnotationComposer a) f,
  ) {
    final $$AffectationsMinisteresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.affectationsMinisteres,
          getReferencedColumn: (t) => t.ministereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AffectationsMinisteresTableAnnotationComposer(
                $db: $db,
                $table: $db.affectationsMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mandatsResponsablesRefs<T extends Object>(
    Expression<T> Function($$MandatsResponsablesTableAnnotationComposer a) f,
  ) {
    final $$MandatsResponsablesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.mandatsResponsables,
          getReferencedColumn: (t) => t.ministereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MandatsResponsablesTableAnnotationComposer(
                $db: $db,
                $table: $db.mandatsResponsables,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> activitesMinisteresRefs<T extends Object>(
    Expression<T> Function($$ActivitesMinisteresTableAnnotationComposer a) f,
  ) {
    final $$ActivitesMinisteresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.activitesMinisteres,
          getReferencedColumn: (t) => t.ministereId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ActivitesMinisteresTableAnnotationComposer(
                $db: $db,
                $table: $db.activitesMinisteres,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MinisteresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MinisteresTable,
          MinistereRow,
          $$MinisteresTableFilterComposer,
          $$MinisteresTableOrderingComposer,
          $$MinisteresTableAnnotationComposer,
          $$MinisteresTableCreateCompanionBuilder,
          $$MinisteresTableUpdateCompanionBuilder,
          (MinistereRow, $$MinisteresTableReferences),
          MinistereRow,
          PrefetchHooks Function({
            bool noeudId,
            bool typeMinistereId,
            bool affectationsMinisteresRefs,
            bool mandatsResponsablesRefs,
            bool activitesMinisteresRefs,
          })
        > {
  $$MinisteresTableTableManager(_$AppDatabase db, $MinisteresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MinisteresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MinisteresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MinisteresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> noeudId = const Value.absent(),
                Value<String> typeMinistereId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<DateTime> dateCreation = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MinisteresCompanion(
                id: id,
                noeudId: noeudId,
                typeMinistereId: typeMinistereId,
                nom: nom,
                dateCreation: dateCreation,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String noeudId,
                required String typeMinistereId,
                required String nom,
                required DateTime dateCreation,
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MinisteresCompanion.insert(
                id: id,
                noeudId: noeudId,
                typeMinistereId: typeMinistereId,
                nom: nom,
                dateCreation: dateCreation,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MinisteresTable, MinistereRow>(table),
                  $$MinisteresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                noeudId = false,
                typeMinistereId = false,
                affectationsMinisteresRefs = false,
                mandatsResponsablesRefs = false,
                activitesMinisteresRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (affectationsMinisteresRefs) db.affectationsMinisteres,
                    if (mandatsResponsablesRefs) db.mandatsResponsables,
                    if (activitesMinisteresRefs) db.activitesMinisteres,
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
                                    referencedTable: $$MinisteresTableReferences
                                        ._noeudIdTable(db),
                                    referencedColumn:
                                        $$MinisteresTableReferences
                                            ._noeudIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (typeMinistereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.typeMinistereId,
                                    referencedTable: $$MinisteresTableReferences
                                        ._typeMinistereIdTable(db),
                                    referencedColumn:
                                        $$MinisteresTableReferences
                                            ._typeMinistereIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (affectationsMinisteresRefs)
                        await $_getPrefetchedData<
                          MinistereRow,
                          $MinisteresTable,
                          AffectationMinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$MinisteresTableReferences
                              ._affectationsMinisteresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MinisteresTableReferences(
                                db,
                                table,
                                p0,
                              ).affectationsMinisteresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ministereId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mandatsResponsablesRefs)
                        await $_getPrefetchedData<
                          MinistereRow,
                          $MinisteresTable,
                          MandatResponsableRow
                        >(
                          currentTable: table,
                          referencedTable: $$MinisteresTableReferences
                              ._mandatsResponsablesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MinisteresTableReferences(
                                db,
                                table,
                                p0,
                              ).mandatsResponsablesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ministereId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (activitesMinisteresRefs)
                        await $_getPrefetchedData<
                          MinistereRow,
                          $MinisteresTable,
                          ActiviteMinistereRow
                        >(
                          currentTable: table,
                          referencedTable: $$MinisteresTableReferences
                              ._activitesMinisteresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MinisteresTableReferences(
                                db,
                                table,
                                p0,
                              ).activitesMinisteresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ministereId == item.id,
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

typedef $$MinisteresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MinisteresTable,
      MinistereRow,
      $$MinisteresTableFilterComposer,
      $$MinisteresTableOrderingComposer,
      $$MinisteresTableAnnotationComposer,
      $$MinisteresTableCreateCompanionBuilder,
      $$MinisteresTableUpdateCompanionBuilder,
      (MinistereRow, $$MinisteresTableReferences),
      MinistereRow,
      PrefetchHooks Function({
        bool noeudId,
        bool typeMinistereId,
        bool affectationsMinisteresRefs,
        bool mandatsResponsablesRefs,
        bool activitesMinisteresRefs,
      })
    >;
typedef $$AffectationsMinisteresTableCreateCompanionBuilder =
    AffectationsMinisteresCompanion Function({
      required String id,
      required String ministereId,
      required String fideleId,
      required String role,
      required DateTime dateDebut,
      Value<DateTime?> dateFin,
      Value<String> statut,
      Value<int> rowid,
    });
typedef $$AffectationsMinisteresTableUpdateCompanionBuilder =
    AffectationsMinisteresCompanion Function({
      Value<String> id,
      Value<String> ministereId,
      Value<String> fideleId,
      Value<String> role,
      Value<DateTime> dateDebut,
      Value<DateTime?> dateFin,
      Value<String> statut,
      Value<int> rowid,
    });

final class $$AffectationsMinisteresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AffectationsMinisteresTable,
          AffectationMinistereRow
        > {
  $$AffectationsMinisteresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MinisteresTable _ministereIdTable(_$AppDatabase db) => db.ministeres
      .createAlias('affectations_ministeres__ministere_id__ministeres__id');

  $$MinisteresTableProcessedTableManager get ministereId {
    final $_column = $_itemColumn<String>('ministere_id')!;

    final manager = $$MinisteresTableTableManager(
      $_db,
      $_db.ministeres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ministereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('affectations_ministeres__fidele_id__fideles__id');

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

class $$AffectationsMinisteresTableFilterComposer
    extends Composer<_$AppDatabase, $AffectationsMinisteresTable> {
  $$AffectationsMinisteresTableFilterComposer({
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

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  $$MinisteresTableFilterComposer get ministereId {
    final $$MinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableFilterComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$AffectationsMinisteresTableOrderingComposer
    extends Composer<_$AppDatabase, $AffectationsMinisteresTable> {
  $$AffectationsMinisteresTableOrderingComposer({
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

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  $$MinisteresTableOrderingComposer get ministereId {
    final $$MinisteresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableOrderingComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$AffectationsMinisteresTableAnnotationComposer
    extends Composer<_$AppDatabase, $AffectationsMinisteresTable> {
  $$AffectationsMinisteresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get dateDebut =>
      $composableBuilder(column: $table.dateDebut, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFin =>
      $composableBuilder(column: $table.dateFin, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  $$MinisteresTableAnnotationComposer get ministereId {
    final $$MinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$AffectationsMinisteresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AffectationsMinisteresTable,
          AffectationMinistereRow,
          $$AffectationsMinisteresTableFilterComposer,
          $$AffectationsMinisteresTableOrderingComposer,
          $$AffectationsMinisteresTableAnnotationComposer,
          $$AffectationsMinisteresTableCreateCompanionBuilder,
          $$AffectationsMinisteresTableUpdateCompanionBuilder,
          (AffectationMinistereRow, $$AffectationsMinisteresTableReferences),
          AffectationMinistereRow,
          PrefetchHooks Function({bool ministereId, bool fideleId})
        > {
  $$AffectationsMinisteresTableTableManager(
    _$AppDatabase db,
    $AffectationsMinisteresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AffectationsMinisteresTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AffectationsMinisteresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AffectationsMinisteresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ministereId = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> dateDebut = const Value.absent(),
                Value<DateTime?> dateFin = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AffectationsMinisteresCompanion(
                id: id,
                ministereId: ministereId,
                fideleId: fideleId,
                role: role,
                dateDebut: dateDebut,
                dateFin: dateFin,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ministereId,
                required String fideleId,
                required String role,
                required DateTime dateDebut,
                Value<DateTime?> dateFin = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AffectationsMinisteresCompanion.insert(
                id: id,
                ministereId: ministereId,
                fideleId: fideleId,
                role: role,
                dateDebut: dateDebut,
                dateFin: dateFin,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $AffectationsMinisteresTable,
                    AffectationMinistereRow
                  >(table),
                  $$AffectationsMinisteresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ministereId = false, fideleId = false}) {
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
                    if (ministereId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ministereId,
                                referencedTable:
                                    $$AffectationsMinisteresTableReferences
                                        ._ministereIdTable(db),
                                referencedColumn:
                                    $$AffectationsMinisteresTableReferences
                                        ._ministereIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fideleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId,
                                referencedTable:
                                    $$AffectationsMinisteresTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$AffectationsMinisteresTableReferences
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

typedef $$AffectationsMinisteresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AffectationsMinisteresTable,
      AffectationMinistereRow,
      $$AffectationsMinisteresTableFilterComposer,
      $$AffectationsMinisteresTableOrderingComposer,
      $$AffectationsMinisteresTableAnnotationComposer,
      $$AffectationsMinisteresTableCreateCompanionBuilder,
      $$AffectationsMinisteresTableUpdateCompanionBuilder,
      (AffectationMinistereRow, $$AffectationsMinisteresTableReferences),
      AffectationMinistereRow,
      PrefetchHooks Function({bool ministereId, bool fideleId})
    >;
typedef $$MandatsResponsablesTableCreateCompanionBuilder =
    MandatsResponsablesCompanion Function({
      required String id,
      required String ministereId,
      required String fideleId,
      required DateTime dateDebut,
      Value<DateTime?> dateFinPrevue,
      Value<DateTime?> dateFinReelle,
      Value<int> rowid,
    });
typedef $$MandatsResponsablesTableUpdateCompanionBuilder =
    MandatsResponsablesCompanion Function({
      Value<String> id,
      Value<String> ministereId,
      Value<String> fideleId,
      Value<DateTime> dateDebut,
      Value<DateTime?> dateFinPrevue,
      Value<DateTime?> dateFinReelle,
      Value<int> rowid,
    });

final class $$MandatsResponsablesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MandatsResponsablesTable,
          MandatResponsableRow
        > {
  $$MandatsResponsablesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MinisteresTable _ministereIdTable(_$AppDatabase db) => db.ministeres
      .createAlias('mandats_responsables__ministere_id__ministeres__id');

  $$MinisteresTableProcessedTableManager get ministereId {
    final $_column = $_itemColumn<String>('ministere_id')!;

    final manager = $$MinisteresTableTableManager(
      $_db,
      $_db.ministeres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ministereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('mandats_responsables__fidele_id__fideles__id');

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

class $$MandatsResponsablesTableFilterComposer
    extends Composer<_$AppDatabase, $MandatsResponsablesTable> {
  $$MandatsResponsablesTableFilterComposer({
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

  ColumnFilters<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFinPrevue => $composableBuilder(
    column: $table.dateFinPrevue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFinReelle => $composableBuilder(
    column: $table.dateFinReelle,
    builder: (column) => ColumnFilters(column),
  );

  $$MinisteresTableFilterComposer get ministereId {
    final $$MinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableFilterComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$MandatsResponsablesTableOrderingComposer
    extends Composer<_$AppDatabase, $MandatsResponsablesTable> {
  $$MandatsResponsablesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFinPrevue => $composableBuilder(
    column: $table.dateFinPrevue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFinReelle => $composableBuilder(
    column: $table.dateFinReelle,
    builder: (column) => ColumnOrderings(column),
  );

  $$MinisteresTableOrderingComposer get ministereId {
    final $$MinisteresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableOrderingComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$MandatsResponsablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MandatsResponsablesTable> {
  $$MandatsResponsablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateDebut =>
      $composableBuilder(column: $table.dateDebut, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFinPrevue => $composableBuilder(
    column: $table.dateFinPrevue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateFinReelle => $composableBuilder(
    column: $table.dateFinReelle,
    builder: (column) => column,
  );

  $$MinisteresTableAnnotationComposer get ministereId {
    final $$MinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$MandatsResponsablesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MandatsResponsablesTable,
          MandatResponsableRow,
          $$MandatsResponsablesTableFilterComposer,
          $$MandatsResponsablesTableOrderingComposer,
          $$MandatsResponsablesTableAnnotationComposer,
          $$MandatsResponsablesTableCreateCompanionBuilder,
          $$MandatsResponsablesTableUpdateCompanionBuilder,
          (MandatResponsableRow, $$MandatsResponsablesTableReferences),
          MandatResponsableRow,
          PrefetchHooks Function({bool ministereId, bool fideleId})
        > {
  $$MandatsResponsablesTableTableManager(
    _$AppDatabase db,
    $MandatsResponsablesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MandatsResponsablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MandatsResponsablesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MandatsResponsablesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ministereId = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<DateTime> dateDebut = const Value.absent(),
                Value<DateTime?> dateFinPrevue = const Value.absent(),
                Value<DateTime?> dateFinReelle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MandatsResponsablesCompanion(
                id: id,
                ministereId: ministereId,
                fideleId: fideleId,
                dateDebut: dateDebut,
                dateFinPrevue: dateFinPrevue,
                dateFinReelle: dateFinReelle,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ministereId,
                required String fideleId,
                required DateTime dateDebut,
                Value<DateTime?> dateFinPrevue = const Value.absent(),
                Value<DateTime?> dateFinReelle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MandatsResponsablesCompanion.insert(
                id: id,
                ministereId: ministereId,
                fideleId: fideleId,
                dateDebut: dateDebut,
                dateFinPrevue: dateFinPrevue,
                dateFinReelle: dateFinReelle,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MandatsResponsablesTable, MandatResponsableRow>(
                    table,
                  ),
                  $$MandatsResponsablesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ministereId = false, fideleId = false}) {
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
                    if (ministereId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ministereId,
                                referencedTable:
                                    $$MandatsResponsablesTableReferences
                                        ._ministereIdTable(db),
                                referencedColumn:
                                    $$MandatsResponsablesTableReferences
                                        ._ministereIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (fideleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fideleId,
                                referencedTable:
                                    $$MandatsResponsablesTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$MandatsResponsablesTableReferences
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

typedef $$MandatsResponsablesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MandatsResponsablesTable,
      MandatResponsableRow,
      $$MandatsResponsablesTableFilterComposer,
      $$MandatsResponsablesTableOrderingComposer,
      $$MandatsResponsablesTableAnnotationComposer,
      $$MandatsResponsablesTableCreateCompanionBuilder,
      $$MandatsResponsablesTableUpdateCompanionBuilder,
      (MandatResponsableRow, $$MandatsResponsablesTableReferences),
      MandatResponsableRow,
      PrefetchHooks Function({bool ministereId, bool fideleId})
    >;
typedef $$ActivitesMinisteresTableCreateCompanionBuilder =
    ActivitesMinisteresCompanion Function({
      required String id,
      required String ministereId,
      required String type,
      required String description,
      required DateTime date,
      Value<String?> auteurFideleId,
      Value<int> rowid,
    });
typedef $$ActivitesMinisteresTableUpdateCompanionBuilder =
    ActivitesMinisteresCompanion Function({
      Value<String> id,
      Value<String> ministereId,
      Value<String> type,
      Value<String> description,
      Value<DateTime> date,
      Value<String?> auteurFideleId,
      Value<int> rowid,
    });

final class $$ActivitesMinisteresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ActivitesMinisteresTable,
          ActiviteMinistereRow
        > {
  $$ActivitesMinisteresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MinisteresTable _ministereIdTable(_$AppDatabase db) => db.ministeres
      .createAlias('activites_ministeres__ministere_id__ministeres__id');

  $$MinisteresTableProcessedTableManager get ministereId {
    final $_column = $_itemColumn<String>('ministere_id')!;

    final manager = $$MinisteresTableTableManager(
      $_db,
      $_db.ministeres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ministereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _auteurFideleIdTable(_$AppDatabase db) => db.fideles
      .createAlias('activites_ministeres__auteur_fidele_id__fideles__id');

  $$FidelesTableProcessedTableManager? get auteurFideleId {
    final $_column = $_itemColumn<String>('auteur_fidele_id');
    if ($_column == null) return null;
    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_auteurFideleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivitesMinisteresTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitesMinisteresTable> {
  $$ActivitesMinisteresTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$MinisteresTableFilterComposer get ministereId {
    final $$MinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableFilterComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableFilterComposer get auteurFideleId {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurFideleId,
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

class $$ActivitesMinisteresTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitesMinisteresTable> {
  $$ActivitesMinisteresTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$MinisteresTableOrderingComposer get ministereId {
    final $$MinisteresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableOrderingComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableOrderingComposer get auteurFideleId {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurFideleId,
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

class $$ActivitesMinisteresTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitesMinisteresTable> {
  $$ActivitesMinisteresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$MinisteresTableAnnotationComposer get ministereId {
    final $$MinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ministereId,
      referencedTable: $db.ministeres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.ministeres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableAnnotationComposer get auteurFideleId {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurFideleId,
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

class $$ActivitesMinisteresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitesMinisteresTable,
          ActiviteMinistereRow,
          $$ActivitesMinisteresTableFilterComposer,
          $$ActivitesMinisteresTableOrderingComposer,
          $$ActivitesMinisteresTableAnnotationComposer,
          $$ActivitesMinisteresTableCreateCompanionBuilder,
          $$ActivitesMinisteresTableUpdateCompanionBuilder,
          (ActiviteMinistereRow, $$ActivitesMinisteresTableReferences),
          ActiviteMinistereRow,
          PrefetchHooks Function({bool ministereId, bool auteurFideleId})
        > {
  $$ActivitesMinisteresTableTableManager(
    _$AppDatabase db,
    $ActivitesMinisteresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitesMinisteresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitesMinisteresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ActivitesMinisteresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ministereId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> auteurFideleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitesMinisteresCompanion(
                id: id,
                ministereId: ministereId,
                type: type,
                description: description,
                date: date,
                auteurFideleId: auteurFideleId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ministereId,
                required String type,
                required String description,
                required DateTime date,
                Value<String?> auteurFideleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitesMinisteresCompanion.insert(
                id: id,
                ministereId: ministereId,
                type: type,
                description: description,
                date: date,
                auteurFideleId: auteurFideleId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivitesMinisteresTable, ActiviteMinistereRow>(
                    table,
                  ),
                  $$ActivitesMinisteresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ministereId = false, auteurFideleId = false}) {
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
                        if (ministereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ministereId,
                                    referencedTable:
                                        $$ActivitesMinisteresTableReferences
                                            ._ministereIdTable(db),
                                    referencedColumn:
                                        $$ActivitesMinisteresTableReferences
                                            ._ministereIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (auteurFideleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.auteurFideleId,
                                    referencedTable:
                                        $$ActivitesMinisteresTableReferences
                                            ._auteurFideleIdTable(db),
                                    referencedColumn:
                                        $$ActivitesMinisteresTableReferences
                                            ._auteurFideleIdTable(db)
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

typedef $$ActivitesMinisteresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitesMinisteresTable,
      ActiviteMinistereRow,
      $$ActivitesMinisteresTableFilterComposer,
      $$ActivitesMinisteresTableOrderingComposer,
      $$ActivitesMinisteresTableAnnotationComposer,
      $$ActivitesMinisteresTableCreateCompanionBuilder,
      $$ActivitesMinisteresTableUpdateCompanionBuilder,
      (ActiviteMinistereRow, $$ActivitesMinisteresTableReferences),
      ActiviteMinistereRow,
      PrefetchHooks Function({bool ministereId, bool auteurFideleId})
    >;
typedef $$DonsSpirituelsTableCreateCompanionBuilder =
    DonsSpirituelsCompanion Function({
      required String id,
      required String code,
      required String libelle,
      required String descriptionBiblique,
      Value<int> rowid,
    });
typedef $$DonsSpirituelsTableUpdateCompanionBuilder =
    DonsSpirituelsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> libelle,
      Value<String> descriptionBiblique,
      Value<int> rowid,
    });

final class $$DonsSpirituelsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DonsSpirituelsTable, DonSpirituelRow> {
  $$DonsSpirituelsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DonsFidelesTable, List<DonFideleRow>>
  _donsFidelesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.donsFideles,
    aliasName: 'dons_spirituels__id__dons_fideles__don_id',
  );

  $$DonsFidelesTableProcessedTableManager get donsFidelesRefs {
    final manager = $$DonsFidelesTableTableManager(
      $_db,
      $_db.donsFideles,
    ).filter((f) => f.donId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_donsFidelesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DonsMinisteresCompatiblesTable,
    List<DonMinistereCompatibleRow>
  >
  _donsMinisteresCompatiblesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.donsMinisteresCompatibles,
        aliasName: 'dons_spirituels__id__dons_ministeres_compatibles__don_id',
      );

  $$DonsMinisteresCompatiblesTableProcessedTableManager
  get donsMinisteresCompatiblesRefs {
    final manager = $$DonsMinisteresCompatiblesTableTableManager(
      $_db,
      $_db.donsMinisteresCompatibles,
    ).filter((f) => f.donId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _donsMinisteresCompatiblesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DonsSpirituelsTableFilterComposer
    extends Composer<_$AppDatabase, $DonsSpirituelsTable> {
  $$DonsSpirituelsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionBiblique => $composableBuilder(
    column: $table.descriptionBiblique,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> donsFidelesRefs(
    Expression<bool> Function($$DonsFidelesTableFilterComposer f) f,
  ) {
    final $$DonsFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.donId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableFilterComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> donsMinisteresCompatiblesRefs(
    Expression<bool> Function($$DonsMinisteresCompatiblesTableFilterComposer f)
    f,
  ) {
    final $$DonsMinisteresCompatiblesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.donsMinisteresCompatibles,
          getReferencedColumn: (t) => t.donId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DonsMinisteresCompatiblesTableFilterComposer(
                $db: $db,
                $table: $db.donsMinisteresCompatibles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DonsSpirituelsTableOrderingComposer
    extends Composer<_$AppDatabase, $DonsSpirituelsTable> {
  $$DonsSpirituelsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionBiblique => $composableBuilder(
    column: $table.descriptionBiblique,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DonsSpirituelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonsSpirituelsTable> {
  $$DonsSpirituelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get descriptionBiblique => $composableBuilder(
    column: $table.descriptionBiblique,
    builder: (column) => column,
  );

  Expression<T> donsFidelesRefs<T extends Object>(
    Expression<T> Function($$DonsFidelesTableAnnotationComposer a) f,
  ) {
    final $$DonsFidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donsFideles,
      getReferencedColumn: (t) => t.donId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsFidelesTableAnnotationComposer(
            $db: $db,
            $table: $db.donsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> donsMinisteresCompatiblesRefs<T extends Object>(
    Expression<T> Function($$DonsMinisteresCompatiblesTableAnnotationComposer a)
    f,
  ) {
    final $$DonsMinisteresCompatiblesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.donsMinisteresCompatibles,
          getReferencedColumn: (t) => t.donId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DonsMinisteresCompatiblesTableAnnotationComposer(
                $db: $db,
                $table: $db.donsMinisteresCompatibles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DonsSpirituelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonsSpirituelsTable,
          DonSpirituelRow,
          $$DonsSpirituelsTableFilterComposer,
          $$DonsSpirituelsTableOrderingComposer,
          $$DonsSpirituelsTableAnnotationComposer,
          $$DonsSpirituelsTableCreateCompanionBuilder,
          $$DonsSpirituelsTableUpdateCompanionBuilder,
          (DonSpirituelRow, $$DonsSpirituelsTableReferences),
          DonSpirituelRow,
          PrefetchHooks Function({
            bool donsFidelesRefs,
            bool donsMinisteresCompatiblesRefs,
          })
        > {
  $$DonsSpirituelsTableTableManager(
    _$AppDatabase db,
    $DonsSpirituelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonsSpirituelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DonsSpirituelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DonsSpirituelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String> descriptionBiblique = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonsSpirituelsCompanion(
                id: id,
                code: code,
                libelle: libelle,
                descriptionBiblique: descriptionBiblique,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String libelle,
                required String descriptionBiblique,
                Value<int> rowid = const Value.absent(),
              }) => DonsSpirituelsCompanion.insert(
                id: id,
                code: code,
                libelle: libelle,
                descriptionBiblique: descriptionBiblique,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DonsSpirituelsTable, DonSpirituelRow>(table),
                  $$DonsSpirituelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                donsFidelesRefs = false,
                donsMinisteresCompatiblesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (donsFidelesRefs) db.donsFideles,
                    if (donsMinisteresCompatiblesRefs)
                      db.donsMinisteresCompatibles,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (donsFidelesRefs)
                        await $_getPrefetchedData<
                          DonSpirituelRow,
                          $DonsSpirituelsTable,
                          DonFideleRow
                        >(
                          currentTable: table,
                          referencedTable: $$DonsSpirituelsTableReferences
                              ._donsFidelesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DonsSpirituelsTableReferences(
                                db,
                                table,
                                p0,
                              ).donsFidelesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.donId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (donsMinisteresCompatiblesRefs)
                        await $_getPrefetchedData<
                          DonSpirituelRow,
                          $DonsSpirituelsTable,
                          DonMinistereCompatibleRow
                        >(
                          currentTable: table,
                          referencedTable: $$DonsSpirituelsTableReferences
                              ._donsMinisteresCompatiblesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DonsSpirituelsTableReferences(
                                db,
                                table,
                                p0,
                              ).donsMinisteresCompatiblesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.donId == item.id,
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

typedef $$DonsSpirituelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonsSpirituelsTable,
      DonSpirituelRow,
      $$DonsSpirituelsTableFilterComposer,
      $$DonsSpirituelsTableOrderingComposer,
      $$DonsSpirituelsTableAnnotationComposer,
      $$DonsSpirituelsTableCreateCompanionBuilder,
      $$DonsSpirituelsTableUpdateCompanionBuilder,
      (DonSpirituelRow, $$DonsSpirituelsTableReferences),
      DonSpirituelRow,
      PrefetchHooks Function({
        bool donsFidelesRefs,
        bool donsMinisteresCompatiblesRefs,
      })
    >;
typedef $$DonsFidelesTableCreateCompanionBuilder =
    DonsFidelesCompanion Function({
      required String id,
      required String fideleId,
      required String donId,
      required String niveauMaturite,
      required String responsableSuiviId,
      required DateTime dateEvaluation,
      Value<String?> observations,
      Value<int> rowid,
    });
typedef $$DonsFidelesTableUpdateCompanionBuilder =
    DonsFidelesCompanion Function({
      Value<String> id,
      Value<String> fideleId,
      Value<String> donId,
      Value<String> niveauMaturite,
      Value<String> responsableSuiviId,
      Value<DateTime> dateEvaluation,
      Value<String?> observations,
      Value<int> rowid,
    });

final class $$DonsFidelesTableReferences
    extends BaseReferences<_$AppDatabase, $DonsFidelesTable, DonFideleRow> {
  $$DonsFidelesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('dons_fideles__fidele_id__fideles__id');

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

  static $DonsSpirituelsTable _donIdTable(_$AppDatabase db) => db.donsSpirituels
      .createAlias('dons_fideles__don_id__dons_spirituels__id');

  $$DonsSpirituelsTableProcessedTableManager get donId {
    final $_column = $_itemColumn<String>('don_id')!;

    final manager = $$DonsSpirituelsTableTableManager(
      $_db,
      $_db.donsSpirituels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_donIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FidelesTable _responsableSuiviIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('dons_fideles__responsable_suivi_id__fideles__id');

  $$FidelesTableProcessedTableManager get responsableSuiviId {
    final $_column = $_itemColumn<String>('responsable_suivi_id')!;

    final manager = $$FidelesTableTableManager(
      $_db,
      $_db.fideles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_responsableSuiviIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DonsFidelesTableFilterComposer
    extends Composer<_$AppDatabase, $DonsFidelesTable> {
  $$DonsFidelesTableFilterComposer({
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

  ColumnFilters<String> get niveauMaturite => $composableBuilder(
    column: $table.niveauMaturite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEvaluation => $composableBuilder(
    column: $table.dateEvaluation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observations => $composableBuilder(
    column: $table.observations,
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

  $$DonsSpirituelsTableFilterComposer get donId {
    final $$DonsSpirituelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableFilterComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableFilterComposer get responsableSuiviId {
    final $$FidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.responsableSuiviId,
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

class $$DonsFidelesTableOrderingComposer
    extends Composer<_$AppDatabase, $DonsFidelesTable> {
  $$DonsFidelesTableOrderingComposer({
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

  ColumnOrderings<String> get niveauMaturite => $composableBuilder(
    column: $table.niveauMaturite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEvaluation => $composableBuilder(
    column: $table.dateEvaluation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observations => $composableBuilder(
    column: $table.observations,
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

  $$DonsSpirituelsTableOrderingComposer get donId {
    final $$DonsSpirituelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableOrderingComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableOrderingComposer get responsableSuiviId {
    final $$FidelesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.responsableSuiviId,
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

class $$DonsFidelesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonsFidelesTable> {
  $$DonsFidelesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get niveauMaturite => $composableBuilder(
    column: $table.niveauMaturite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateEvaluation => $composableBuilder(
    column: $table.dateEvaluation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => column,
  );

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

  $$DonsSpirituelsTableAnnotationComposer get donId {
    final $$DonsSpirituelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableAnnotationComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FidelesTableAnnotationComposer get responsableSuiviId {
    final $$FidelesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.responsableSuiviId,
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

class $$DonsFidelesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonsFidelesTable,
          DonFideleRow,
          $$DonsFidelesTableFilterComposer,
          $$DonsFidelesTableOrderingComposer,
          $$DonsFidelesTableAnnotationComposer,
          $$DonsFidelesTableCreateCompanionBuilder,
          $$DonsFidelesTableUpdateCompanionBuilder,
          (DonFideleRow, $$DonsFidelesTableReferences),
          DonFideleRow,
          PrefetchHooks Function({
            bool fideleId,
            bool donId,
            bool responsableSuiviId,
          })
        > {
  $$DonsFidelesTableTableManager(_$AppDatabase db, $DonsFidelesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonsFidelesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DonsFidelesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DonsFidelesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> donId = const Value.absent(),
                Value<String> niveauMaturite = const Value.absent(),
                Value<String> responsableSuiviId = const Value.absent(),
                Value<DateTime> dateEvaluation = const Value.absent(),
                Value<String?> observations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonsFidelesCompanion(
                id: id,
                fideleId: fideleId,
                donId: donId,
                niveauMaturite: niveauMaturite,
                responsableSuiviId: responsableSuiviId,
                dateEvaluation: dateEvaluation,
                observations: observations,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId,
                required String donId,
                required String niveauMaturite,
                required String responsableSuiviId,
                required DateTime dateEvaluation,
                Value<String?> observations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonsFidelesCompanion.insert(
                id: id,
                fideleId: fideleId,
                donId: donId,
                niveauMaturite: niveauMaturite,
                responsableSuiviId: responsableSuiviId,
                dateEvaluation: dateEvaluation,
                observations: observations,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DonsFidelesTable, DonFideleRow>(table),
                  $$DonsFidelesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({fideleId = false, donId = false, responsableSuiviId = false}) {
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
                                        $$DonsFidelesTableReferences
                                            ._fideleIdTable(db),
                                    referencedColumn:
                                        $$DonsFidelesTableReferences
                                            ._fideleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (donId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.donId,
                                    referencedTable:
                                        $$DonsFidelesTableReferences
                                            ._donIdTable(db),
                                    referencedColumn:
                                        $$DonsFidelesTableReferences
                                            ._donIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (responsableSuiviId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.responsableSuiviId,
                                    referencedTable:
                                        $$DonsFidelesTableReferences
                                            ._responsableSuiviIdTable(db),
                                    referencedColumn:
                                        $$DonsFidelesTableReferences
                                            ._responsableSuiviIdTable(db)
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

typedef $$DonsFidelesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonsFidelesTable,
      DonFideleRow,
      $$DonsFidelesTableFilterComposer,
      $$DonsFidelesTableOrderingComposer,
      $$DonsFidelesTableAnnotationComposer,
      $$DonsFidelesTableCreateCompanionBuilder,
      $$DonsFidelesTableUpdateCompanionBuilder,
      (DonFideleRow, $$DonsFidelesTableReferences),
      DonFideleRow,
      PrefetchHooks Function({
        bool fideleId,
        bool donId,
        bool responsableSuiviId,
      })
    >;
typedef $$DonsMinisteresCompatiblesTableCreateCompanionBuilder =
    DonsMinisteresCompatiblesCompanion Function({
      required String id,
      required String donId,
      required String typeMinistereId,
      Value<int> rowid,
    });
typedef $$DonsMinisteresCompatiblesTableUpdateCompanionBuilder =
    DonsMinisteresCompatiblesCompanion Function({
      Value<String> id,
      Value<String> donId,
      Value<String> typeMinistereId,
      Value<int> rowid,
    });

final class $$DonsMinisteresCompatiblesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DonsMinisteresCompatiblesTable,
          DonMinistereCompatibleRow
        > {
  $$DonsMinisteresCompatiblesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DonsSpirituelsTable _donIdTable(_$AppDatabase db) => db.donsSpirituels
      .createAlias('dons_ministeres_compatibles__don_id__dons_spirituels__id');

  $$DonsSpirituelsTableProcessedTableManager get donId {
    final $_column = $_itemColumn<String>('don_id')!;

    final manager = $$DonsSpirituelsTableTableManager(
      $_db,
      $_db.donsSpirituels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_donIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesMinisteresTable _typeMinistereIdTable(_$AppDatabase db) =>
      db.typesMinisteres.createAlias(
        'dons_ministeres_compatibles__type_ministere_id__types_ministeres__id',
      );

  $$TypesMinisteresTableProcessedTableManager get typeMinistereId {
    final $_column = $_itemColumn<String>('type_ministere_id')!;

    final manager = $$TypesMinisteresTableTableManager(
      $_db,
      $_db.typesMinisteres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeMinistereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DonsMinisteresCompatiblesTableFilterComposer
    extends Composer<_$AppDatabase, $DonsMinisteresCompatiblesTable> {
  $$DonsMinisteresCompatiblesTableFilterComposer({
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

  $$DonsSpirituelsTableFilterComposer get donId {
    final $$DonsSpirituelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableFilterComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesMinisteresTableFilterComposer get typeMinistereId {
    final $$TypesMinisteresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableFilterComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonsMinisteresCompatiblesTableOrderingComposer
    extends Composer<_$AppDatabase, $DonsMinisteresCompatiblesTable> {
  $$DonsMinisteresCompatiblesTableOrderingComposer({
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

  $$DonsSpirituelsTableOrderingComposer get donId {
    final $$DonsSpirituelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableOrderingComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesMinisteresTableOrderingComposer get typeMinistereId {
    final $$TypesMinisteresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableOrderingComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonsMinisteresCompatiblesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonsMinisteresCompatiblesTable> {
  $$DonsMinisteresCompatiblesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$DonsSpirituelsTableAnnotationComposer get donId {
    final $$DonsSpirituelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.donId,
      referencedTable: $db.donsSpirituels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonsSpirituelsTableAnnotationComposer(
            $db: $db,
            $table: $db.donsSpirituels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesMinisteresTableAnnotationComposer get typeMinistereId {
    final $$TypesMinisteresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeMinistereId,
      referencedTable: $db.typesMinisteres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesMinisteresTableAnnotationComposer(
            $db: $db,
            $table: $db.typesMinisteres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonsMinisteresCompatiblesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonsMinisteresCompatiblesTable,
          DonMinistereCompatibleRow,
          $$DonsMinisteresCompatiblesTableFilterComposer,
          $$DonsMinisteresCompatiblesTableOrderingComposer,
          $$DonsMinisteresCompatiblesTableAnnotationComposer,
          $$DonsMinisteresCompatiblesTableCreateCompanionBuilder,
          $$DonsMinisteresCompatiblesTableUpdateCompanionBuilder,
          (
            DonMinistereCompatibleRow,
            $$DonsMinisteresCompatiblesTableReferences,
          ),
          DonMinistereCompatibleRow,
          PrefetchHooks Function({bool donId, bool typeMinistereId})
        > {
  $$DonsMinisteresCompatiblesTableTableManager(
    _$AppDatabase db,
    $DonsMinisteresCompatiblesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonsMinisteresCompatiblesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DonsMinisteresCompatiblesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DonsMinisteresCompatiblesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> donId = const Value.absent(),
                Value<String> typeMinistereId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonsMinisteresCompatiblesCompanion(
                id: id,
                donId: donId,
                typeMinistereId: typeMinistereId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String donId,
                required String typeMinistereId,
                Value<int> rowid = const Value.absent(),
              }) => DonsMinisteresCompatiblesCompanion.insert(
                id: id,
                donId: donId,
                typeMinistereId: typeMinistereId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DonsMinisteresCompatiblesTable,
                    DonMinistereCompatibleRow
                  >(table),
                  $$DonsMinisteresCompatiblesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({donId = false, typeMinistereId = false}) {
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
                    if (donId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.donId,
                                referencedTable:
                                    $$DonsMinisteresCompatiblesTableReferences
                                        ._donIdTable(db),
                                referencedColumn:
                                    $$DonsMinisteresCompatiblesTableReferences
                                        ._donIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (typeMinistereId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.typeMinistereId,
                                referencedTable:
                                    $$DonsMinisteresCompatiblesTableReferences
                                        ._typeMinistereIdTable(db),
                                referencedColumn:
                                    $$DonsMinisteresCompatiblesTableReferences
                                        ._typeMinistereIdTable(db)
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

typedef $$DonsMinisteresCompatiblesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonsMinisteresCompatiblesTable,
      DonMinistereCompatibleRow,
      $$DonsMinisteresCompatiblesTableFilterComposer,
      $$DonsMinisteresCompatiblesTableOrderingComposer,
      $$DonsMinisteresCompatiblesTableAnnotationComposer,
      $$DonsMinisteresCompatiblesTableCreateCompanionBuilder,
      $$DonsMinisteresCompatiblesTableUpdateCompanionBuilder,
      (DonMinistereCompatibleRow, $$DonsMinisteresCompatiblesTableReferences),
      DonMinistereCompatibleRow,
      PrefetchHooks Function({bool donId, bool typeMinistereId})
    >;
typedef $$ProfessionsTableCreateCompanionBuilder =
    ProfessionsCompanion Function({
      required String id,
      required String code,
      required String categorie,
      required String libelle,
      Value<String> statut,
      Value<int> rowid,
    });
typedef $$ProfessionsTableUpdateCompanionBuilder =
    ProfessionsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> categorie,
      Value<String> libelle,
      Value<String> statut,
      Value<int> rowid,
    });

final class $$ProfessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ProfessionsTable, ProfessionRow> {
  $$ProfessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ProfessionsFidelesTable,
    List<ProfessionFideleRow>
  >
  _professionsFidelesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.professionsFideles,
        aliasName: 'professions__id__professions_fideles__profession_id',
      );

  $$ProfessionsFidelesTableProcessedTableManager get professionsFidelesRefs {
    final manager = $$ProfessionsFidelesTableTableManager(
      $_db,
      $_db.professionsFideles,
    ).filter((f) => f.professionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _professionsFidelesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfessionsTable> {
  $$ProfessionsTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> professionsFidelesRefs(
    Expression<bool> Function($$ProfessionsFidelesTableFilterComposer f) f,
  ) {
    final $$ProfessionsFidelesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.professionsFideles,
      getReferencedColumn: (t) => t.professionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfessionsFidelesTableFilterComposer(
            $db: $db,
            $table: $db.professionsFideles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfessionsTable> {
  $$ProfessionsTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfessionsTable> {
  $$ProfessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get categorie =>
      $composableBuilder(column: $table.categorie, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  Expression<T> professionsFidelesRefs<T extends Object>(
    Expression<T> Function($$ProfessionsFidelesTableAnnotationComposer a) f,
  ) {
    final $$ProfessionsFidelesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.professionsFideles,
          getReferencedColumn: (t) => t.professionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProfessionsFidelesTableAnnotationComposer(
                $db: $db,
                $table: $db.professionsFideles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProfessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfessionsTable,
          ProfessionRow,
          $$ProfessionsTableFilterComposer,
          $$ProfessionsTableOrderingComposer,
          $$ProfessionsTableAnnotationComposer,
          $$ProfessionsTableCreateCompanionBuilder,
          $$ProfessionsTableUpdateCompanionBuilder,
          (ProfessionRow, $$ProfessionsTableReferences),
          ProfessionRow,
          PrefetchHooks Function({bool professionsFidelesRefs})
        > {
  $$ProfessionsTableTableManager(_$AppDatabase db, $ProfessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> categorie = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfessionsCompanion(
                id: id,
                code: code,
                categorie: categorie,
                libelle: libelle,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String categorie,
                required String libelle,
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfessionsCompanion.insert(
                id: id,
                code: code,
                categorie: categorie,
                libelle: libelle,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfessionsTable, ProfessionRow>(table),
                  $$ProfessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({professionsFidelesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (professionsFidelesRefs) db.professionsFideles,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (professionsFidelesRefs)
                    await $_getPrefetchedData<
                      ProfessionRow,
                      $ProfessionsTable,
                      ProfessionFideleRow
                    >(
                      currentTable: table,
                      referencedTable: $$ProfessionsTableReferences
                          ._professionsFidelesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProfessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).professionsFidelesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.professionId == item.id,
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

typedef $$ProfessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfessionsTable,
      ProfessionRow,
      $$ProfessionsTableFilterComposer,
      $$ProfessionsTableOrderingComposer,
      $$ProfessionsTableAnnotationComposer,
      $$ProfessionsTableCreateCompanionBuilder,
      $$ProfessionsTableUpdateCompanionBuilder,
      (ProfessionRow, $$ProfessionsTableReferences),
      ProfessionRow,
      PrefetchHooks Function({bool professionsFidelesRefs})
    >;
typedef $$ProfessionsFidelesTableCreateCompanionBuilder =
    ProfessionsFidelesCompanion Function({
      required String id,
      required String fideleId,
      required String professionId,
      Value<String> statutVerification,
      Value<int?> anneesExperience,
      Value<int> rowid,
    });
typedef $$ProfessionsFidelesTableUpdateCompanionBuilder =
    ProfessionsFidelesCompanion Function({
      Value<String> id,
      Value<String> fideleId,
      Value<String> professionId,
      Value<String> statutVerification,
      Value<int?> anneesExperience,
      Value<int> rowid,
    });

final class $$ProfessionsFidelesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProfessionsFidelesTable,
          ProfessionFideleRow
        > {
  $$ProfessionsFidelesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('professions_fideles__fidele_id__fideles__id');

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

  static $ProfessionsTable _professionIdTable(_$AppDatabase db) => db
      .professions
      .createAlias('professions_fideles__profession_id__professions__id');

  $$ProfessionsTableProcessedTableManager get professionId {
    final $_column = $_itemColumn<String>('profession_id')!;

    final manager = $$ProfessionsTableTableManager(
      $_db,
      $_db.professions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_professionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfessionsFidelesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfessionsFidelesTable> {
  $$ProfessionsFidelesTableFilterComposer({
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

  ColumnFilters<String> get statutVerification => $composableBuilder(
    column: $table.statutVerification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anneesExperience => $composableBuilder(
    column: $table.anneesExperience,
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

  $$ProfessionsTableFilterComposer get professionId {
    final $$ProfessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.professionId,
      referencedTable: $db.professions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfessionsTableFilterComposer(
            $db: $db,
            $table: $db.professions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfessionsFidelesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfessionsFidelesTable> {
  $$ProfessionsFidelesTableOrderingComposer({
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

  ColumnOrderings<String> get statutVerification => $composableBuilder(
    column: $table.statutVerification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anneesExperience => $composableBuilder(
    column: $table.anneesExperience,
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

  $$ProfessionsTableOrderingComposer get professionId {
    final $$ProfessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.professionId,
      referencedTable: $db.professions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfessionsTableOrderingComposer(
            $db: $db,
            $table: $db.professions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfessionsFidelesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfessionsFidelesTable> {
  $$ProfessionsFidelesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get statutVerification => $composableBuilder(
    column: $table.statutVerification,
    builder: (column) => column,
  );

  GeneratedColumn<int> get anneesExperience => $composableBuilder(
    column: $table.anneesExperience,
    builder: (column) => column,
  );

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

  $$ProfessionsTableAnnotationComposer get professionId {
    final $$ProfessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.professionId,
      referencedTable: $db.professions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.professions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfessionsFidelesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfessionsFidelesTable,
          ProfessionFideleRow,
          $$ProfessionsFidelesTableFilterComposer,
          $$ProfessionsFidelesTableOrderingComposer,
          $$ProfessionsFidelesTableAnnotationComposer,
          $$ProfessionsFidelesTableCreateCompanionBuilder,
          $$ProfessionsFidelesTableUpdateCompanionBuilder,
          (ProfessionFideleRow, $$ProfessionsFidelesTableReferences),
          ProfessionFideleRow,
          PrefetchHooks Function({bool fideleId, bool professionId})
        > {
  $$ProfessionsFidelesTableTableManager(
    _$AppDatabase db,
    $ProfessionsFidelesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfessionsFidelesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfessionsFidelesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfessionsFidelesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> professionId = const Value.absent(),
                Value<String> statutVerification = const Value.absent(),
                Value<int?> anneesExperience = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfessionsFidelesCompanion(
                id: id,
                fideleId: fideleId,
                professionId: professionId,
                statutVerification: statutVerification,
                anneesExperience: anneesExperience,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId,
                required String professionId,
                Value<String> statutVerification = const Value.absent(),
                Value<int?> anneesExperience = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfessionsFidelesCompanion.insert(
                id: id,
                fideleId: fideleId,
                professionId: professionId,
                statutVerification: statutVerification,
                anneesExperience: anneesExperience,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfessionsFidelesTable, ProfessionFideleRow>(
                    table,
                  ),
                  $$ProfessionsFidelesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fideleId = false, professionId = false}) {
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
                                    $$ProfessionsFidelesTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$ProfessionsFidelesTableReferences
                                        ._fideleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (professionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.professionId,
                                referencedTable:
                                    $$ProfessionsFidelesTableReferences
                                        ._professionIdTable(db),
                                referencedColumn:
                                    $$ProfessionsFidelesTableReferences
                                        ._professionIdTable(db)
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

typedef $$ProfessionsFidelesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfessionsFidelesTable,
      ProfessionFideleRow,
      $$ProfessionsFidelesTableFilterComposer,
      $$ProfessionsFidelesTableOrderingComposer,
      $$ProfessionsFidelesTableAnnotationComposer,
      $$ProfessionsFidelesTableCreateCompanionBuilder,
      $$ProfessionsFidelesTableUpdateCompanionBuilder,
      (ProfessionFideleRow, $$ProfessionsFidelesTableReferences),
      ProfessionFideleRow,
      PrefetchHooks Function({bool fideleId, bool professionId})
    >;
typedef $$SollicitationsTableCreateCompanionBuilder =
    SollicitationsCompanion Function({
      required String id,
      required String fideleId,
      required String objet,
      required DateTime date,
      Value<String?> reponse,
      Value<int> rowid,
    });
typedef $$SollicitationsTableUpdateCompanionBuilder =
    SollicitationsCompanion Function({
      Value<String> id,
      Value<String> fideleId,
      Value<String> objet,
      Value<DateTime> date,
      Value<String?> reponse,
      Value<int> rowid,
    });

final class $$SollicitationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SollicitationsTable, SollicitationRow> {
  $$SollicitationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('sollicitations__fidele_id__fideles__id');

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

class $$SollicitationsTableFilterComposer
    extends Composer<_$AppDatabase, $SollicitationsTable> {
  $$SollicitationsTableFilterComposer({
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

  ColumnFilters<String> get objet => $composableBuilder(
    column: $table.objet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reponse => $composableBuilder(
    column: $table.reponse,
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

class $$SollicitationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SollicitationsTable> {
  $$SollicitationsTableOrderingComposer({
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

  ColumnOrderings<String> get objet => $composableBuilder(
    column: $table.objet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reponse => $composableBuilder(
    column: $table.reponse,
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

class $$SollicitationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SollicitationsTable> {
  $$SollicitationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get objet =>
      $composableBuilder(column: $table.objet, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get reponse =>
      $composableBuilder(column: $table.reponse, builder: (column) => column);

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

class $$SollicitationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SollicitationsTable,
          SollicitationRow,
          $$SollicitationsTableFilterComposer,
          $$SollicitationsTableOrderingComposer,
          $$SollicitationsTableAnnotationComposer,
          $$SollicitationsTableCreateCompanionBuilder,
          $$SollicitationsTableUpdateCompanionBuilder,
          (SollicitationRow, $$SollicitationsTableReferences),
          SollicitationRow,
          PrefetchHooks Function({bool fideleId})
        > {
  $$SollicitationsTableTableManager(
    _$AppDatabase db,
    $SollicitationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SollicitationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SollicitationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SollicitationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> objet = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> reponse = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SollicitationsCompanion(
                id: id,
                fideleId: fideleId,
                objet: objet,
                date: date,
                reponse: reponse,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId,
                required String objet,
                required DateTime date,
                Value<String?> reponse = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SollicitationsCompanion.insert(
                id: id,
                fideleId: fideleId,
                objet: objet,
                date: date,
                reponse: reponse,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SollicitationsTable, SollicitationRow>(table),
                  $$SollicitationsTableReferences(db, table, e),
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
                                referencedTable: $$SollicitationsTableReferences
                                    ._fideleIdTable(db),
                                referencedColumn:
                                    $$SollicitationsTableReferences
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

typedef $$SollicitationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SollicitationsTable,
      SollicitationRow,
      $$SollicitationsTableFilterComposer,
      $$SollicitationsTableOrderingComposer,
      $$SollicitationsTableAnnotationComposer,
      $$SollicitationsTableCreateCompanionBuilder,
      $$SollicitationsTableUpdateCompanionBuilder,
      (SollicitationRow, $$SollicitationsTableReferences),
      SollicitationRow,
      PrefetchHooks Function({bool fideleId})
    >;
typedef $$GroupesEgliseTableCreateCompanionBuilder =
    GroupesEgliseCompanion Function({
      required String id,
      required String code,
      required String libelle,
      required String typeRegle,
      Value<String?> criteresJson,
      Value<int> rowid,
    });
typedef $$GroupesEgliseTableUpdateCompanionBuilder =
    GroupesEgliseCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> libelle,
      Value<String> typeRegle,
      Value<String?> criteresJson,
      Value<int> rowid,
    });

final class $$GroupesEgliseTableReferences
    extends
        BaseReferences<_$AppDatabase, $GroupesEgliseTable, GroupeEgliseRow> {
  $$GroupesEgliseTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $AppartenancesGroupeTable,
    List<AppartenanceGroupeRow>
  >
  _appartenancesGroupeRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.appartenancesGroupe,
        aliasName: 'groupes_eglise__id__appartenances_groupe__groupe_id',
      );

  $$AppartenancesGroupeTableProcessedTableManager get appartenancesGroupeRefs {
    final manager = $$AppartenancesGroupeTableTableManager(
      $_db,
      $_db.appartenancesGroupe,
    ).filter((f) => f.groupeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _appartenancesGroupeRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupesEgliseTableFilterComposer
    extends Composer<_$AppDatabase, $GroupesEgliseTable> {
  $$GroupesEgliseTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typeRegle => $composableBuilder(
    column: $table.typeRegle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get criteresJson => $composableBuilder(
    column: $table.criteresJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appartenancesGroupeRefs(
    Expression<bool> Function($$AppartenancesGroupeTableFilterComposer f) f,
  ) {
    final $$AppartenancesGroupeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenancesGroupe,
      getReferencedColumn: (t) => t.groupeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesGroupeTableFilterComposer(
            $db: $db,
            $table: $db.appartenancesGroupe,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupesEgliseTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupesEgliseTable> {
  $$GroupesEgliseTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typeRegle => $composableBuilder(
    column: $table.typeRegle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get criteresJson => $composableBuilder(
    column: $table.criteresJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupesEgliseTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupesEgliseTable> {
  $$GroupesEgliseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get typeRegle =>
      $composableBuilder(column: $table.typeRegle, builder: (column) => column);

  GeneratedColumn<String> get criteresJson => $composableBuilder(
    column: $table.criteresJson,
    builder: (column) => column,
  );

  Expression<T> appartenancesGroupeRefs<T extends Object>(
    Expression<T> Function($$AppartenancesGroupeTableAnnotationComposer a) f,
  ) {
    final $$AppartenancesGroupeTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.appartenancesGroupe,
          getReferencedColumn: (t) => t.groupeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AppartenancesGroupeTableAnnotationComposer(
                $db: $db,
                $table: $db.appartenancesGroupe,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GroupesEgliseTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupesEgliseTable,
          GroupeEgliseRow,
          $$GroupesEgliseTableFilterComposer,
          $$GroupesEgliseTableOrderingComposer,
          $$GroupesEgliseTableAnnotationComposer,
          $$GroupesEgliseTableCreateCompanionBuilder,
          $$GroupesEgliseTableUpdateCompanionBuilder,
          (GroupeEgliseRow, $$GroupesEgliseTableReferences),
          GroupeEgliseRow,
          PrefetchHooks Function({bool appartenancesGroupeRefs})
        > {
  $$GroupesEgliseTableTableManager(_$AppDatabase db, $GroupesEgliseTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupesEgliseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupesEgliseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupesEgliseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String> typeRegle = const Value.absent(),
                Value<String?> criteresJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupesEgliseCompanion(
                id: id,
                code: code,
                libelle: libelle,
                typeRegle: typeRegle,
                criteresJson: criteresJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String libelle,
                required String typeRegle,
                Value<String?> criteresJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupesEgliseCompanion.insert(
                id: id,
                code: code,
                libelle: libelle,
                typeRegle: typeRegle,
                criteresJson: criteresJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GroupesEgliseTable, GroupeEgliseRow>(table),
                  $$GroupesEgliseTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({appartenancesGroupeRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (appartenancesGroupeRefs) db.appartenancesGroupe,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (appartenancesGroupeRefs)
                    await $_getPrefetchedData<
                      GroupeEgliseRow,
                      $GroupesEgliseTable,
                      AppartenanceGroupeRow
                    >(
                      currentTable: table,
                      referencedTable: $$GroupesEgliseTableReferences
                          ._appartenancesGroupeRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GroupesEgliseTableReferences(
                            db,
                            table,
                            p0,
                          ).appartenancesGroupeRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GroupesEgliseTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupesEgliseTable,
      GroupeEgliseRow,
      $$GroupesEgliseTableFilterComposer,
      $$GroupesEgliseTableOrderingComposer,
      $$GroupesEgliseTableAnnotationComposer,
      $$GroupesEgliseTableCreateCompanionBuilder,
      $$GroupesEgliseTableUpdateCompanionBuilder,
      (GroupeEgliseRow, $$GroupesEgliseTableReferences),
      GroupeEgliseRow,
      PrefetchHooks Function({bool appartenancesGroupeRefs})
    >;
typedef $$AppartenancesGroupeTableCreateCompanionBuilder =
    AppartenancesGroupeCompanion Function({
      required String id,
      required String fideleId,
      required String groupeId,
      required DateTime dateAffectation,
      required String origine,
      Value<String?> motifDerogation,
      Value<int> rowid,
    });
typedef $$AppartenancesGroupeTableUpdateCompanionBuilder =
    AppartenancesGroupeCompanion Function({
      Value<String> id,
      Value<String> fideleId,
      Value<String> groupeId,
      Value<DateTime> dateAffectation,
      Value<String> origine,
      Value<String?> motifDerogation,
      Value<int> rowid,
    });

final class $$AppartenancesGroupeTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AppartenancesGroupeTable,
          AppartenanceGroupeRow
        > {
  $$AppartenancesGroupeTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FidelesTable _fideleIdTable(_$AppDatabase db) =>
      db.fideles.createAlias('appartenances_groupe__fidele_id__fideles__id');

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

  static $GroupesEgliseTable _groupeIdTable(_$AppDatabase db) => db
      .groupesEglise
      .createAlias('appartenances_groupe__groupe_id__groupes_eglise__id');

  $$GroupesEgliseTableProcessedTableManager get groupeId {
    final $_column = $_itemColumn<String>('groupe_id')!;

    final manager = $$GroupesEgliseTableTableManager(
      $_db,
      $_db.groupesEglise,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppartenancesGroupeTableFilterComposer
    extends Composer<_$AppDatabase, $AppartenancesGroupeTable> {
  $$AppartenancesGroupeTableFilterComposer({
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

  ColumnFilters<DateTime> get dateAffectation => $composableBuilder(
    column: $table.dateAffectation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origine => $composableBuilder(
    column: $table.origine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motifDerogation => $composableBuilder(
    column: $table.motifDerogation,
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

  $$GroupesEgliseTableFilterComposer get groupeId {
    final $$GroupesEgliseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupeId,
      referencedTable: $db.groupesEglise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupesEgliseTableFilterComposer(
            $db: $db,
            $table: $db.groupesEglise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesGroupeTableOrderingComposer
    extends Composer<_$AppDatabase, $AppartenancesGroupeTable> {
  $$AppartenancesGroupeTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dateAffectation => $composableBuilder(
    column: $table.dateAffectation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origine => $composableBuilder(
    column: $table.origine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motifDerogation => $composableBuilder(
    column: $table.motifDerogation,
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

  $$GroupesEgliseTableOrderingComposer get groupeId {
    final $$GroupesEgliseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupeId,
      referencedTable: $db.groupesEglise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupesEgliseTableOrderingComposer(
            $db: $db,
            $table: $db.groupesEglise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesGroupeTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppartenancesGroupeTable> {
  $$AppartenancesGroupeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAffectation => $composableBuilder(
    column: $table.dateAffectation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origine =>
      $composableBuilder(column: $table.origine, builder: (column) => column);

  GeneratedColumn<String> get motifDerogation => $composableBuilder(
    column: $table.motifDerogation,
    builder: (column) => column,
  );

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

  $$GroupesEgliseTableAnnotationComposer get groupeId {
    final $$GroupesEgliseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupeId,
      referencedTable: $db.groupesEglise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupesEgliseTableAnnotationComposer(
            $db: $db,
            $table: $db.groupesEglise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesGroupeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppartenancesGroupeTable,
          AppartenanceGroupeRow,
          $$AppartenancesGroupeTableFilterComposer,
          $$AppartenancesGroupeTableOrderingComposer,
          $$AppartenancesGroupeTableAnnotationComposer,
          $$AppartenancesGroupeTableCreateCompanionBuilder,
          $$AppartenancesGroupeTableUpdateCompanionBuilder,
          (AppartenanceGroupeRow, $$AppartenancesGroupeTableReferences),
          AppartenanceGroupeRow,
          PrefetchHooks Function({bool fideleId, bool groupeId})
        > {
  $$AppartenancesGroupeTableTableManager(
    _$AppDatabase db,
    $AppartenancesGroupeTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppartenancesGroupeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppartenancesGroupeTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AppartenancesGroupeTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fideleId = const Value.absent(),
                Value<String> groupeId = const Value.absent(),
                Value<DateTime> dateAffectation = const Value.absent(),
                Value<String> origine = const Value.absent(),
                Value<String?> motifDerogation = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppartenancesGroupeCompanion(
                id: id,
                fideleId: fideleId,
                groupeId: groupeId,
                dateAffectation: dateAffectation,
                origine: origine,
                motifDerogation: motifDerogation,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fideleId,
                required String groupeId,
                required DateTime dateAffectation,
                required String origine,
                Value<String?> motifDerogation = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppartenancesGroupeCompanion.insert(
                id: id,
                fideleId: fideleId,
                groupeId: groupeId,
                dateAffectation: dateAffectation,
                origine: origine,
                motifDerogation: motifDerogation,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppartenancesGroupeTable, AppartenanceGroupeRow>(
                    table,
                  ),
                  $$AppartenancesGroupeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fideleId = false, groupeId = false}) {
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
                                    $$AppartenancesGroupeTableReferences
                                        ._fideleIdTable(db),
                                referencedColumn:
                                    $$AppartenancesGroupeTableReferences
                                        ._fideleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (groupeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupeId,
                                referencedTable:
                                    $$AppartenancesGroupeTableReferences
                                        ._groupeIdTable(db),
                                referencedColumn:
                                    $$AppartenancesGroupeTableReferences
                                        ._groupeIdTable(db)
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

typedef $$AppartenancesGroupeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppartenancesGroupeTable,
      AppartenanceGroupeRow,
      $$AppartenancesGroupeTableFilterComposer,
      $$AppartenancesGroupeTableOrderingComposer,
      $$AppartenancesGroupeTableAnnotationComposer,
      $$AppartenancesGroupeTableCreateCompanionBuilder,
      $$AppartenancesGroupeTableUpdateCompanionBuilder,
      (AppartenanceGroupeRow, $$AppartenancesGroupeTableReferences),
      AppartenanceGroupeRow,
      PrefetchHooks Function({bool fideleId, bool groupeId})
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
  $$NodeResponsablesTableTableManager get nodeResponsables =>
      $$NodeResponsablesTableTableManager(_db, _db.nodeResponsables);
  $$LiensFamiliauxTableTableManager get liensFamiliaux =>
      $$LiensFamiliauxTableTableManager(_db, _db.liensFamiliaux);
  $$HistoriqueFidelesTableTableManager get historiqueFideles =>
      $$HistoriqueFidelesTableTableManager(_db, _db.historiqueFideles);
  $$TuteursTableTableManager get tuteurs =>
      $$TuteursTableTableManager(_db, _db.tuteurs);
  $$ZonesGeographiquesTableTableManager get zonesGeographiques =>
      $$ZonesGeographiquesTableTableManager(_db, _db.zonesGeographiques);
  $$TypesMinisteresTableTableManager get typesMinisteres =>
      $$TypesMinisteresTableTableManager(_db, _db.typesMinisteres);
  $$MinisteresTableTableManager get ministeres =>
      $$MinisteresTableTableManager(_db, _db.ministeres);
  $$AffectationsMinisteresTableTableManager get affectationsMinisteres =>
      $$AffectationsMinisteresTableTableManager(
        _db,
        _db.affectationsMinisteres,
      );
  $$MandatsResponsablesTableTableManager get mandatsResponsables =>
      $$MandatsResponsablesTableTableManager(_db, _db.mandatsResponsables);
  $$ActivitesMinisteresTableTableManager get activitesMinisteres =>
      $$ActivitesMinisteresTableTableManager(_db, _db.activitesMinisteres);
  $$DonsSpirituelsTableTableManager get donsSpirituels =>
      $$DonsSpirituelsTableTableManager(_db, _db.donsSpirituels);
  $$DonsFidelesTableTableManager get donsFideles =>
      $$DonsFidelesTableTableManager(_db, _db.donsFideles);
  $$DonsMinisteresCompatiblesTableTableManager get donsMinisteresCompatibles =>
      $$DonsMinisteresCompatiblesTableTableManager(
        _db,
        _db.donsMinisteresCompatibles,
      );
  $$ProfessionsTableTableManager get professions =>
      $$ProfessionsTableTableManager(_db, _db.professions);
  $$ProfessionsFidelesTableTableManager get professionsFideles =>
      $$ProfessionsFidelesTableTableManager(_db, _db.professionsFideles);
  $$SollicitationsTableTableManager get sollicitations =>
      $$SollicitationsTableTableManager(_db, _db.sollicitations);
  $$GroupesEgliseTableTableManager get groupesEglise =>
      $$GroupesEgliseTableTableManager(_db, _db.groupesEglise);
  $$AppartenancesGroupeTableTableManager get appartenancesGroupe =>
      $$AppartenancesGroupeTableTableManager(_db, _db.appartenancesGroupe);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
}
