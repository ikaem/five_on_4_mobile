import 'package:isar/isar.dart';

part "auth_data_entity.g.dart";

@collection
class AuthDataEntity {
  AuthDataEntity({
    required this.playerInfo,
    required this.teamInfo,
  });

  /// Only local id - not related in any way to remote server db
  // final Id id = Isar.autoIncrement;
  Id? id;

  final AuthDataPlayerInfoEntity playerInfo;
  final AuthDataTeamInfoEntity teamInfo;
}

@embedded
class AuthDataPlayerInfoEntity {
  AuthDataPlayerInfoEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.nickName,
  });

  /// Actual player id from remote server db
  int? id;
  String? firstName;
  String? lastName;
  String? nickName;
}

@embedded
class AuthDataTeamInfoEntity {
  AuthDataTeamInfoEntity({
    this.id,
    this.teamName,
  });

  /// Actual team id from remote server db
  int? id;
  String? teamName;
}
