import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';

class PlayerMatchParticipationModel extends Equatable {
  const PlayerMatchParticipationModel({
    required this.id,
    required this.status,
    required this.playerNickname,
    required this.playerId,
    required this.matchId,
  });

  final int id;
  final PlayerMatchParticipationStatus status;
  final String? playerNickname;
  final int playerId;
  final int matchId;

  @override
  List<Object?> get props => [
        id,
        status,
        playerNickname,
        playerId,
        matchId,
      ];
}
