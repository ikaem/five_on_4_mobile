import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:isar/isar.dart';

class MatchesLocalDataSourceImpl implements MatchesLocalDataSource {
  const MatchesLocalDataSourceImpl({
    required IsarWrapper isarWrapper,
  }) : _isarWrapper = isarWrapper;

  final IsarWrapper _isarWrapper;

  @override
  Future<List<int>> saveMatches({
    required List<MatchLocalEntity> matches,
  }) async {
    final result = await _isarWrapper.db.writeTxn(() async {
      final ids = await _isarWrapper.db.matchLocalEntitys.putAll(matches);
      return ids;
    });

    return result;
  }

  @override
  Future<List<MatchLocalEntity>> getTodayMatchesForPlayer({
    required int playerId,
  }) async {
    return [];
  }

  @override
  Future<List<MatchLocalEntity>> getFollowingMatchesForPlayer({
    required int playerId,
  }) async {
    final now = DateTime.now();
    final lastMomentOfToday = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
      999,
      999,
    ).millisecondsSinceEpoch;

    // final lastMomentOfToday = DateTime.now()
    //     .add(
    //       const Duration(
    //         hours: 23,
    //         seconds: 59,
    //         milliseconds: 999,
    //         microseconds: 999,
    //       ),
    //     )
    //     .millisecondsSinceEpoch;

    // querying nested objects from https://isar.dev/queries.html#embedded-objects
    final matches = await _isarWrapper.db.matchLocalEntitys
        .where()
        .dateGreaterThan(lastMomentOfToday)
        .filter()
        .arrivingPlayersElement(
      (q) {
        // return q.idEqualTo(playerId);
        return q.playerIdEqualTo(playerId);
      },
    ).findAll();

    return matches;
  }
}
