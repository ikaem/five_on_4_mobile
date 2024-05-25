import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_remote/auth_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

final testAuthDataEntity = AuthDataEntity(
  playerInfo: const AuthDataPlayerInfoEntity(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    nickName: "JD",
  ),
  teamInfo: const AuthDataTeamInfoEntity(
    id: 1,
    teamName: "Team 1",
  ),
);

List<AuthLocalEntity> getTestAuthLocalEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final authLocalEntities = List<AuthLocalEntity>.generate(
    count,
    (index) {
      return AuthLocalEntity(
        id: index,
        avatarUrl: "https://source.unsplash.com/random/300x300",
        email: "${namesPrefix}email$index",
        name: "${namesPrefix}name$index",
        nickname: "${namesPrefix}nickname$index",
      );
    },
  );

  return authLocalEntities;
}

// NOTE: this is only for testing isar wrapper works - this would never happen in real life
// TODO this needs to be removed
List<AuthDataEntity> getTestAuthDataEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final authDataEntities = List<AuthDataEntity>.generate(
    count,
    (index) {
      return AuthDataEntity(
        playerInfo: AuthDataPlayerInfoEntity(
          id: index,
          firstName: "${namesPrefix}firstName$index",
          lastName: "${namesPrefix}lastName$index",
          nickName: "${namesPrefix}nickName$index",
        ),
        teamInfo: AuthDataTeamInfoEntity(
          id: index,
          teamName: "${namesPrefix}teamName$index",
        ),
      );
    },
  );

  return authDataEntities;
}

List<PlayerRemoteEntity> getTestPlayerRemoteEntities({
  int count = 10,
  String avatarUrl = "https://test.com/avatar.png",
  String namesPrefix = "test_",
}) {
  final players = List<PlayerRemoteEntity>.generate(
    count,
    (index) {
      return PlayerRemoteEntity(
        id: index,
        nickname: "${namesPrefix}nickname$index",
        name: "${namesPrefix}name$index",
        avatarUri: avatarUrl,
      );
    },
  );

  return players;
}

List<MatchRemoteEntity> getTestMatchRemoteEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final matches = List<MatchRemoteEntity>.generate(
    count,
    (index) {
      return MatchRemoteEntity(
        id: index,
        date: DateTime.now().millisecondsSinceEpoch,
        name: "${namesPrefix}name$index",
        location: "${namesPrefix}location$index",
        organizer: "${namesPrefix}organizer$index",
        description: "${namesPrefix}description$index",
        arrivingPlayers: getTestPlayerRemoteEntities(),
      );
    },
  );

  return matches;
}

/// [arrivingPlayers] defaults to generic call to [getTestMatchLocalPlayerEntities]
/// [firstMatchDate] defaults to [DateTime.now()]
MatchLocalEntity getTestMatchLocalEntity({
  int id = 1,
  stringFieldsPrefix = "test_",
  List<MatchLocalPlayerEntity>? arrivingPlayers,
  DateTime? firstMatchDate,
}) {
  final matchDate = firstMatchDate ?? DateTime.now();
  final players = arrivingPlayers ?? getTestMatchLocalPlayerEntities();

  return MatchLocalEntity(
    id: id,
    date: matchDate.millisecondsSinceEpoch,
    name: "${stringFieldsPrefix}name",
    location: "${stringFieldsPrefix}location",
    organizer: "${stringFieldsPrefix}organizer",
    description: "${stringFieldsPrefix}description",
    arrivingPlayers: players,
  );
}

// TODO this is ultimately not needed - remove it and use multip0le matches with count specified
List<MatchLocalEntity> getTestMatchLocalEntities({
  int count = 10,
  String namesPrefix = "test_",

  /// Default is DateTime.now() - every next match will be 1 minute later
  DateTime? firstMatchDate,
}) {
  final initialMatchDate = firstMatchDate ?? DateTime.now();

  final matches = List<MatchLocalEntity>.generate(
    count,
    (index) {
      final matchDate = initialMatchDate.add(Duration(minutes: index));

      return MatchLocalEntity(
        id: index,
        date: matchDate.millisecondsSinceEpoch,
        name: "${namesPrefix}name$index",
        location: "${namesPrefix}location$index",
        organizer: "${namesPrefix}organizer$index",
        description: "${namesPrefix}description$index",
        arrivingPlayers: getTestMatchLocalPlayerEntities(),
      );
    },
  );

  return matches;
}

MatchLocalPlayerEntity getTestMatchLocalPlayerEntity({
  int id = 1,
  String stringFieldsPrefix = "test_",
}) {
  return MatchLocalPlayerEntity(
    playerId: id,
    name: "${stringFieldsPrefix}name",
    nickname: "${stringFieldsPrefix}nickname",
    avatarUrl: "https://test.com/avatar.png",
  );
}

List<MatchLocalPlayerEntity> getTestMatchLocalPlayerEntities({
  int count = 10,
  String stringFieldsPrefix = "test_",
}) {
  final players = List<MatchLocalPlayerEntity>.generate(
    count,
    (index) {
      return MatchLocalPlayerEntity(
        playerId: index,
        name: "${stringFieldsPrefix}name$index",
        nickname: "${stringFieldsPrefix}nickname$index",
        avatarUrl: "https://test.com/avatar.png",
      );
    },
  );

  return players;
}

List<AuthRemoteEntity> getTestAuthRemoteEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final authRemoteEntities = List<AuthRemoteEntity>.generate(
    count,
    (index) {
      return AuthRemoteEntity(
        id: index,
        avatarUrl: "https://source.unsplash.com/random/300x300",
        email: "${namesPrefix}email$index",
        name: "${namesPrefix}name$index",
        nickname: "${namesPrefix}nickname$index",
      );
    },
  );

  return authRemoteEntities;
}
