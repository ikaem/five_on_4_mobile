import 'package:five_on_4_mobile/src/features/auth/domain/models/auth_data/auth_data_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

PlayerModel getTestPlayerModel({
  int id = 1,
  String nickname = "test_nickname",
  String name = "test_name",
  String avatarUrl = "https://test.com/avatar.png",
}) {
  return PlayerModel(
    id: id,
    nickname: nickname,
    name: name,
    avatarUri: Uri.parse(
      avatarUrl,
    ),
  );
}

List<PlayerModel> getTestPlayersModels({
  int count = 10,
  String avatarUrl = "https://test.com/avatar.png",
  String namesPrefix = "test_",
}) {
  final players = List<PlayerModel>.generate(
    count,
    (index) {
      return PlayerModel(
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

MatchModel getTestMatchModel({
  int id = 1,
  String name = "testName",
  String organizer = "testOrganizer",
  String location = "testLocation",
  String description = "testDescription",
  DateTime? date,
  List<PlayerModel> arrivingPlayers = const [],
}) {
  return MatchModel(
    id: id,
    name: name,
    organizer: organizer,
    location: location,
    date: date ?? DateTime.now(),
    arrivingPlayers: arrivingPlayers,
    description: description,
  );
}

List<MatchModel> getTestMatchesModels({
  int count = 10,
  String namesPrefix = "test_",
  String organizer = "test_organizer",
  String location = "test_location",
  String description = "test_description",
  DateTime? date,
  List<PlayerModel> arrivingPlayers = const [],
}) {
  final matches = List<MatchModel>.generate(
    count,
    (index) {
      return MatchModel(
        id: index,
        name: "${namesPrefix}name$index",
        organizer: organizer,
        location: location,
        description: description,
        date: date ?? DateTime.now(),
        arrivingPlayers: arrivingPlayers,
      );
    },
  );

  return matches;
}

List<AuthDataModel> getTestAuthDataModels({
  int count = 10,
  String namesPrefix = "test_",
}) {
  final authData = List<AuthDataModel>.generate(
    count,
    (index) {
      return AuthDataModel(
        playerId: index,
        fullName: "${namesPrefix}fullName$index",
        nickName: "${namesPrefix}nickName$index",
        teamId: index,
        teamName: "${namesPrefix}teamName$index",
      );
    },
  );

  return authData;
}
