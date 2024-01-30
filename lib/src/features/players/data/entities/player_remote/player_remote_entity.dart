class PlayerRemoteEntity {
  PlayerRemoteEntity({
    required this.id,
    required this.name,
    required this.avatarUri,
    required this.nickname,
  });

  final int id;
  final String name;
  final Uri avatarUri;
  final String nickname;
}
