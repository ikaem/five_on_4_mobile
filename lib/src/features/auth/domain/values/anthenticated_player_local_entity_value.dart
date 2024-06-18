import 'package:equatable/equatable.dart';

class AuthenticatedPlayerLocalEntityValue extends Equatable {
  const AuthenticatedPlayerLocalEntityValue({
    required this.playerId,
    required this.playerName,
    required this.playerNickname,
  });

  final int playerId;
  final String playerName;
  final String playerNickname;

  @override
  List<Object?> get props => [playerId, playerName, playerNickname];
}
