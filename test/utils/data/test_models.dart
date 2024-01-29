import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

List<PlayerModel> getTestPlayers({
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

MatchModel getTestMatch({
  int id = 1,
  String name = "testName",
  String organizer = "testOrganizer",
  String location = "testLocation",
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
  );
}
