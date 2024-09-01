import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_remote_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/models/player_match_participation/player_match_participation_model.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';

// TODO this requireds testing

abstract class MatchesConverter {
  static List<MatchLocalEntityValue> fromRemoteEntitiesToLocalEntityValues({
    required List<MatchRemoteEntity> matchesRemote,
  }) {
    final matchesLocal = matchesRemote
        .map(
          (m) => MatchesConverter.fromRemoteEntityToMatchLocalEntityValue(
            matchRemote: m,
          ),
        )
        .toList();

    return matchesLocal;
  }

  static MatchLocalEntityValue fromRemoteEntityToMatchLocalEntityValue({
    required MatchRemoteEntity matchRemote,
  }) {
    // TODO come back to this
    // final arrivingPlayers = matchRemote.arrivingPlayers.map((player) {
    //   return MatchLocalPlayerEntity(
    //     playerId: player.id,
    //     name: player.name,
    //     nickname: player.nickname,
    //     avatarUrl: player.avatarUri.toString(),
    //   );
    // }).toList();

    // final matchLocal = MatchLocalEntity(
    //   id: matchRemote.id,
    //   date: matchRemote.date,
    //   name: matchRemote.name,
    //   location: matchRemote.location,
    //   organizer: matchRemote.organizer,
    //   description: matchRemote.description,
    //   arrivingPlayers: arrivingPlayers,
    // );

    final participationLocalEntityValues = matchRemote.participations
        .map(
          (e) => PlayerMatchParticipationLocalEntityValue(
            id: e.id,
            status: PlayerMatchParticipationStatus.values.firstWhere(
              (element) => element.index == e.status,
              orElse: () => PlayerMatchParticipationStatus.unknown,
            ),
            playerNickname: e.playerNickname,
            playerId: e.playerId,
            matchId: e.matchId,
          ),
        )
        .toList();

    final entityValue = MatchLocalEntityValue(
      id: matchRemote.id,
      dateAndTime: matchRemote.dateAndTime,
      title: matchRemote.title,
      location: matchRemote.location,
      description: matchRemote.description,
      participations: participationLocalEntityValues,
    );

    return entityValue;
  }

  static List<MatchModel> fromLocalEntitiesToModels({
    required List<MatchLocalEntityData> matchesLocal,
  }) {
    final matchesModel = matchesLocal
        .map(
          (m) => MatchesConverter.fromLocalEntityDataToModel(
            matchLocal: m,
          ),
        )
        .toList();

    return matchesModel;
  }

// TODO maybe it would be good to rename these to start with to
// toModelFromLocalEntityData - to know immediately what it converts to
// TODO not used
  static MatchModel fromLocalEntityDataToModel({
    required MatchLocalEntityData matchLocal,
  }) {
    // TODO come back to this
    // final arrivingPlayers = matchLocal.arrivingPlayers.map((player) {
    //   // TODO handle nulls somehow
    //   return PlayerModel(
    //     id: player.playerId!,
    //     name: player.name!,
    //     nickname: player.nickname!,
    //     avatarUri: Uri.parse(player.avatarUrl!),
    //   );
    // }).toList();

    final dateAndTime =
        DateTime.fromMillisecondsSinceEpoch(matchLocal.dateAndTime);

    final matchModel = MatchModel(
      id: matchLocal.id,
      title: matchLocal.title,
      dateAndTime: dateAndTime,
      location: matchLocal.location,
      description: matchLocal.description,
      // organizer: matchLocal.organizer,
      // arrivingPlayers: arrivingPlayers,
      participations: const [],
    );

    return matchModel;
  }

  static MatchModel toModelFromLocalEntityValue({
    required MatchLocalEntityValue value,
  }) {
    final participations = value.participations.map((e) {
      return PlayerMatchParticipationModel(
        id: e.id,
        status: e.status,
        playerNickname: e.playerNickname,
        playerId: e.playerId,
        matchId: e.matchId,
      );
    }).toList();

    final match = MatchModel(
      id: value.id,
      title: value.title,
      dateAndTime: DateTime.fromMillisecondsSinceEpoch(value.dateAndTime),
      location: value.location,
      description: value.description,
      participations: participations,
    );

    return match;
  }
}
