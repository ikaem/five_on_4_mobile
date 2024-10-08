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

class $MatchLocalEntityTable extends MatchLocalEntity
    with TableInfo<$MatchLocalEntityTable, MatchLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateAndTimeMeta =
      const VerificationMeta('dateAndTime');
  @override
  late final GeneratedColumn<int> dateAndTime = GeneratedColumn<int>(
      'date_and_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, dateAndTime, location, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'match_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<MatchLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
          _dateAndTimeMeta,
          dateAndTime.isAcceptableOrUnknown(
              data['date_and_time']!, _dateAndTimeMeta));
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchLocalEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      dateAndTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_and_time'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $MatchLocalEntityTable createAlias(String alias) {
    return $MatchLocalEntityTable(attachedDatabase, alias);
  }
}

class MatchLocalEntityData extends DataClass
    implements Insertable<MatchLocalEntityData> {
  final int id;
  final String title;
  final int dateAndTime;
  final String location;
  final String description;
  const MatchLocalEntityData(
      {required this.id,
      required this.title,
      required this.dateAndTime,
      required this.location,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['date_and_time'] = Variable<int>(dateAndTime);
    map['location'] = Variable<String>(location);
    map['description'] = Variable<String>(description);
    return map;
  }

  MatchLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return MatchLocalEntityCompanion(
      id: Value(id),
      title: Value(title),
      dateAndTime: Value(dateAndTime),
      location: Value(location),
      description: Value(description),
    );
  }

  factory MatchLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dateAndTime: serializer.fromJson<int>(json['dateAndTime']),
      location: serializer.fromJson<String>(json['location']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'dateAndTime': serializer.toJson<int>(dateAndTime),
      'location': serializer.toJson<String>(location),
      'description': serializer.toJson<String>(description),
    };
  }

  MatchLocalEntityData copyWith(
          {int? id,
          String? title,
          int? dateAndTime,
          String? location,
          String? description}) =>
      MatchLocalEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        dateAndTime: dateAndTime ?? this.dateAndTime,
        location: location ?? this.location,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('MatchLocalEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('location: $location, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, dateAndTime, location, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchLocalEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.dateAndTime == this.dateAndTime &&
          other.location == this.location &&
          other.description == this.description);
}

class MatchLocalEntityCompanion extends UpdateCompanion<MatchLocalEntityData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> dateAndTime;
  final Value<String> location;
  final Value<String> description;
  const MatchLocalEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.location = const Value.absent(),
    this.description = const Value.absent(),
  });
  MatchLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int dateAndTime,
    required String location,
    required String description,
  })  : title = Value(title),
        dateAndTime = Value(dateAndTime),
        location = Value(location),
        description = Value(description);
  static Insertable<MatchLocalEntityData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? dateAndTime,
    Expression<String>? location,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
    });
  }

  MatchLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? dateAndTime,
      Value<String>? location,
      Value<String>? description}) {
    return MatchLocalEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      location: location ?? this.location,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<int>(dateAndTime.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('location: $location, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $PlayerLocalEntityTable extends PlayerLocalEntity
    with TableInfo<$PlayerLocalEntityTable, PlayerLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerLocalEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, nickname, avatarUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayerLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    } else if (isInserting) {
      context.missing(_avatarUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerLocalEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname'])!,
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url'])!,
    );
  }

  @override
  $PlayerLocalEntityTable createAlias(String alias) {
    return $PlayerLocalEntityTable(attachedDatabase, alias);
  }
}

class PlayerLocalEntityData extends DataClass
    implements Insertable<PlayerLocalEntityData> {
  final int id;
  final String firstName;
  final String lastName;
  final String nickname;
  final String avatarUrl;
  const PlayerLocalEntityData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.nickname,
      required this.avatarUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['nickname'] = Variable<String>(nickname);
    map['avatar_url'] = Variable<String>(avatarUrl);
    return map;
  }

  PlayerLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return PlayerLocalEntityCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      nickname: Value(nickname),
      avatarUrl: Value(avatarUrl),
    );
  }

  factory PlayerLocalEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      nickname: serializer.fromJson<String>(json['nickname']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'nickname': serializer.toJson<String>(nickname),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
    };
  }

  PlayerLocalEntityData copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? nickname,
          String? avatarUrl}) =>
      PlayerLocalEntityData(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nickname: nickname ?? this.nickname,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );
  @override
  String toString() {
    return (StringBuffer('PlayerLocalEntityData(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickname: $nickname, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, nickname, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerLocalEntityData &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.nickname == this.nickname &&
          other.avatarUrl == this.avatarUrl);
}

class PlayerLocalEntityCompanion
    extends UpdateCompanion<PlayerLocalEntityData> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> nickname;
  final Value<String> avatarUrl;
  const PlayerLocalEntityCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.nickname = const Value.absent(),
    this.avatarUrl = const Value.absent(),
  });
  PlayerLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String nickname,
    required String avatarUrl,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        nickname = Value(nickname),
        avatarUrl = Value(avatarUrl);
  static Insertable<PlayerLocalEntityData> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? nickname,
    Expression<String>? avatarUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (nickname != null) 'nickname': nickname,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    });
  }

  PlayerLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? nickname,
      Value<String>? avatarUrl}) {
    return PlayerLocalEntityCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname ?? this.nickname,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickname: $nickname, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }
}

class $PlayerMatchParticipationLocalEntityTable
    extends PlayerMatchParticipationLocalEntity
    with
        TableInfo<$PlayerMatchParticipationLocalEntityTable,
            PlayerMatchParticipationLocalEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerMatchParticipationLocalEntityTable(this.attachedDatabase,
      [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<PlayerMatchParticipationStatus,
      int> status = GeneratedColumn<int>('status', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true)
      .withConverter<PlayerMatchParticipationStatus>(
          $PlayerMatchParticipationLocalEntityTable.$converterstatus);
  static const VerificationMeta _playerNicknameMeta =
      const VerificationMeta('playerNickname');
  @override
  late final GeneratedColumn<String> playerNickname = GeneratedColumn<String>(
      'player_nickname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _playerIdMeta =
      const VerificationMeta('playerId');
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
      'player_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES player_local_entity (id)'));
  static const VerificationMeta _matchIdMeta =
      const VerificationMeta('matchId');
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
      'match_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES match_local_entity (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, status, playerNickname, playerId, matchId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_match_participation_local_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlayerMatchParticipationLocalEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('player_nickname')) {
      context.handle(
          _playerNicknameMeta,
          playerNickname.isAcceptableOrUnknown(
              data['player_nickname']!, _playerNicknameMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(_playerIdMeta,
          playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta));
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('match_id')) {
      context.handle(_matchIdMeta,
          matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta));
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {playerId, matchId},
      ];
  @override
  PlayerMatchParticipationLocalEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerMatchParticipationLocalEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      status: $PlayerMatchParticipationLocalEntityTable.$converterstatus
          .fromSql(attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      playerNickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}player_nickname']),
      playerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}player_id'])!,
      matchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}match_id'])!,
    );
  }

  @override
  $PlayerMatchParticipationLocalEntityTable createAlias(String alias) {
    return $PlayerMatchParticipationLocalEntityTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlayerMatchParticipationStatus, int, int>
      $converterstatus =
      const EnumIndexConverter<PlayerMatchParticipationStatus>(
          PlayerMatchParticipationStatus.values);
}

class PlayerMatchParticipationLocalEntityData extends DataClass
    implements Insertable<PlayerMatchParticipationLocalEntityData> {
  final int id;
  final PlayerMatchParticipationStatus status;
  final String? playerNickname;
  final int playerId;
  final int matchId;
  const PlayerMatchParticipationLocalEntityData(
      {required this.id,
      required this.status,
      this.playerNickname,
      required this.playerId,
      required this.matchId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['status'] = Variable<int>($PlayerMatchParticipationLocalEntityTable
          .$converterstatus
          .toSql(status));
    }
    if (!nullToAbsent || playerNickname != null) {
      map['player_nickname'] = Variable<String>(playerNickname);
    }
    map['player_id'] = Variable<int>(playerId);
    map['match_id'] = Variable<int>(matchId);
    return map;
  }

  PlayerMatchParticipationLocalEntityCompanion toCompanion(bool nullToAbsent) {
    return PlayerMatchParticipationLocalEntityCompanion(
      id: Value(id),
      status: Value(status),
      playerNickname: playerNickname == null && nullToAbsent
          ? const Value.absent()
          : Value(playerNickname),
      playerId: Value(playerId),
      matchId: Value(matchId),
    );
  }

  factory PlayerMatchParticipationLocalEntityData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerMatchParticipationLocalEntityData(
      id: serializer.fromJson<int>(json['id']),
      status: $PlayerMatchParticipationLocalEntityTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      playerNickname: serializer.fromJson<String?>(json['playerNickname']),
      playerId: serializer.fromJson<int>(json['playerId']),
      matchId: serializer.fromJson<int>(json['matchId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status': serializer.toJson<int>($PlayerMatchParticipationLocalEntityTable
          .$converterstatus
          .toJson(status)),
      'playerNickname': serializer.toJson<String?>(playerNickname),
      'playerId': serializer.toJson<int>(playerId),
      'matchId': serializer.toJson<int>(matchId),
    };
  }

  PlayerMatchParticipationLocalEntityData copyWith(
          {int? id,
          PlayerMatchParticipationStatus? status,
          Value<String?> playerNickname = const Value.absent(),
          int? playerId,
          int? matchId}) =>
      PlayerMatchParticipationLocalEntityData(
        id: id ?? this.id,
        status: status ?? this.status,
        playerNickname:
            playerNickname.present ? playerNickname.value : this.playerNickname,
        playerId: playerId ?? this.playerId,
        matchId: matchId ?? this.matchId,
      );
  @override
  String toString() {
    return (StringBuffer('PlayerMatchParticipationLocalEntityData(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('playerNickname: $playerNickname, ')
          ..write('playerId: $playerId, ')
          ..write('matchId: $matchId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, status, playerNickname, playerId, matchId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerMatchParticipationLocalEntityData &&
          other.id == this.id &&
          other.status == this.status &&
          other.playerNickname == this.playerNickname &&
          other.playerId == this.playerId &&
          other.matchId == this.matchId);
}

class PlayerMatchParticipationLocalEntityCompanion
    extends UpdateCompanion<PlayerMatchParticipationLocalEntityData> {
  final Value<int> id;
  final Value<PlayerMatchParticipationStatus> status;
  final Value<String?> playerNickname;
  final Value<int> playerId;
  final Value<int> matchId;
  const PlayerMatchParticipationLocalEntityCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.playerNickname = const Value.absent(),
    this.playerId = const Value.absent(),
    this.matchId = const Value.absent(),
  });
  PlayerMatchParticipationLocalEntityCompanion.insert({
    this.id = const Value.absent(),
    required PlayerMatchParticipationStatus status,
    this.playerNickname = const Value.absent(),
    required int playerId,
    required int matchId,
  })  : status = Value(status),
        playerId = Value(playerId),
        matchId = Value(matchId);
  static Insertable<PlayerMatchParticipationLocalEntityData> custom({
    Expression<int>? id,
    Expression<int>? status,
    Expression<String>? playerNickname,
    Expression<int>? playerId,
    Expression<int>? matchId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (playerNickname != null) 'player_nickname': playerNickname,
      if (playerId != null) 'player_id': playerId,
      if (matchId != null) 'match_id': matchId,
    });
  }

  PlayerMatchParticipationLocalEntityCompanion copyWith(
      {Value<int>? id,
      Value<PlayerMatchParticipationStatus>? status,
      Value<String?>? playerNickname,
      Value<int>? playerId,
      Value<int>? matchId}) {
    return PlayerMatchParticipationLocalEntityCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      playerNickname: playerNickname ?? this.playerNickname,
      playerId: playerId ?? this.playerId,
      matchId: matchId ?? this.matchId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status.present) {
      map['status'] = Variable<int>($PlayerMatchParticipationLocalEntityTable
          .$converterstatus
          .toSql(status.value));
    }
    if (playerNickname.present) {
      map['player_nickname'] = Variable<String>(playerNickname.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerMatchParticipationLocalEntityCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('playerNickname: $playerNickname, ')
          ..write('playerId: $playerId, ')
          ..write('matchId: $matchId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AuthenticatedPlayerLocalEntityTable
      authenticatedPlayerLocalEntity =
      $AuthenticatedPlayerLocalEntityTable(this);
  late final $MatchLocalEntityTable matchLocalEntity =
      $MatchLocalEntityTable(this);
  late final $PlayerLocalEntityTable playerLocalEntity =
      $PlayerLocalEntityTable(this);
  late final $PlayerMatchParticipationLocalEntityTable
      playerMatchParticipationLocalEntity =
      $PlayerMatchParticipationLocalEntityTable(this);
  Selectable<String> current_timestamp() {
    return customSelect('SELECT CURRENT_TIMESTAMP AS _c0',
        variables: [],
        readsFrom: {}).map((QueryRow row) => row.read<String>('_c0'));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        authenticatedPlayerLocalEntity,
        matchLocalEntity,
        playerLocalEntity,
        playerMatchParticipationLocalEntity
      ];
}

typedef $$AuthenticatedPlayerLocalEntityTableInsertCompanionBuilder
    = AuthenticatedPlayerLocalEntityCompanion Function({
  Value<int> playerId,
  required String playerName,
  required String playerNickname,
});
typedef $$AuthenticatedPlayerLocalEntityTableUpdateCompanionBuilder
    = AuthenticatedPlayerLocalEntityCompanion Function({
  Value<int> playerId,
  Value<String> playerName,
  Value<String> playerNickname,
});

class $$AuthenticatedPlayerLocalEntityTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $AuthenticatedPlayerLocalEntityTable,
        AuthenticatedPlayerLocalEntityData,
        $$AuthenticatedPlayerLocalEntityTableFilterComposer,
        $$AuthenticatedPlayerLocalEntityTableOrderingComposer,
        $$AuthenticatedPlayerLocalEntityTableProcessedTableManager,
        $$AuthenticatedPlayerLocalEntityTableInsertCompanionBuilder,
        $$AuthenticatedPlayerLocalEntityTableUpdateCompanionBuilder> {
  $$AuthenticatedPlayerLocalEntityTableTableManager(
      _$AppDatabase db, $AuthenticatedPlayerLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AuthenticatedPlayerLocalEntityTableFilterComposer(
                  ComposerState(db, table)),
          orderingComposer:
              $$AuthenticatedPlayerLocalEntityTableOrderingComposer(
                  ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AuthenticatedPlayerLocalEntityTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> playerId = const Value.absent(),
            Value<String> playerName = const Value.absent(),
            Value<String> playerNickname = const Value.absent(),
          }) =>
              AuthenticatedPlayerLocalEntityCompanion(
            playerId: playerId,
            playerName: playerName,
            playerNickname: playerNickname,
          ),
          getInsertCompanionBuilder: ({
            Value<int> playerId = const Value.absent(),
            required String playerName,
            required String playerNickname,
          }) =>
              AuthenticatedPlayerLocalEntityCompanion.insert(
            playerId: playerId,
            playerName: playerName,
            playerNickname: playerNickname,
          ),
        ));
}

class $$AuthenticatedPlayerLocalEntityTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $AuthenticatedPlayerLocalEntityTable,
        AuthenticatedPlayerLocalEntityData,
        $$AuthenticatedPlayerLocalEntityTableFilterComposer,
        $$AuthenticatedPlayerLocalEntityTableOrderingComposer,
        $$AuthenticatedPlayerLocalEntityTableProcessedTableManager,
        $$AuthenticatedPlayerLocalEntityTableInsertCompanionBuilder,
        $$AuthenticatedPlayerLocalEntityTableUpdateCompanionBuilder> {
  $$AuthenticatedPlayerLocalEntityTableProcessedTableManager(super.$state);
}

class $$AuthenticatedPlayerLocalEntityTableFilterComposer
    extends FilterComposer<_$AppDatabase,
        $AuthenticatedPlayerLocalEntityTable> {
  $$AuthenticatedPlayerLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get playerId => $state.composableBuilder(
      column: $state.table.playerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get playerName => $state.composableBuilder(
      column: $state.table.playerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get playerNickname => $state.composableBuilder(
      column: $state.table.playerNickname,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AuthenticatedPlayerLocalEntityTableOrderingComposer
    extends OrderingComposer<_$AppDatabase,
        $AuthenticatedPlayerLocalEntityTable> {
  $$AuthenticatedPlayerLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get playerId => $state.composableBuilder(
      column: $state.table.playerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get playerName => $state.composableBuilder(
      column: $state.table.playerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get playerNickname => $state.composableBuilder(
      column: $state.table.playerNickname,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MatchLocalEntityTableInsertCompanionBuilder
    = MatchLocalEntityCompanion Function({
  Value<int> id,
  required String title,
  required int dateAndTime,
  required String location,
  required String description,
});
typedef $$MatchLocalEntityTableUpdateCompanionBuilder
    = MatchLocalEntityCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> dateAndTime,
  Value<String> location,
  Value<String> description,
});

class $$MatchLocalEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MatchLocalEntityTable,
    MatchLocalEntityData,
    $$MatchLocalEntityTableFilterComposer,
    $$MatchLocalEntityTableOrderingComposer,
    $$MatchLocalEntityTableProcessedTableManager,
    $$MatchLocalEntityTableInsertCompanionBuilder,
    $$MatchLocalEntityTableUpdateCompanionBuilder> {
  $$MatchLocalEntityTableTableManager(
      _$AppDatabase db, $MatchLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MatchLocalEntityTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MatchLocalEntityTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MatchLocalEntityTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> dateAndTime = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> description = const Value.absent(),
          }) =>
              MatchLocalEntityCompanion(
            id: id,
            title: title,
            dateAndTime: dateAndTime,
            location: location,
            description: description,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int dateAndTime,
            required String location,
            required String description,
          }) =>
              MatchLocalEntityCompanion.insert(
            id: id,
            title: title,
            dateAndTime: dateAndTime,
            location: location,
            description: description,
          ),
        ));
}

class $$MatchLocalEntityTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $MatchLocalEntityTable,
        MatchLocalEntityData,
        $$MatchLocalEntityTableFilterComposer,
        $$MatchLocalEntityTableOrderingComposer,
        $$MatchLocalEntityTableProcessedTableManager,
        $$MatchLocalEntityTableInsertCompanionBuilder,
        $$MatchLocalEntityTableUpdateCompanionBuilder> {
  $$MatchLocalEntityTableProcessedTableManager(super.$state);
}

class $$MatchLocalEntityTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MatchLocalEntityTable> {
  $$MatchLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get dateAndTime => $state.composableBuilder(
      column: $state.table.dateAndTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter playerMatchParticipationLocalEntityRefs(
      ComposableFilter Function(
              $$PlayerMatchParticipationLocalEntityTableFilterComposer f)
          f) {
    final $$PlayerMatchParticipationLocalEntityTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.playerMatchParticipationLocalEntity,
            getReferencedColumn: (t) => t.matchId,
            builder: (joinBuilder, parentComposers) =>
                $$PlayerMatchParticipationLocalEntityTableFilterComposer(
                    ComposerState(
                        $state.db,
                        $state.db.playerMatchParticipationLocalEntity,
                        joinBuilder,
                        parentComposers)));
    return f(composer);
  }
}

class $$MatchLocalEntityTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MatchLocalEntityTable> {
  $$MatchLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get dateAndTime => $state.composableBuilder(
      column: $state.table.dateAndTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PlayerLocalEntityTableInsertCompanionBuilder
    = PlayerLocalEntityCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String nickname,
  required String avatarUrl,
});
typedef $$PlayerLocalEntityTableUpdateCompanionBuilder
    = PlayerLocalEntityCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> nickname,
  Value<String> avatarUrl,
});

class $$PlayerLocalEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlayerLocalEntityTable,
    PlayerLocalEntityData,
    $$PlayerLocalEntityTableFilterComposer,
    $$PlayerLocalEntityTableOrderingComposer,
    $$PlayerLocalEntityTableProcessedTableManager,
    $$PlayerLocalEntityTableInsertCompanionBuilder,
    $$PlayerLocalEntityTableUpdateCompanionBuilder> {
  $$PlayerLocalEntityTableTableManager(
      _$AppDatabase db, $PlayerLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlayerLocalEntityTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$PlayerLocalEntityTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PlayerLocalEntityTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> nickname = const Value.absent(),
            Value<String> avatarUrl = const Value.absent(),
          }) =>
              PlayerLocalEntityCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            nickname: nickname,
            avatarUrl: avatarUrl,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String nickname,
            required String avatarUrl,
          }) =>
              PlayerLocalEntityCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            nickname: nickname,
            avatarUrl: avatarUrl,
          ),
        ));
}

class $$PlayerLocalEntityTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $PlayerLocalEntityTable,
        PlayerLocalEntityData,
        $$PlayerLocalEntityTableFilterComposer,
        $$PlayerLocalEntityTableOrderingComposer,
        $$PlayerLocalEntityTableProcessedTableManager,
        $$PlayerLocalEntityTableInsertCompanionBuilder,
        $$PlayerLocalEntityTableUpdateCompanionBuilder> {
  $$PlayerLocalEntityTableProcessedTableManager(super.$state);
}

class $$PlayerLocalEntityTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PlayerLocalEntityTable> {
  $$PlayerLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nickname => $state.composableBuilder(
      column: $state.table.nickname,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter playerMatchParticipationLocalEntityRefs(
      ComposableFilter Function(
              $$PlayerMatchParticipationLocalEntityTableFilterComposer f)
          f) {
    final $$PlayerMatchParticipationLocalEntityTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.playerMatchParticipationLocalEntity,
            getReferencedColumn: (t) => t.playerId,
            builder: (joinBuilder, parentComposers) =>
                $$PlayerMatchParticipationLocalEntityTableFilterComposer(
                    ComposerState(
                        $state.db,
                        $state.db.playerMatchParticipationLocalEntity,
                        joinBuilder,
                        parentComposers)));
    return f(composer);
  }
}

class $$PlayerLocalEntityTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PlayerLocalEntityTable> {
  $$PlayerLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get firstName => $state.composableBuilder(
      column: $state.table.firstName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastName => $state.composableBuilder(
      column: $state.table.lastName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nickname => $state.composableBuilder(
      column: $state.table.nickname,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PlayerMatchParticipationLocalEntityTableInsertCompanionBuilder
    = PlayerMatchParticipationLocalEntityCompanion Function({
  Value<int> id,
  required PlayerMatchParticipationStatus status,
  Value<String?> playerNickname,
  required int playerId,
  required int matchId,
});
typedef $$PlayerMatchParticipationLocalEntityTableUpdateCompanionBuilder
    = PlayerMatchParticipationLocalEntityCompanion Function({
  Value<int> id,
  Value<PlayerMatchParticipationStatus> status,
  Value<String?> playerNickname,
  Value<int> playerId,
  Value<int> matchId,
});

class $$PlayerMatchParticipationLocalEntityTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $PlayerMatchParticipationLocalEntityTable,
        PlayerMatchParticipationLocalEntityData,
        $$PlayerMatchParticipationLocalEntityTableFilterComposer,
        $$PlayerMatchParticipationLocalEntityTableOrderingComposer,
        $$PlayerMatchParticipationLocalEntityTableProcessedTableManager,
        $$PlayerMatchParticipationLocalEntityTableInsertCompanionBuilder,
        $$PlayerMatchParticipationLocalEntityTableUpdateCompanionBuilder> {
  $$PlayerMatchParticipationLocalEntityTableTableManager(
      _$AppDatabase db, $PlayerMatchParticipationLocalEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlayerMatchParticipationLocalEntityTableFilterComposer(
                  ComposerState(db, table)),
          orderingComposer:
              $$PlayerMatchParticipationLocalEntityTableOrderingComposer(
                  ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PlayerMatchParticipationLocalEntityTableProcessedTableManager(
                  p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<PlayerMatchParticipationStatus> status = const Value.absent(),
            Value<String?> playerNickname = const Value.absent(),
            Value<int> playerId = const Value.absent(),
            Value<int> matchId = const Value.absent(),
          }) =>
              PlayerMatchParticipationLocalEntityCompanion(
            id: id,
            status: status,
            playerNickname: playerNickname,
            playerId: playerId,
            matchId: matchId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required PlayerMatchParticipationStatus status,
            Value<String?> playerNickname = const Value.absent(),
            required int playerId,
            required int matchId,
          }) =>
              PlayerMatchParticipationLocalEntityCompanion.insert(
            id: id,
            status: status,
            playerNickname: playerNickname,
            playerId: playerId,
            matchId: matchId,
          ),
        ));
}

class $$PlayerMatchParticipationLocalEntityTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $PlayerMatchParticipationLocalEntityTable,
        PlayerMatchParticipationLocalEntityData,
        $$PlayerMatchParticipationLocalEntityTableFilterComposer,
        $$PlayerMatchParticipationLocalEntityTableOrderingComposer,
        $$PlayerMatchParticipationLocalEntityTableProcessedTableManager,
        $$PlayerMatchParticipationLocalEntityTableInsertCompanionBuilder,
        $$PlayerMatchParticipationLocalEntityTableUpdateCompanionBuilder> {
  $$PlayerMatchParticipationLocalEntityTableProcessedTableManager(super.$state);
}

class $$PlayerMatchParticipationLocalEntityTableFilterComposer
    extends FilterComposer<_$AppDatabase,
        $PlayerMatchParticipationLocalEntityTable> {
  $$PlayerMatchParticipationLocalEntityTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<PlayerMatchParticipationStatus,
          PlayerMatchParticipationStatus, int>
      get status => $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get playerNickname => $state.composableBuilder(
      column: $state.table.playerNickname,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PlayerLocalEntityTableFilterComposer get playerId {
    final $$PlayerLocalEntityTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.playerId,
            referencedTable: $state.db.playerLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$PlayerLocalEntityTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.playerLocalEntity,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$MatchLocalEntityTableFilterComposer get matchId {
    final $$MatchLocalEntityTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.matchId,
            referencedTable: $state.db.matchLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$MatchLocalEntityTableFilterComposer(ComposerState($state.db,
                    $state.db.matchLocalEntity, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PlayerMatchParticipationLocalEntityTableOrderingComposer
    extends OrderingComposer<_$AppDatabase,
        $PlayerMatchParticipationLocalEntityTable> {
  $$PlayerMatchParticipationLocalEntityTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get playerNickname => $state.composableBuilder(
      column: $state.table.playerNickname,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PlayerLocalEntityTableOrderingComposer get playerId {
    final $$PlayerLocalEntityTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.playerId,
            referencedTable: $state.db.playerLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$PlayerLocalEntityTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.playerLocalEntity,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }

  $$MatchLocalEntityTableOrderingComposer get matchId {
    final $$MatchLocalEntityTableOrderingComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.matchId,
            referencedTable: $state.db.matchLocalEntity,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$MatchLocalEntityTableOrderingComposer(ComposerState($state.db,
                    $state.db.matchLocalEntity, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AuthenticatedPlayerLocalEntityTableTableManager
      get authenticatedPlayerLocalEntity =>
          $$AuthenticatedPlayerLocalEntityTableTableManager(
              _db, _db.authenticatedPlayerLocalEntity);
  $$MatchLocalEntityTableTableManager get matchLocalEntity =>
      $$MatchLocalEntityTableTableManager(_db, _db.matchLocalEntity);
  $$PlayerLocalEntityTableTableManager get playerLocalEntity =>
      $$PlayerLocalEntityTableTableManager(_db, _db.playerLocalEntity);
  $$PlayerMatchParticipationLocalEntityTableTableManager
      get playerMatchParticipationLocalEntity =>
          $$PlayerMatchParticipationLocalEntityTableTableManager(
              _db, _db.playerMatchParticipationLocalEntity);
}
