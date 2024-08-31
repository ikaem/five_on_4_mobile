import 'package:equatable/equatable.dart';

class PlayerMatchParticipationRemoteEntity extends Equatable {
  const PlayerMatchParticipationRemoteEntity({
    required this.id,
    required this.playerId,
    required this.matchId,
    required this.status,
    required this.playerNickname,
  });

  final int id;
  final int playerId;
  final int matchId;
  final String? playerNickname;

  // TODO this will also be an enum here when we get to local entity
  final int status;

  @override
  List<Object?> get props => [
        id,
        playerId,
        matchId,
        status,
        playerNickname,
      ];
}
