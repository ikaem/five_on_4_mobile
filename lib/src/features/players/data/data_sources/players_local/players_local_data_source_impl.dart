import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';

class PlayersLocalDataSourceImpl implements PlayersLocalDataSource {
  const PlayersLocalDataSourceImpl({
    required DatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;

  final DatabaseWrapper _databaseWrapper;

  @override
  Future<int> storePlayer({
    required PlayerLocalEntityValue playerValue,
  }) async {
    final PlayerLocalEntityCompanion playerCompanion =
        PlayerLocalEntityCompanion.insert(
      id: Value(playerValue.id),
      firstName: playerValue.firstName,
      lastName: playerValue.lastName,
      nickname: playerValue.nickname,
      avatarUrl: playerValue.avatarUrl,
    );

    // TODO not really sure transaction is needed here
    final id = await _databaseWrapper.db.transaction(() async {
      final storedId =
          await _databaseWrapper.playerLocalRepo.insertOnConflictUpdate(
        playerCompanion,
      );

      return storedId;
    });

    return id;
  }

  @override
  Future<List<int>> storePlayers({
    required List<PlayerLocalEntityValue> matchValues,
  }) async {
    final playerCompanions = matchValues.map((e) {
      return PlayerLocalEntityCompanion(
        id: Value(e.id),
        firstName: Value(e.firstName),
        lastName: Value(e.lastName),
        nickname: Value(e.nickname),
        avatarUrl: Value(e.avatarUrl),
      );
    }).toList();

    await _databaseWrapper.runInBatch((batch) {
      batch.insertAllOnConflictUpdate(
        _databaseWrapper.playerLocalRepo,
        playerCompanions,
      );
    });

    final playerIds = playerCompanions.map((e) {
      return e.id.value;
    }).toList();

    return playerIds;
  }

  @override
  Future<List<PlayerLocalEntityValue>> getPlayers(
      {required List<int> playerIds}) async {
    final select = _databaseWrapper.playerLocalRepo.select();

    final findPlayers = select..where((tbl) => tbl.id.isIn(playerIds));

    final players = await findPlayers.get();

    final playerValues = players.map((e) {
      return PlayerLocalEntityValue(
        id: e.id,
        firstName: e.firstName,
        lastName: e.lastName,
        nickname: e.nickname,
        avatarUrl: e.avatarUrl,
      );
    }).toList();

    return playerValues;
  }
}
