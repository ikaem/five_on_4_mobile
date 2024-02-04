import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';

abstract class MatchesConverter {
  static List<MatchLocalEntity> fromRemoteEntitiesToLocalEntities({
    required List<MatchRemoteEntity> matchesRemote,
  }) {
    final matchesLocal = matchesRemote
        .map(
          (m) => MatchesConverter.fromRemoteEntityToLocalEntity(
            matchRemote: m,
          ),
        )
        .toList();

    return matchesLocal;
  }

  static MatchLocalEntity fromRemoteEntityToLocalEntity({
    required MatchRemoteEntity matchRemote,
  }) {
    final arrivingPlayers = matchRemote.arrivingPlayers.map((player) {
      return MatchLocalPlayerEntity(
        playerId: player.id,
        name: player.name,
        nickname: player.nickname,
        avatarUrl: player.avatarUri.toString(),
      );
    }).toList();

    final matchLocal = MatchLocalEntity(
      id: matchRemote.id,
      date: matchRemote.date,
      name: matchRemote.name,
      location: matchRemote.location,
      organizer: matchRemote.organizer,
      description: matchRemote.description,
      arrivingPlayers: arrivingPlayers,
    );

    return matchLocal;
  }
}
