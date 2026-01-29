// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriftDB.dart';

// ignore_for_file: type=lint
class $LocalStudyHistoryTable extends LocalStudyHistory
    with TableInfo<$LocalStudyHistoryTable, LocalStudyHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalStudyHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _youtubeVideoIdMeta = const VerificationMeta(
    'youtubeVideoId',
  );
  @override
  late final GeneratedColumn<String> youtubeVideoId = GeneratedColumn<String>(
    'youtube_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studiedAtMeta = const VerificationMeta(
    'studiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> studiedAt = GeneratedColumn<DateTime>(
    'studied_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    recordId,
    uid,
    youtubeVideoId,
    studiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_study_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalStudyHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('youtube_video_id')) {
      context.handle(
        _youtubeVideoIdMeta,
        youtubeVideoId.isAcceptableOrUnknown(
          data['youtube_video_id']!,
          _youtubeVideoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_youtubeVideoIdMeta);
    }
    if (data.containsKey('studied_at')) {
      context.handle(
        _studiedAtMeta,
        studiedAt.isAcceptableOrUnknown(data['studied_at']!, _studiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_studiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recordId};
  @override
  LocalStudyHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalStudyHistoryData(
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      youtubeVideoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_video_id'],
      )!,
      studiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}studied_at'],
      )!,
    );
  }

  @override
  $LocalStudyHistoryTable createAlias(String alias) {
    return $LocalStudyHistoryTable(attachedDatabase, alias);
  }
}

class LocalStudyHistoryData extends DataClass
    implements Insertable<LocalStudyHistoryData> {
  final int recordId;
  final String uid;
  final String youtubeVideoId;
  final DateTime studiedAt;
  const LocalStudyHistoryData({
    required this.recordId,
    required this.uid,
    required this.youtubeVideoId,
    required this.studiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['record_id'] = Variable<int>(recordId);
    map['uid'] = Variable<String>(uid);
    map['youtube_video_id'] = Variable<String>(youtubeVideoId);
    map['studied_at'] = Variable<DateTime>(studiedAt);
    return map;
  }

  LocalStudyHistoryCompanion toCompanion(bool nullToAbsent) {
    return LocalStudyHistoryCompanion(
      recordId: Value(recordId),
      uid: Value(uid),
      youtubeVideoId: Value(youtubeVideoId),
      studiedAt: Value(studiedAt),
    );
  }

  factory LocalStudyHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalStudyHistoryData(
      recordId: serializer.fromJson<int>(json['recordId']),
      uid: serializer.fromJson<String>(json['uid']),
      youtubeVideoId: serializer.fromJson<String>(json['youtubeVideoId']),
      studiedAt: serializer.fromJson<DateTime>(json['studiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recordId': serializer.toJson<int>(recordId),
      'uid': serializer.toJson<String>(uid),
      'youtubeVideoId': serializer.toJson<String>(youtubeVideoId),
      'studiedAt': serializer.toJson<DateTime>(studiedAt),
    };
  }

  LocalStudyHistoryData copyWith({
    int? recordId,
    String? uid,
    String? youtubeVideoId,
    DateTime? studiedAt,
  }) => LocalStudyHistoryData(
    recordId: recordId ?? this.recordId,
    uid: uid ?? this.uid,
    youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
    studiedAt: studiedAt ?? this.studiedAt,
  );
  LocalStudyHistoryData copyWithCompanion(LocalStudyHistoryCompanion data) {
    return LocalStudyHistoryData(
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      uid: data.uid.present ? data.uid.value : this.uid,
      youtubeVideoId: data.youtubeVideoId.present
          ? data.youtubeVideoId.value
          : this.youtubeVideoId,
      studiedAt: data.studiedAt.present ? data.studiedAt.value : this.studiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudyHistoryData(')
          ..write('recordId: $recordId, ')
          ..write('uid: $uid, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('studiedAt: $studiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recordId, uid, youtubeVideoId, studiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalStudyHistoryData &&
          other.recordId == this.recordId &&
          other.uid == this.uid &&
          other.youtubeVideoId == this.youtubeVideoId &&
          other.studiedAt == this.studiedAt);
}

class LocalStudyHistoryCompanion
    extends UpdateCompanion<LocalStudyHistoryData> {
  final Value<int> recordId;
  final Value<String> uid;
  final Value<String> youtubeVideoId;
  final Value<DateTime> studiedAt;
  const LocalStudyHistoryCompanion({
    this.recordId = const Value.absent(),
    this.uid = const Value.absent(),
    this.youtubeVideoId = const Value.absent(),
    this.studiedAt = const Value.absent(),
  });
  LocalStudyHistoryCompanion.insert({
    this.recordId = const Value.absent(),
    required String uid,
    required String youtubeVideoId,
    required DateTime studiedAt,
  }) : uid = Value(uid),
       youtubeVideoId = Value(youtubeVideoId),
       studiedAt = Value(studiedAt);
  static Insertable<LocalStudyHistoryData> custom({
    Expression<int>? recordId,
    Expression<String>? uid,
    Expression<String>? youtubeVideoId,
    Expression<DateTime>? studiedAt,
  }) {
    return RawValuesInsertable({
      if (recordId != null) 'record_id': recordId,
      if (uid != null) 'uid': uid,
      if (youtubeVideoId != null) 'youtube_video_id': youtubeVideoId,
      if (studiedAt != null) 'studied_at': studiedAt,
    });
  }

  LocalStudyHistoryCompanion copyWith({
    Value<int>? recordId,
    Value<String>? uid,
    Value<String>? youtubeVideoId,
    Value<DateTime>? studiedAt,
  }) {
    return LocalStudyHistoryCompanion(
      recordId: recordId ?? this.recordId,
      uid: uid ?? this.uid,
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      studiedAt: studiedAt ?? this.studiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (youtubeVideoId.present) {
      map['youtube_video_id'] = Variable<String>(youtubeVideoId.value);
    }
    if (studiedAt.present) {
      map['studied_at'] = Variable<DateTime>(studiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalStudyHistoryCompanion(')
          ..write('recordId: $recordId, ')
          ..write('uid: $uid, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('studiedAt: $studiedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalVideoPrefsTable extends LocalVideoPrefs
    with TableInfo<$LocalVideoPrefsTable, LocalVideoPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalVideoPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _youtubeVideoIdMeta = const VerificationMeta(
    'youtubeVideoId',
  );
  @override
  late final GeneratedColumn<String> youtubeVideoId = GeneratedColumn<String>(
    'youtube_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _searchedTitleMeta = const VerificationMeta(
    'searchedTitle',
  );
  @override
  late final GeneratedColumn<String> searchedTitle = GeneratedColumn<String>(
    'searched_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchedArtistMeta = const VerificationMeta(
    'searchedArtist',
  );
  @override
  late final GeneratedColumn<String> searchedArtist = GeneratedColumn<String>(
    'searched_artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    youtubeVideoId,
    isFavorite,
    searchedTitle,
    searchedArtist,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_video_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalVideoPref> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('youtube_video_id')) {
      context.handle(
        _youtubeVideoIdMeta,
        youtubeVideoId.isAcceptableOrUnknown(
          data['youtube_video_id']!,
          _youtubeVideoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_youtubeVideoIdMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('searched_title')) {
      context.handle(
        _searchedTitleMeta,
        searchedTitle.isAcceptableOrUnknown(
          data['searched_title']!,
          _searchedTitleMeta,
        ),
      );
    }
    if (data.containsKey('searched_artist')) {
      context.handle(
        _searchedArtistMeta,
        searchedArtist.isAcceptableOrUnknown(
          data['searched_artist']!,
          _searchedArtistMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid, youtubeVideoId};
  @override
  LocalVideoPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalVideoPref(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      youtubeVideoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_video_id'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      searchedTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}searched_title'],
      ),
      searchedArtist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}searched_artist'],
      ),
    );
  }

  @override
  $LocalVideoPrefsTable createAlias(String alias) {
    return $LocalVideoPrefsTable(attachedDatabase, alias);
  }
}

class LocalVideoPref extends DataClass implements Insertable<LocalVideoPref> {
  final String uid;
  final String youtubeVideoId;
  final bool isFavorite;
  final String? searchedTitle;
  final String? searchedArtist;
  const LocalVideoPref({
    required this.uid,
    required this.youtubeVideoId,
    required this.isFavorite,
    this.searchedTitle,
    this.searchedArtist,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['youtube_video_id'] = Variable<String>(youtubeVideoId);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || searchedTitle != null) {
      map['searched_title'] = Variable<String>(searchedTitle);
    }
    if (!nullToAbsent || searchedArtist != null) {
      map['searched_artist'] = Variable<String>(searchedArtist);
    }
    return map;
  }

  LocalVideoPrefsCompanion toCompanion(bool nullToAbsent) {
    return LocalVideoPrefsCompanion(
      uid: Value(uid),
      youtubeVideoId: Value(youtubeVideoId),
      isFavorite: Value(isFavorite),
      searchedTitle: searchedTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(searchedTitle),
      searchedArtist: searchedArtist == null && nullToAbsent
          ? const Value.absent()
          : Value(searchedArtist),
    );
  }

  factory LocalVideoPref.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalVideoPref(
      uid: serializer.fromJson<String>(json['uid']),
      youtubeVideoId: serializer.fromJson<String>(json['youtubeVideoId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      searchedTitle: serializer.fromJson<String?>(json['searchedTitle']),
      searchedArtist: serializer.fromJson<String?>(json['searchedArtist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'youtubeVideoId': serializer.toJson<String>(youtubeVideoId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'searchedTitle': serializer.toJson<String?>(searchedTitle),
      'searchedArtist': serializer.toJson<String?>(searchedArtist),
    };
  }

  LocalVideoPref copyWith({
    String? uid,
    String? youtubeVideoId,
    bool? isFavorite,
    Value<String?> searchedTitle = const Value.absent(),
    Value<String?> searchedArtist = const Value.absent(),
  }) => LocalVideoPref(
    uid: uid ?? this.uid,
    youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
    isFavorite: isFavorite ?? this.isFavorite,
    searchedTitle: searchedTitle.present
        ? searchedTitle.value
        : this.searchedTitle,
    searchedArtist: searchedArtist.present
        ? searchedArtist.value
        : this.searchedArtist,
  );
  LocalVideoPref copyWithCompanion(LocalVideoPrefsCompanion data) {
    return LocalVideoPref(
      uid: data.uid.present ? data.uid.value : this.uid,
      youtubeVideoId: data.youtubeVideoId.present
          ? data.youtubeVideoId.value
          : this.youtubeVideoId,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      searchedTitle: data.searchedTitle.present
          ? data.searchedTitle.value
          : this.searchedTitle,
      searchedArtist: data.searchedArtist.present
          ? data.searchedArtist.value
          : this.searchedArtist,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalVideoPref(')
          ..write('uid: $uid, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('searchedTitle: $searchedTitle, ')
          ..write('searchedArtist: $searchedArtist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    youtubeVideoId,
    isFavorite,
    searchedTitle,
    searchedArtist,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalVideoPref &&
          other.uid == this.uid &&
          other.youtubeVideoId == this.youtubeVideoId &&
          other.isFavorite == this.isFavorite &&
          other.searchedTitle == this.searchedTitle &&
          other.searchedArtist == this.searchedArtist);
}

class LocalVideoPrefsCompanion extends UpdateCompanion<LocalVideoPref> {
  final Value<String> uid;
  final Value<String> youtubeVideoId;
  final Value<bool> isFavorite;
  final Value<String?> searchedTitle;
  final Value<String?> searchedArtist;
  final Value<int> rowid;
  const LocalVideoPrefsCompanion({
    this.uid = const Value.absent(),
    this.youtubeVideoId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.searchedTitle = const Value.absent(),
    this.searchedArtist = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalVideoPrefsCompanion.insert({
    required String uid,
    required String youtubeVideoId,
    this.isFavorite = const Value.absent(),
    this.searchedTitle = const Value.absent(),
    this.searchedArtist = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       youtubeVideoId = Value(youtubeVideoId);
  static Insertable<LocalVideoPref> custom({
    Expression<String>? uid,
    Expression<String>? youtubeVideoId,
    Expression<bool>? isFavorite,
    Expression<String>? searchedTitle,
    Expression<String>? searchedArtist,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (youtubeVideoId != null) 'youtube_video_id': youtubeVideoId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (searchedTitle != null) 'searched_title': searchedTitle,
      if (searchedArtist != null) 'searched_artist': searchedArtist,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalVideoPrefsCompanion copyWith({
    Value<String>? uid,
    Value<String>? youtubeVideoId,
    Value<bool>? isFavorite,
    Value<String?>? searchedTitle,
    Value<String?>? searchedArtist,
    Value<int>? rowid,
  }) {
    return LocalVideoPrefsCompanion(
      uid: uid ?? this.uid,
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      isFavorite: isFavorite ?? this.isFavorite,
      searchedTitle: searchedTitle ?? this.searchedTitle,
      searchedArtist: searchedArtist ?? this.searchedArtist,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (youtubeVideoId.present) {
      map['youtube_video_id'] = Variable<String>(youtubeVideoId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (searchedTitle.present) {
      map['searched_title'] = Variable<String>(searchedTitle.value);
    }
    if (searchedArtist.present) {
      map['searched_artist'] = Variable<String>(searchedArtist.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalVideoPrefsCompanion(')
          ..write('uid: $uid, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('searchedTitle: $searchedTitle, ')
          ..write('searchedArtist: $searchedArtist, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
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
  static const VerificationMeta _lastLoginMeta = const VerificationMeta(
    'lastLogin',
  );
  @override
  late final GeneratedColumn<DateTime> lastLogin = GeneratedColumn<DateTime>(
    'last_login',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    email,
    displayName,
    photoUrl,
    lastLogin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('last_login')) {
      context.handle(
        _lastLoginMeta,
        lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      lastLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_login'],
      ),
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final DateTime? lastLogin;
  const LocalUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.lastLogin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin);
    }
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      uid: Value(uid),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String?>(json['email']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      lastLogin: serializer.fromJson<DateTime?>(json['lastLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String?>(email),
      'displayName': serializer.toJson<String?>(displayName),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'lastLogin': serializer.toJson<DateTime?>(lastLogin),
    };
  }

  LocalUser copyWith({
    String? uid,
    Value<String?> email = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<DateTime?> lastLogin = const Value.absent(),
  }) => LocalUser(
    uid: uid ?? this.uid,
    email: email.present ? email.value : this.email,
    displayName: displayName.present ? displayName.value : this.displayName,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      uid: data.uid.present ? data.uid.value : this.uid,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('lastLogin: $lastLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uid, email, displayName, photoUrl, lastLogin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.photoUrl == this.photoUrl &&
          other.lastLogin == this.lastLogin);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> uid;
  final Value<String?> email;
  final Value<String?> displayName;
  final Value<String?> photoUrl;
  final Value<DateTime?> lastLogin;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String uid,
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid);
  static Insertable<LocalUser> custom({
    Expression<String>? uid,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? photoUrl,
    Expression<DateTime>? lastLogin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (lastLogin != null) 'last_login': lastLogin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith({
    Value<String>? uid,
    Value<String?>? email,
    Value<String?>? displayName,
    Value<String?>? photoUrl,
    Value<DateTime?>? lastLogin,
    Value<int>? rowid,
  }) {
    return LocalUsersCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      lastLogin: lastLogin ?? this.lastLogin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime>(lastLogin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalVideosTable extends LocalVideos
    with TableInfo<$LocalVideosTable, LocalVideo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalVideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _youtubeVideoIdMeta = const VerificationMeta(
    'youtubeVideoId',
  );
  @override
  late final GeneratedColumn<String> youtubeVideoId = GeneratedColumn<String>(
    'youtube_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasLyricsMeta = const VerificationMeta(
    'hasLyrics',
  );
  @override
  late final GeneratedColumn<bool> hasLyrics = GeneratedColumn<bool>(
    'has_lyrics',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_lyrics" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isAnalyzedMeta = const VerificationMeta(
    'isAnalyzed',
  );
  @override
  late final GeneratedColumn<bool> isAnalyzed = GeneratedColumn<bool>(
    'is_analyzed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_analyzed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    youtubeVideoId,
    title,
    artist,
    thumbnailUrl,
    hasLyrics,
    isAnalyzed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalVideo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('youtube_video_id')) {
      context.handle(
        _youtubeVideoIdMeta,
        youtubeVideoId.isAcceptableOrUnknown(
          data['youtube_video_id']!,
          _youtubeVideoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_youtubeVideoIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thumbnailUrlMeta);
    }
    if (data.containsKey('has_lyrics')) {
      context.handle(
        _hasLyricsMeta,
        hasLyrics.isAcceptableOrUnknown(data['has_lyrics']!, _hasLyricsMeta),
      );
    }
    if (data.containsKey('is_analyzed')) {
      context.handle(
        _isAnalyzedMeta,
        isAnalyzed.isAcceptableOrUnknown(data['is_analyzed']!, _isAnalyzedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {youtubeVideoId};
  @override
  LocalVideo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalVideo(
      youtubeVideoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_video_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      )!,
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      )!,
      hasLyrics: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_lyrics'],
      )!,
      isAnalyzed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_analyzed'],
      )!,
    );
  }

  @override
  $LocalVideosTable createAlias(String alias) {
    return $LocalVideosTable(attachedDatabase, alias);
  }
}

class LocalVideo extends DataClass implements Insertable<LocalVideo> {
  final String youtubeVideoId;
  final String title;
  final String artist;
  final String thumbnailUrl;
  final bool hasLyrics;
  final bool isAnalyzed;
  const LocalVideo({
    required this.youtubeVideoId,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.hasLyrics,
    required this.isAnalyzed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['youtube_video_id'] = Variable<String>(youtubeVideoId);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    map['has_lyrics'] = Variable<bool>(hasLyrics);
    map['is_analyzed'] = Variable<bool>(isAnalyzed);
    return map;
  }

  LocalVideosCompanion toCompanion(bool nullToAbsent) {
    return LocalVideosCompanion(
      youtubeVideoId: Value(youtubeVideoId),
      title: Value(title),
      artist: Value(artist),
      thumbnailUrl: Value(thumbnailUrl),
      hasLyrics: Value(hasLyrics),
      isAnalyzed: Value(isAnalyzed),
    );
  }

  factory LocalVideo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalVideo(
      youtubeVideoId: serializer.fromJson<String>(json['youtubeVideoId']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      thumbnailUrl: serializer.fromJson<String>(json['thumbnailUrl']),
      hasLyrics: serializer.fromJson<bool>(json['hasLyrics']),
      isAnalyzed: serializer.fromJson<bool>(json['isAnalyzed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'youtubeVideoId': serializer.toJson<String>(youtubeVideoId),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'thumbnailUrl': serializer.toJson<String>(thumbnailUrl),
      'hasLyrics': serializer.toJson<bool>(hasLyrics),
      'isAnalyzed': serializer.toJson<bool>(isAnalyzed),
    };
  }

  LocalVideo copyWith({
    String? youtubeVideoId,
    String? title,
    String? artist,
    String? thumbnailUrl,
    bool? hasLyrics,
    bool? isAnalyzed,
  }) => LocalVideo(
    youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    hasLyrics: hasLyrics ?? this.hasLyrics,
    isAnalyzed: isAnalyzed ?? this.isAnalyzed,
  );
  LocalVideo copyWithCompanion(LocalVideosCompanion data) {
    return LocalVideo(
      youtubeVideoId: data.youtubeVideoId.present
          ? data.youtubeVideoId.value
          : this.youtubeVideoId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      hasLyrics: data.hasLyrics.present ? data.hasLyrics.value : this.hasLyrics,
      isAnalyzed: data.isAnalyzed.present
          ? data.isAnalyzed.value
          : this.isAnalyzed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalVideo(')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('hasLyrics: $hasLyrics, ')
          ..write('isAnalyzed: $isAnalyzed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    youtubeVideoId,
    title,
    artist,
    thumbnailUrl,
    hasLyrics,
    isAnalyzed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalVideo &&
          other.youtubeVideoId == this.youtubeVideoId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.hasLyrics == this.hasLyrics &&
          other.isAnalyzed == this.isAnalyzed);
}

class LocalVideosCompanion extends UpdateCompanion<LocalVideo> {
  final Value<String> youtubeVideoId;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> thumbnailUrl;
  final Value<bool> hasLyrics;
  final Value<bool> isAnalyzed;
  final Value<int> rowid;
  const LocalVideosCompanion({
    this.youtubeVideoId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.hasLyrics = const Value.absent(),
    this.isAnalyzed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalVideosCompanion.insert({
    required String youtubeVideoId,
    required String title,
    required String artist,
    required String thumbnailUrl,
    this.hasLyrics = const Value.absent(),
    this.isAnalyzed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : youtubeVideoId = Value(youtubeVideoId),
       title = Value(title),
       artist = Value(artist),
       thumbnailUrl = Value(thumbnailUrl);
  static Insertable<LocalVideo> custom({
    Expression<String>? youtubeVideoId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? thumbnailUrl,
    Expression<bool>? hasLyrics,
    Expression<bool>? isAnalyzed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (youtubeVideoId != null) 'youtube_video_id': youtubeVideoId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (hasLyrics != null) 'has_lyrics': hasLyrics,
      if (isAnalyzed != null) 'is_analyzed': isAnalyzed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalVideosCompanion copyWith({
    Value<String>? youtubeVideoId,
    Value<String>? title,
    Value<String>? artist,
    Value<String>? thumbnailUrl,
    Value<bool>? hasLyrics,
    Value<bool>? isAnalyzed,
    Value<int>? rowid,
  }) {
    return LocalVideosCompanion(
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      isAnalyzed: isAnalyzed ?? this.isAnalyzed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (youtubeVideoId.present) {
      map['youtube_video_id'] = Variable<String>(youtubeVideoId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (hasLyrics.present) {
      map['has_lyrics'] = Variable<bool>(hasLyrics.value);
    }
    if (isAnalyzed.present) {
      map['is_analyzed'] = Variable<bool>(isAnalyzed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalVideosCompanion(')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('hasLyrics: $hasLyrics, ')
          ..write('isAnalyzed: $isAnalyzed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalLyricsTable extends LocalLyrics
    with TableInfo<$LocalLyricsTable, LocalLyric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalLyricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _youtubeVideoIdMeta = const VerificationMeta(
    'youtubeVideoId',
  );
  @override
  late final GeneratedColumn<String> youtubeVideoId = GeneratedColumn<String>(
    'youtube_video_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_videos (youtube_video_id)',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _startTimeMsMeta = const VerificationMeta(
    'startTimeMs',
  );
  @override
  late final GeneratedColumn<int> startTimeMs = GeneratedColumn<int>(
    'start_time_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    youtubeVideoId,
    order,
    content,
    translation,
    notes,
    startTimeMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_lyrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalLyric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('youtube_video_id')) {
      context.handle(
        _youtubeVideoIdMeta,
        youtubeVideoId.isAcceptableOrUnknown(
          data['youtube_video_id']!,
          _youtubeVideoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_youtubeVideoIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('start_time_ms')) {
      context.handle(
        _startTimeMsMeta,
        startTimeMs.isAcceptableOrUnknown(
          data['start_time_ms']!,
          _startTimeMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalLyric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalLyric(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      youtubeVideoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}youtube_video_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      startTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_time_ms'],
      ),
    );
  }

  @override
  $LocalLyricsTable createAlias(String alias) {
    return $LocalLyricsTable(attachedDatabase, alias);
  }
}

class LocalLyric extends DataClass implements Insertable<LocalLyric> {
  final int id;
  final String youtubeVideoId;
  final int order;
  final String content;
  final String translation;
  final String notes;
  final int? startTimeMs;
  const LocalLyric({
    required this.id,
    required this.youtubeVideoId,
    required this.order,
    required this.content,
    required this.translation,
    required this.notes,
    this.startTimeMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['youtube_video_id'] = Variable<String>(youtubeVideoId);
    map['order'] = Variable<int>(order);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || startTimeMs != null) {
      map['start_time_ms'] = Variable<int>(startTimeMs);
    }
    return map;
  }

  LocalLyricsCompanion toCompanion(bool nullToAbsent) {
    return LocalLyricsCompanion(
      id: Value(id),
      youtubeVideoId: Value(youtubeVideoId),
      order: Value(order),
      content: Value(content),
      translation: Value(translation),
      notes: Value(notes),
      startTimeMs: startTimeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(startTimeMs),
    );
  }

  factory LocalLyric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalLyric(
      id: serializer.fromJson<int>(json['id']),
      youtubeVideoId: serializer.fromJson<String>(json['youtubeVideoId']),
      order: serializer.fromJson<int>(json['order']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
      notes: serializer.fromJson<String>(json['notes']),
      startTimeMs: serializer.fromJson<int?>(json['startTimeMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'youtubeVideoId': serializer.toJson<String>(youtubeVideoId),
      'order': serializer.toJson<int>(order),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
      'notes': serializer.toJson<String>(notes),
      'startTimeMs': serializer.toJson<int?>(startTimeMs),
    };
  }

  LocalLyric copyWith({
    int? id,
    String? youtubeVideoId,
    int? order,
    String? content,
    String? translation,
    String? notes,
    Value<int?> startTimeMs = const Value.absent(),
  }) => LocalLyric(
    id: id ?? this.id,
    youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
    order: order ?? this.order,
    content: content ?? this.content,
    translation: translation ?? this.translation,
    notes: notes ?? this.notes,
    startTimeMs: startTimeMs.present ? startTimeMs.value : this.startTimeMs,
  );
  LocalLyric copyWithCompanion(LocalLyricsCompanion data) {
    return LocalLyric(
      id: data.id.present ? data.id.value : this.id,
      youtubeVideoId: data.youtubeVideoId.present
          ? data.youtubeVideoId.value
          : this.youtubeVideoId,
      order: data.order.present ? data.order.value : this.order,
      content: data.content.present ? data.content.value : this.content,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      notes: data.notes.present ? data.notes.value : this.notes,
      startTimeMs: data.startTimeMs.present
          ? data.startTimeMs.value
          : this.startTimeMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalLyric(')
          ..write('id: $id, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('order: $order, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('notes: $notes, ')
          ..write('startTimeMs: $startTimeMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    youtubeVideoId,
    order,
    content,
    translation,
    notes,
    startTimeMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalLyric &&
          other.id == this.id &&
          other.youtubeVideoId == this.youtubeVideoId &&
          other.order == this.order &&
          other.content == this.content &&
          other.translation == this.translation &&
          other.notes == this.notes &&
          other.startTimeMs == this.startTimeMs);
}

class LocalLyricsCompanion extends UpdateCompanion<LocalLyric> {
  final Value<int> id;
  final Value<String> youtubeVideoId;
  final Value<int> order;
  final Value<String> content;
  final Value<String> translation;
  final Value<String> notes;
  final Value<int?> startTimeMs;
  const LocalLyricsCompanion({
    this.id = const Value.absent(),
    this.youtubeVideoId = const Value.absent(),
    this.order = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
    this.notes = const Value.absent(),
    this.startTimeMs = const Value.absent(),
  });
  LocalLyricsCompanion.insert({
    this.id = const Value.absent(),
    required String youtubeVideoId,
    required int order,
    required String content,
    required String translation,
    this.notes = const Value.absent(),
    this.startTimeMs = const Value.absent(),
  }) : youtubeVideoId = Value(youtubeVideoId),
       order = Value(order),
       content = Value(content),
       translation = Value(translation);
  static Insertable<LocalLyric> custom({
    Expression<int>? id,
    Expression<String>? youtubeVideoId,
    Expression<int>? order,
    Expression<String>? content,
    Expression<String>? translation,
    Expression<String>? notes,
    Expression<int>? startTimeMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (youtubeVideoId != null) 'youtube_video_id': youtubeVideoId,
      if (order != null) 'order': order,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
      if (notes != null) 'notes': notes,
      if (startTimeMs != null) 'start_time_ms': startTimeMs,
    });
  }

  LocalLyricsCompanion copyWith({
    Value<int>? id,
    Value<String>? youtubeVideoId,
    Value<int>? order,
    Value<String>? content,
    Value<String>? translation,
    Value<String>? notes,
    Value<int?>? startTimeMs,
  }) {
    return LocalLyricsCompanion(
      id: id ?? this.id,
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      order: order ?? this.order,
      content: content ?? this.content,
      translation: translation ?? this.translation,
      notes: notes ?? this.notes,
      startTimeMs: startTimeMs ?? this.startTimeMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (youtubeVideoId.present) {
      map['youtube_video_id'] = Variable<String>(youtubeVideoId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startTimeMs.present) {
      map['start_time_ms'] = Variable<int>(startTimeMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalLyricsCompanion(')
          ..write('id: $id, ')
          ..write('youtubeVideoId: $youtubeVideoId, ')
          ..write('order: $order, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('notes: $notes, ')
          ..write('startTimeMs: $startTimeMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftDB extends GeneratedDatabase {
  _$DriftDB(QueryExecutor e) : super(e);
  $DriftDBManager get managers => $DriftDBManager(this);
  late final $LocalStudyHistoryTable localStudyHistory =
      $LocalStudyHistoryTable(this);
  late final $LocalVideoPrefsTable localVideoPrefs = $LocalVideoPrefsTable(
    this,
  );
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $LocalVideosTable localVideos = $LocalVideosTable(this);
  late final $LocalLyricsTable localLyrics = $LocalLyricsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localStudyHistory,
    localVideoPrefs,
    localUsers,
    localVideos,
    localLyrics,
  ];
}

typedef $$LocalStudyHistoryTableCreateCompanionBuilder =
    LocalStudyHistoryCompanion Function({
      Value<int> recordId,
      required String uid,
      required String youtubeVideoId,
      required DateTime studiedAt,
    });
typedef $$LocalStudyHistoryTableUpdateCompanionBuilder =
    LocalStudyHistoryCompanion Function({
      Value<int> recordId,
      Value<String> uid,
      Value<String> youtubeVideoId,
      Value<DateTime> studiedAt,
    });

class $$LocalStudyHistoryTableFilterComposer
    extends Composer<_$DriftDB, $LocalStudyHistoryTable> {
  $$LocalStudyHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get studiedAt => $composableBuilder(
    column: $table.studiedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalStudyHistoryTableOrderingComposer
    extends Composer<_$DriftDB, $LocalStudyHistoryTable> {
  $$LocalStudyHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get studiedAt => $composableBuilder(
    column: $table.studiedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalStudyHistoryTableAnnotationComposer
    extends Composer<_$DriftDB, $LocalStudyHistoryTable> {
  $$LocalStudyHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get studiedAt =>
      $composableBuilder(column: $table.studiedAt, builder: (column) => column);
}

class $$LocalStudyHistoryTableTableManager
    extends
        RootTableManager<
          _$DriftDB,
          $LocalStudyHistoryTable,
          LocalStudyHistoryData,
          $$LocalStudyHistoryTableFilterComposer,
          $$LocalStudyHistoryTableOrderingComposer,
          $$LocalStudyHistoryTableAnnotationComposer,
          $$LocalStudyHistoryTableCreateCompanionBuilder,
          $$LocalStudyHistoryTableUpdateCompanionBuilder,
          (
            LocalStudyHistoryData,
            BaseReferences<
              _$DriftDB,
              $LocalStudyHistoryTable,
              LocalStudyHistoryData
            >,
          ),
          LocalStudyHistoryData,
          PrefetchHooks Function()
        > {
  $$LocalStudyHistoryTableTableManager(
    _$DriftDB db,
    $LocalStudyHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalStudyHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalStudyHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalStudyHistoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> recordId = const Value.absent(),
                Value<String> uid = const Value.absent(),
                Value<String> youtubeVideoId = const Value.absent(),
                Value<DateTime> studiedAt = const Value.absent(),
              }) => LocalStudyHistoryCompanion(
                recordId: recordId,
                uid: uid,
                youtubeVideoId: youtubeVideoId,
                studiedAt: studiedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> recordId = const Value.absent(),
                required String uid,
                required String youtubeVideoId,
                required DateTime studiedAt,
              }) => LocalStudyHistoryCompanion.insert(
                recordId: recordId,
                uid: uid,
                youtubeVideoId: youtubeVideoId,
                studiedAt: studiedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalStudyHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDB,
      $LocalStudyHistoryTable,
      LocalStudyHistoryData,
      $$LocalStudyHistoryTableFilterComposer,
      $$LocalStudyHistoryTableOrderingComposer,
      $$LocalStudyHistoryTableAnnotationComposer,
      $$LocalStudyHistoryTableCreateCompanionBuilder,
      $$LocalStudyHistoryTableUpdateCompanionBuilder,
      (
        LocalStudyHistoryData,
        BaseReferences<
          _$DriftDB,
          $LocalStudyHistoryTable,
          LocalStudyHistoryData
        >,
      ),
      LocalStudyHistoryData,
      PrefetchHooks Function()
    >;
typedef $$LocalVideoPrefsTableCreateCompanionBuilder =
    LocalVideoPrefsCompanion Function({
      required String uid,
      required String youtubeVideoId,
      Value<bool> isFavorite,
      Value<String?> searchedTitle,
      Value<String?> searchedArtist,
      Value<int> rowid,
    });
typedef $$LocalVideoPrefsTableUpdateCompanionBuilder =
    LocalVideoPrefsCompanion Function({
      Value<String> uid,
      Value<String> youtubeVideoId,
      Value<bool> isFavorite,
      Value<String?> searchedTitle,
      Value<String?> searchedArtist,
      Value<int> rowid,
    });

class $$LocalVideoPrefsTableFilterComposer
    extends Composer<_$DriftDB, $LocalVideoPrefsTable> {
  $$LocalVideoPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchedTitle => $composableBuilder(
    column: $table.searchedTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchedArtist => $composableBuilder(
    column: $table.searchedArtist,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalVideoPrefsTableOrderingComposer
    extends Composer<_$DriftDB, $LocalVideoPrefsTable> {
  $$LocalVideoPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchedTitle => $composableBuilder(
    column: $table.searchedTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchedArtist => $composableBuilder(
    column: $table.searchedArtist,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalVideoPrefsTableAnnotationComposer
    extends Composer<_$DriftDB, $LocalVideoPrefsTable> {
  $$LocalVideoPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchedTitle => $composableBuilder(
    column: $table.searchedTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchedArtist => $composableBuilder(
    column: $table.searchedArtist,
    builder: (column) => column,
  );
}

class $$LocalVideoPrefsTableTableManager
    extends
        RootTableManager<
          _$DriftDB,
          $LocalVideoPrefsTable,
          LocalVideoPref,
          $$LocalVideoPrefsTableFilterComposer,
          $$LocalVideoPrefsTableOrderingComposer,
          $$LocalVideoPrefsTableAnnotationComposer,
          $$LocalVideoPrefsTableCreateCompanionBuilder,
          $$LocalVideoPrefsTableUpdateCompanionBuilder,
          (
            LocalVideoPref,
            BaseReferences<_$DriftDB, $LocalVideoPrefsTable, LocalVideoPref>,
          ),
          LocalVideoPref,
          PrefetchHooks Function()
        > {
  $$LocalVideoPrefsTableTableManager(_$DriftDB db, $LocalVideoPrefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalVideoPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalVideoPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalVideoPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String> youtubeVideoId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> searchedTitle = const Value.absent(),
                Value<String?> searchedArtist = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVideoPrefsCompanion(
                uid: uid,
                youtubeVideoId: youtubeVideoId,
                isFavorite: isFavorite,
                searchedTitle: searchedTitle,
                searchedArtist: searchedArtist,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                required String youtubeVideoId,
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> searchedTitle = const Value.absent(),
                Value<String?> searchedArtist = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVideoPrefsCompanion.insert(
                uid: uid,
                youtubeVideoId: youtubeVideoId,
                isFavorite: isFavorite,
                searchedTitle: searchedTitle,
                searchedArtist: searchedArtist,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalVideoPrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDB,
      $LocalVideoPrefsTable,
      LocalVideoPref,
      $$LocalVideoPrefsTableFilterComposer,
      $$LocalVideoPrefsTableOrderingComposer,
      $$LocalVideoPrefsTableAnnotationComposer,
      $$LocalVideoPrefsTableCreateCompanionBuilder,
      $$LocalVideoPrefsTableUpdateCompanionBuilder,
      (
        LocalVideoPref,
        BaseReferences<_$DriftDB, $LocalVideoPrefsTable, LocalVideoPref>,
      ),
      LocalVideoPref,
      PrefetchHooks Function()
    >;
typedef $$LocalUsersTableCreateCompanionBuilder =
    LocalUsersCompanion Function({
      required String uid,
      Value<String?> email,
      Value<String?> displayName,
      Value<String?> photoUrl,
      Value<DateTime?> lastLogin,
      Value<int> rowid,
    });
typedef $$LocalUsersTableUpdateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<String> uid,
      Value<String?> email,
      Value<String?> displayName,
      Value<String?> photoUrl,
      Value<DateTime?> lastLogin,
      Value<int> rowid,
    });

class $$LocalUsersTableFilterComposer
    extends Composer<_$DriftDB, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$DriftDB, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$DriftDB, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$DriftDB,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (LocalUser, BaseReferences<_$DriftDB, $LocalUsersTable, LocalUser>),
          LocalUser,
          PrefetchHooks Function()
        > {
  $$LocalUsersTableTableManager(_$DriftDB db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime?> lastLogin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion(
                uid: uid,
                email: email,
                displayName: displayName,
                photoUrl: photoUrl,
                lastLogin: lastLogin,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                Value<String?> email = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime?> lastLogin = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion.insert(
                uid: uid,
                email: email,
                displayName: displayName,
                photoUrl: photoUrl,
                lastLogin: lastLogin,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDB,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, BaseReferences<_$DriftDB, $LocalUsersTable, LocalUser>),
      LocalUser,
      PrefetchHooks Function()
    >;
typedef $$LocalVideosTableCreateCompanionBuilder =
    LocalVideosCompanion Function({
      required String youtubeVideoId,
      required String title,
      required String artist,
      required String thumbnailUrl,
      Value<bool> hasLyrics,
      Value<bool> isAnalyzed,
      Value<int> rowid,
    });
typedef $$LocalVideosTableUpdateCompanionBuilder =
    LocalVideosCompanion Function({
      Value<String> youtubeVideoId,
      Value<String> title,
      Value<String> artist,
      Value<String> thumbnailUrl,
      Value<bool> hasLyrics,
      Value<bool> isAnalyzed,
      Value<int> rowid,
    });

final class $$LocalVideosTableReferences
    extends BaseReferences<_$DriftDB, $LocalVideosTable, LocalVideo> {
  $$LocalVideosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalLyricsTable, List<LocalLyric>>
  _localLyricsRefsTable(_$DriftDB db) => MultiTypedResultKey.fromTable(
    db.localLyrics,
    aliasName: $_aliasNameGenerator(
      db.localVideos.youtubeVideoId,
      db.localLyrics.youtubeVideoId,
    ),
  );

  $$LocalLyricsTableProcessedTableManager get localLyricsRefs {
    final manager = $$LocalLyricsTableTableManager($_db, $_db.localLyrics)
        .filter(
          (f) => f.youtubeVideoId.youtubeVideoId.sqlEquals(
            $_itemColumn<String>('youtube_video_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_localLyricsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalVideosTableFilterComposer
    extends Composer<_$DriftDB, $LocalVideosTable> {
  $$LocalVideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasLyrics => $composableBuilder(
    column: $table.hasLyrics,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAnalyzed => $composableBuilder(
    column: $table.isAnalyzed,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localLyricsRefs(
    Expression<bool> Function($$LocalLyricsTableFilterComposer f) f,
  ) {
    final $$LocalLyricsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.youtubeVideoId,
      referencedTable: $db.localLyrics,
      getReferencedColumn: (t) => t.youtubeVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalLyricsTableFilterComposer(
            $db: $db,
            $table: $db.localLyrics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalVideosTableOrderingComposer
    extends Composer<_$DriftDB, $LocalVideosTable> {
  $$LocalVideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasLyrics => $composableBuilder(
    column: $table.hasLyrics,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAnalyzed => $composableBuilder(
    column: $table.isAnalyzed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalVideosTableAnnotationComposer
    extends Composer<_$DriftDB, $LocalVideosTable> {
  $$LocalVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get youtubeVideoId => $composableBuilder(
    column: $table.youtubeVideoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasLyrics =>
      $composableBuilder(column: $table.hasLyrics, builder: (column) => column);

  GeneratedColumn<bool> get isAnalyzed => $composableBuilder(
    column: $table.isAnalyzed,
    builder: (column) => column,
  );

  Expression<T> localLyricsRefs<T extends Object>(
    Expression<T> Function($$LocalLyricsTableAnnotationComposer a) f,
  ) {
    final $$LocalLyricsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.youtubeVideoId,
      referencedTable: $db.localLyrics,
      getReferencedColumn: (t) => t.youtubeVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalLyricsTableAnnotationComposer(
            $db: $db,
            $table: $db.localLyrics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalVideosTableTableManager
    extends
        RootTableManager<
          _$DriftDB,
          $LocalVideosTable,
          LocalVideo,
          $$LocalVideosTableFilterComposer,
          $$LocalVideosTableOrderingComposer,
          $$LocalVideosTableAnnotationComposer,
          $$LocalVideosTableCreateCompanionBuilder,
          $$LocalVideosTableUpdateCompanionBuilder,
          (LocalVideo, $$LocalVideosTableReferences),
          LocalVideo,
          PrefetchHooks Function({bool localLyricsRefs})
        > {
  $$LocalVideosTableTableManager(_$DriftDB db, $LocalVideosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalVideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalVideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> youtubeVideoId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> artist = const Value.absent(),
                Value<String> thumbnailUrl = const Value.absent(),
                Value<bool> hasLyrics = const Value.absent(),
                Value<bool> isAnalyzed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVideosCompanion(
                youtubeVideoId: youtubeVideoId,
                title: title,
                artist: artist,
                thumbnailUrl: thumbnailUrl,
                hasLyrics: hasLyrics,
                isAnalyzed: isAnalyzed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String youtubeVideoId,
                required String title,
                required String artist,
                required String thumbnailUrl,
                Value<bool> hasLyrics = const Value.absent(),
                Value<bool> isAnalyzed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVideosCompanion.insert(
                youtubeVideoId: youtubeVideoId,
                title: title,
                artist: artist,
                thumbnailUrl: thumbnailUrl,
                hasLyrics: hasLyrics,
                isAnalyzed: isAnalyzed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalVideosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({localLyricsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (localLyricsRefs) db.localLyrics],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localLyricsRefs)
                    await $_getPrefetchedData<
                      LocalVideo,
                      $LocalVideosTable,
                      LocalLyric
                    >(
                      currentTable: table,
                      referencedTable: $$LocalVideosTableReferences
                          ._localLyricsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LocalVideosTableReferences(
                            db,
                            table,
                            p0,
                          ).localLyricsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.youtubeVideoId == item.youtubeVideoId,
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

typedef $$LocalVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDB,
      $LocalVideosTable,
      LocalVideo,
      $$LocalVideosTableFilterComposer,
      $$LocalVideosTableOrderingComposer,
      $$LocalVideosTableAnnotationComposer,
      $$LocalVideosTableCreateCompanionBuilder,
      $$LocalVideosTableUpdateCompanionBuilder,
      (LocalVideo, $$LocalVideosTableReferences),
      LocalVideo,
      PrefetchHooks Function({bool localLyricsRefs})
    >;
typedef $$LocalLyricsTableCreateCompanionBuilder =
    LocalLyricsCompanion Function({
      Value<int> id,
      required String youtubeVideoId,
      required int order,
      required String content,
      required String translation,
      Value<String> notes,
      Value<int?> startTimeMs,
    });
typedef $$LocalLyricsTableUpdateCompanionBuilder =
    LocalLyricsCompanion Function({
      Value<int> id,
      Value<String> youtubeVideoId,
      Value<int> order,
      Value<String> content,
      Value<String> translation,
      Value<String> notes,
      Value<int?> startTimeMs,
    });

final class $$LocalLyricsTableReferences
    extends BaseReferences<_$DriftDB, $LocalLyricsTable, LocalLyric> {
  $$LocalLyricsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalVideosTable _youtubeVideoIdTable(_$DriftDB db) =>
      db.localVideos.createAlias(
        $_aliasNameGenerator(
          db.localLyrics.youtubeVideoId,
          db.localVideos.youtubeVideoId,
        ),
      );

  $$LocalVideosTableProcessedTableManager get youtubeVideoId {
    final $_column = $_itemColumn<String>('youtube_video_id')!;

    final manager = $$LocalVideosTableTableManager(
      $_db,
      $_db.localVideos,
    ).filter((f) => f.youtubeVideoId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_youtubeVideoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalLyricsTableFilterComposer
    extends Composer<_$DriftDB, $LocalLyricsTable> {
  $$LocalLyricsTableFilterComposer({
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

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTimeMs => $composableBuilder(
    column: $table.startTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalVideosTableFilterComposer get youtubeVideoId {
    final $$LocalVideosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.youtubeVideoId,
      referencedTable: $db.localVideos,
      getReferencedColumn: (t) => t.youtubeVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalVideosTableFilterComposer(
            $db: $db,
            $table: $db.localVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalLyricsTableOrderingComposer
    extends Composer<_$DriftDB, $LocalLyricsTable> {
  $$LocalLyricsTableOrderingComposer({
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

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTimeMs => $composableBuilder(
    column: $table.startTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalVideosTableOrderingComposer get youtubeVideoId {
    final $$LocalVideosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.youtubeVideoId,
      referencedTable: $db.localVideos,
      getReferencedColumn: (t) => t.youtubeVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalVideosTableOrderingComposer(
            $db: $db,
            $table: $db.localVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalLyricsTableAnnotationComposer
    extends Composer<_$DriftDB, $LocalLyricsTable> {
  $$LocalLyricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get startTimeMs => $composableBuilder(
    column: $table.startTimeMs,
    builder: (column) => column,
  );

  $$LocalVideosTableAnnotationComposer get youtubeVideoId {
    final $$LocalVideosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.youtubeVideoId,
      referencedTable: $db.localVideos,
      getReferencedColumn: (t) => t.youtubeVideoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalVideosTableAnnotationComposer(
            $db: $db,
            $table: $db.localVideos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalLyricsTableTableManager
    extends
        RootTableManager<
          _$DriftDB,
          $LocalLyricsTable,
          LocalLyric,
          $$LocalLyricsTableFilterComposer,
          $$LocalLyricsTableOrderingComposer,
          $$LocalLyricsTableAnnotationComposer,
          $$LocalLyricsTableCreateCompanionBuilder,
          $$LocalLyricsTableUpdateCompanionBuilder,
          (LocalLyric, $$LocalLyricsTableReferences),
          LocalLyric,
          PrefetchHooks Function({bool youtubeVideoId})
        > {
  $$LocalLyricsTableTableManager(_$DriftDB db, $LocalLyricsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalLyricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalLyricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalLyricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> youtubeVideoId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> translation = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int?> startTimeMs = const Value.absent(),
              }) => LocalLyricsCompanion(
                id: id,
                youtubeVideoId: youtubeVideoId,
                order: order,
                content: content,
                translation: translation,
                notes: notes,
                startTimeMs: startTimeMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String youtubeVideoId,
                required int order,
                required String content,
                required String translation,
                Value<String> notes = const Value.absent(),
                Value<int?> startTimeMs = const Value.absent(),
              }) => LocalLyricsCompanion.insert(
                id: id,
                youtubeVideoId: youtubeVideoId,
                order: order,
                content: content,
                translation: translation,
                notes: notes,
                startTimeMs: startTimeMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalLyricsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({youtubeVideoId = false}) {
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
                    if (youtubeVideoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.youtubeVideoId,
                                referencedTable: $$LocalLyricsTableReferences
                                    ._youtubeVideoIdTable(db),
                                referencedColumn: $$LocalLyricsTableReferences
                                    ._youtubeVideoIdTable(db)
                                    .youtubeVideoId,
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

typedef $$LocalLyricsTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftDB,
      $LocalLyricsTable,
      LocalLyric,
      $$LocalLyricsTableFilterComposer,
      $$LocalLyricsTableOrderingComposer,
      $$LocalLyricsTableAnnotationComposer,
      $$LocalLyricsTableCreateCompanionBuilder,
      $$LocalLyricsTableUpdateCompanionBuilder,
      (LocalLyric, $$LocalLyricsTableReferences),
      LocalLyric,
      PrefetchHooks Function({bool youtubeVideoId})
    >;

class $DriftDBManager {
  final _$DriftDB _db;
  $DriftDBManager(this._db);
  $$LocalStudyHistoryTableTableManager get localStudyHistory =>
      $$LocalStudyHistoryTableTableManager(_db, _db.localStudyHistory);
  $$LocalVideoPrefsTableTableManager get localVideoPrefs =>
      $$LocalVideoPrefsTableTableManager(_db, _db.localVideoPrefs);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$LocalVideosTableTableManager get localVideos =>
      $$LocalVideosTableTableManager(_db, _db.localVideos);
  $$LocalLyricsTableTableManager get localLyrics =>
      $$LocalLyricsTableTableManager(_db, _db.localLyrics);
}
