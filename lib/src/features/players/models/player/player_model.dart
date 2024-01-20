class PlayerModel {
  PlayerModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.nickname,
  });

  final int id;
  final String name;
  final Uri avatarUrl;
  final String nickname;
  // TODO we will see if if we need these
  // final int teamId;
  // final int matchId;
}
