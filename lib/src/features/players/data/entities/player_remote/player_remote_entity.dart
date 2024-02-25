import 'package:equatable/equatable.dart';

class PlayerRemoteEntity extends Equatable {
  const PlayerRemoteEntity({
    required this.id,
    required this.name,
    required this.avatarUri,
    required this.nickname,
  });

  // TODO switch to freezed eventually
  factory PlayerRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    final id = json["id"] as int;
    final name = json["name"] as String;
    final avatarUri = json["avatarUrl"] as String;
    final nickname = json["nickname"] as String;

    return PlayerRemoteEntity(
      id: id,
      name: name,
      avatarUri: avatarUri,
      nickname: nickname,
    );
  }

  final int id;
  final String name;
  final String avatarUri;
  final String nickname;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatarUri": avatarUri.toString(),
      "nickname": nickname,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUri,
        nickname,
      ];
}
