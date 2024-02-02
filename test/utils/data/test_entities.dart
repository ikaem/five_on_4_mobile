import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

final testAuthDataEntity = AuthDataEntity(
  playerInfo: AuthDataPlayerInfoEntity(
    id: 1,
    firstName: "John",
    lastName: "Doe",
    nickName: "JD",
  ),
  teamInfo: AuthDataTeamInfoEntity(
    id: 1,
    teamName: "Team 1",
  ),
);

// NOTE: this is only for testing isar wrapper works - this would never happen in real life
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

List<MatchLocalEntity> getTestMatchLocalEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final matches = List<MatchLocalEntity>.generate(
    count,
    (index) {
      return MatchLocalEntity(
        id: index,
        date: DateTime.now().millisecondsSinceEpoch,
        name: "${namesPrefix}name$index",
        location: "${namesPrefix}location$index",
        organizer: "${namesPrefix}organizer$index",
        description: "${namesPrefix}description$index",
        arrivingPlayers: _getTestMatchLocalPlayerEntities(),
      );
    },
  );

  return matches;
}

List<MatchLocalPlayerEntity> _getTestMatchLocalPlayerEntities({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final players = List<MatchLocalPlayerEntity>.generate(
    count,
    (index) {
      return MatchLocalPlayerEntity(
        id: index,
        name: "${namesPrefix}name$index",
        nickname: "${namesPrefix}nickname$index",
        avatarUrl: "https://test.com/avatar.png",
      );
    },
  );

  return players;
}
