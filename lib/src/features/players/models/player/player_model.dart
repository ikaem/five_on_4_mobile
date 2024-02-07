import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  const PlayerModel({
    required this.id,
    required this.name,
    required this.avatarUri,
    required this.nickname,
  });

  final int id;
  final String name;
  final Uri avatarUri;
  final String nickname;
  // TODO we will see if if we need these
  // final int teamId;
  // final int matchId;

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUri,
        nickname,
      ];
}
