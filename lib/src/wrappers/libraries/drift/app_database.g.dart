// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AuthenticatedPlayerLocalEntityTable
    extends AuthenticatedPlayerLocalEntity
    with
        TableInfo<$AuthenticatedPlayerLocalEntityTable,
            AuthenticatedPlayerLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthenticatedPlayerLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _playerNameMeta =
      const VerificationMeta('playerName');
  @override
  late final GeneratedColumn<String> playerName = GeneratedColumn<String>(
      'player_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playerNicknameMeta =
      const VerificationMeta('playerNickname');
  @override
  late final GeneratedColumn<String> playerNickname = GeneratedColumn<String>(
      'player_nickname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [playerId, playerName, playerNickname];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authenticated_player_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<AuthenticatedPlayerLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    }
    if (data.containsKey('player_name')) {
      context.handle(
          _playerNameMeta,
          playerName.isAcceptableOrUnknown(
              data['player_name']!, _playerNameMeta));
    } else if (isInserting) {
      context.missing(_playerNameMeta);
    }
    if (data.containsKey('player_nickname')) {
      context.handle(
          _playerNicknameMeta,
          playerNickname.isAcceptableOrUnknown(
              data['player_nickname']!, _playerNicknameMeta));
    } else if (isInserting) {
      context.missing(_playerNicknameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId};
  @override
  AuthenticatedPlayerLocalEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthenticatedPlayerLocalEntityData(
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      playerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_name'])!,
      playerNickname: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}player_nickname'])!,
    );
  }

  @override
  $AuthenticatedPlayerLocalEntityTable createAlias(String alias) {
    return $AuthenticatedPlayerLocalEntityTable(attachedDatabase, alias);
  }
}

class AuthenticatedPlayerLocalEntityData extends DataClass
    implements Insertable<AuthenticatedPlayerLocalEntityData> {
  final int playerId;
  final String playerName;
  final String playerNickname;
  const AuthenticatedPlayerLocalEntityData(
      {required this.playerId,
      required this.playerName,
      required this.playerNickname});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<int>(playerId);
    map['player_name'] = Variable<String>(playerName);
    map['player_nickname'] = Variable<String>(playerNickname);
    return map;
  }

  AuthenticatedPlayerLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return AuthenticatedPlayerLocalEntityCompanion(
      playerId: Value(playerId),
      playerName: Value(playerName),
      playerNickname: Value(playerNickname),
    );
  }

  factory AuthenticatedPlayerLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthenticatedPlayerLocalEntityData(
      playerId: serializer.fromJson<int>(json['playerId']),
      playerName: serializer.fromJson<String>(json['playerName']),
      playerNickname: serializer.fromJson<String>(json['playerNickname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<int>(playerId),
      'playerName': serializer.toJson<String>(playerName),
      'playerNickname': serializer.toJson<String>(playerNickname),
    };
  }

  AuthenticatedPlayerLocalEntityData copyWith(
          {int? playerId, String? playerName, String? playerNickname}) =>
      AuthenticatedPlayerLocalEntityData(
        playerId: playerId ?? this.playerId,
        playerName: playerName ?? this.playerName,
        playerNickname: playerNickname ?? this.playerNickname,
      );
  @override
  String toString() {
    return (StringBuffer('AuthenticatedPlayerLocalEntityData(')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('playerNickname: $playerNickname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playerId, playerName, playerNickname);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthenticatedPlayerLocalEntityData &&
          other.playerId == this.playerId &&
          other.playerName == this.playerName &&
          other.playerNickname == this.playerNickname);
}

class AuthenticatedPlayerLocalEntityCompanion
    extends UpdateCompanion<AuthenticatedPlayerLocalEntityData> {
  final Value<int> playerId;
  final Value<String> playerName;
  final Value<String> playerNickname;
  const AuthenticatedPlayerLocalEntityCompanion({
    this.playerId = const Value.absent(),
    this.playerName = const Value.absent(),
    this.playerNickname = const Value.absent(),
  });
  AuthenticatedPlayerLocalEntityCompanion.insert({
    this.playerId = const Value.absent(),
    required String playerName,
    required String playerNickname,
  })  : playerName = Value(playerName),
        playerNickname = Value(playerNickname);
  static Insertable<AuthenticatedPlayerLocalEntityData> custom({
    Expression<int>? playerId,
    Expression<String>? playerName,
    Expression<String>? playerNickname,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (playerName != null) 'player_name': playerName,
      if (playerNickname != null) 'player_nickname': playerNickname,
    });
  }

  AuthenticatedPlayerLocalEntityCompanion copyWith(
      {Value<int>? playerId,
      Value<String>? playerName,
      Value<String>? playerNickname}) {
    return AuthenticatedPlayerLocalEntityCompanion(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      playerNickname: playerNickname ?? this.playerNickname,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (playerName.present) {
      map['player_name'] = Variable<String>(playerName.value);
    }
    if (playerNickname.present) {
      map['player_nickname'] = Variable<String>(playerNickname.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthenticatedPlayerLocalEntityCompanion(')
          ..write('playerId: $playerId, ')
          ..write('playerName: $playerName, ')
          ..write('playerNickname: $playerNickname')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $AuthenticatedPlayerLocalEntityTable
      authenticatedPlayerLocalEntity =
      $AuthenticatedPlayerLocalEntityTable(this);
  Selectable<String> current_timestamp() {
    return customSelect('SELECT CURRENT_TIMESTAMP AS _c0',
        variables: [],
        readsFrom: {}).map((QueryRow row) => row.read<String>('_c0'));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [authenticatedPlayerLocalEntity];
}
