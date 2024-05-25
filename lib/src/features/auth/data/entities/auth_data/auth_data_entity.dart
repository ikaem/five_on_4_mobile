import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/data/entities/isar_local/isar_local_entity.dart';
import 'package:isar/isar.dart';

part "auth_data_entity.g.dart";

// TODO rename this only to AuthLocalEntity and AuthRemoteEntity

// TODO rename this to AuthDataLocalEntity
@Collection(inheritance: false)
class AuthDataEntity extends Equatable implements IsarLocalEntity {
  AuthDataEntity({
    required this.playerInfo,
    required this.teamInfo,
  });

  /// Only local id - not related in any way to remote server db
  // final Id id = Isar.autoIncrement;
  // TODO we could possibly always hardcode this to 1? to make sure only one player exists?
  Id? id;

  final AuthDataPlayerInfoEntity playerInfo;
  final AuthDataTeamInfoEntity teamInfo;

  @ignore
  @override
  // TODO: implement props
  List<Object?> get props => [
        playerInfo,
        teamInfo,
      ];
}

@Embedded(inheritance: false)
class AuthDataPlayerInfoEntity extends Equatable {
  const AuthDataPlayerInfoEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.nickName,
  });

  /// Actual player id from remote server db
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? nickName;

  @ignore
  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        nickName,
      ];
}

@Embedded(inheritance: false)
class AuthDataTeamInfoEntity extends Equatable {
  const AuthDataTeamInfoEntity({
    this.id,
    this.teamName,
  });

  /// Actual team id from remote server db
  final int? id;
  final String? teamName;

  @ignore
  @override
  List<Object?> get props => [
        id,
        teamName,
      ];
}
