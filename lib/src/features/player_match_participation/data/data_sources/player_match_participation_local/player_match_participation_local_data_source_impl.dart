import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_local/player_match_participation_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';

class PlayerMatchParticipationLocalDataSourceImpl
    implements PlayerMatchParticipationLocalDataSource {
  PlayerMatchParticipationLocalDataSourceImpl({
    required DatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DatabaseWrapper _databaseWrapper;

  @override
  Future<int> storeParticipation({
    required PlayerMatchParticipationLocalEntityValue
        playerMatchParticipationValue,
  }) async {
    final companion = PlayerMatchParticipationLocalEntityCompanion.insert(
      id: Value(playerMatchParticipationValue.id),
      status: playerMatchParticipationValue.status,
      playerId: playerMatchParticipationValue.playerId,
      matchId: playerMatchParticipationValue.matchId,
      playerNickname: Value(playerMatchParticipationValue.playerNickname),
    );

    // TODO maybe we neede transaction - check it later
    final storedId = await _databaseWrapper.playerMatchParticipationRepo
        .insertOnConflictUpdate(companion);

    return storedId;
  }

  @override
  Future<List<int>> storeParticipations({
    required List<PlayerMatchParticipationLocalEntityValue>
        playerMatchParticipationValues,
  }) async {
    final companions = playerMatchParticipationValues
        .map(
          (playerMatchParticipationValue) =>
              PlayerMatchParticipationLocalEntityCompanion.insert(
            id: Value(playerMatchParticipationValue.id),
            status: playerMatchParticipationValue.status,
            playerId: playerMatchParticipationValue.playerId,
            matchId: playerMatchParticipationValue.matchId,
            playerNickname: Value(playerMatchParticipationValue.playerNickname),
          ),
        )
        .toList();

    // TODO not sure if transaction is better here
    await _databaseWrapper.runInBatch((batch) {
      batch.insertAllOnConflictUpdate(
        _databaseWrapper.playerMatchParticipationRepo,
        companions,
      );
    });

    final ids = playerMatchParticipationValues.map((e) => e.id).toList();

    return ids;
  }
}
