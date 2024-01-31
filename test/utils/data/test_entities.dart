import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
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
        avatarUri: Uri.parse(
          avatarUrl,
        ),
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
