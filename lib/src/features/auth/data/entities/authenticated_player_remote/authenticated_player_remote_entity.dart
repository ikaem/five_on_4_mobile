import 'package:equatable/equatable.dart';

class AuthenticatedPlayerRemoteEntity extends Equatable {
  const AuthenticatedPlayerRemoteEntity({
    required this.playerId,
    required this.playerName,
    required this.playerNickname,
  });

  final int playerId;
  final String playerName;
  final String playerNickname;

  factory AuthenticatedPlayerRemoteEntity.fromJson(Map<String, dynamic> json) {
    return AuthenticatedPlayerRemoteEntity(
      playerId: json['id'],
      playerName: json['name'],
      playerNickname: json['nickname'],
    );
  }

  @override
  List<Object> get props => [
        playerId,
        playerName,
        playerNickname,
      ];
}
