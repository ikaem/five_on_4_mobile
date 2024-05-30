import 'package:equatable/equatable.dart';

class AuthenticatedPlayerLocalEntity extends Equatable {
  const AuthenticatedPlayerLocalEntity({
    required this.playerId,
    required this.playerName,
    required this.playerNickname,
  });

  final int playerId;
  final String playerName;
  final String playerNickname;

  factory AuthenticatedPlayerLocalEntity.fromJson(Map<String, dynamic> json) {
    return AuthenticatedPlayerLocalEntity(
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
