import 'package:equatable/equatable.dart';

class AuthenticatedPlayerModel extends Equatable {
  const AuthenticatedPlayerModel({
    required this.playerId,
    required this.playerName,
    required this.playerNickname,
  });

  final int playerId;
  final String playerName;
  final String playerNickname;

  @override
  List<Object?> get props => [
        playerId,
        playerName,
        playerNickname,
      ];
}
