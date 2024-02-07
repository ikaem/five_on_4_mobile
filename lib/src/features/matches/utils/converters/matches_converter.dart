import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

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

  static List<MatchModel> fromLocalEntitiesToModels({
    required List<MatchLocalEntity> matchesLocal,
  }) {
    final matchesModel = matchesLocal
        .map(
          (m) => MatchesConverter.fromLocalEntityToModel(
            matchLocal: m,
          ),
        )
        .toList();

    return matchesModel;
  }

  static MatchModel fromLocalEntityToModel({
    required MatchLocalEntity matchLocal,
  }) {
    final arrivingPlayers = matchLocal.arrivingPlayers.map((player) {
      // TODO handle nulls somehow
      return PlayerModel(
        id: player.playerId!,
        name: player.name!,
        nickname: player.nickname!,
        avatarUri: Uri.parse(player.avatarUrl!),
      );
    }).toList();

    final matchDate = DateTime.fromMillisecondsSinceEpoch(matchLocal.date);

    final matchModel = MatchModel(
      id: matchLocal.id,
      date: matchDate,
      name: matchLocal.name,
      location: matchLocal.location,
      organizer: matchLocal.organizer,
      arrivingPlayers: arrivingPlayers,
      description: matchLocal.description,
    );

    return matchModel;
  }
}
