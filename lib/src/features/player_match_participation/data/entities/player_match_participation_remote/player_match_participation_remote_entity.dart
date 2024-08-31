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

  // TODO make ticket to create converter class for this instead of doing it from here

  factory PlayerMatchParticipationRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    final id = json["id"] as int;
    final playerId = json["playerId"] as int;
    final matchId = json["matchId"] as int;
    final status = json["status"] as int;
    final playerNickname = json["playerNickname"] as String?;

    return PlayerMatchParticipationRemoteEntity(
      id: id,
      playerId: playerId,
      matchId: matchId,
      status: status,
      playerNickname: playerNickname,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "playerId": playerId,
      "matchId": matchId,
      "status": status,
      "playerNickname": playerNickname,
    };
  }

  @override
  List<Object?> get props => [
        id,
        playerId,
        matchId,
        status,
        playerNickname,
      ];
}
