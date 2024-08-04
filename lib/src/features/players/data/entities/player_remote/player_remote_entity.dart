import 'package:equatable/equatable.dart';

class PlayerRemoteEntity extends Equatable {
  const PlayerRemoteEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.nickname,
  });

  // TODO switch to freezed eventually
  factory PlayerRemoteEntity.fromJson({
    required Map<String, dynamic> json,
    String tempAvatarUrl =
        "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
  }) {
    final id = json["id"] as int;
    final name = json["name"] as String;
    // final avatarUri = json["avatarUrl"] as String;
    // TODO make ticket so that backend returns avatar url
    final nickname = json["nickname"] as String;

    // TODO temp until backend model returns avatar url
    // const tempAvatarUrl =
    //     "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c";

    final entity = PlayerRemoteEntity(
      id: id,
      name: name,
      avatarUrl: tempAvatarUrl,
      nickname: nickname,
    );

    return entity;
  }

  final int id;
  final String name;
  final String avatarUrl;
  final String nickname;

  // TODO not even sure what we need this for?
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatarUri": avatarUrl,
      "nickname": nickname,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUrl,
        nickname,
      ];
}
