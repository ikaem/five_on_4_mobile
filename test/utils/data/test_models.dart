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
