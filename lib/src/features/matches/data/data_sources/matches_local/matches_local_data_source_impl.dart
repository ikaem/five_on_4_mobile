import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';
import 'package:isar/isar.dart';

class MatchesLocalDataSourceImpl implements MatchesLocalDataSource {
  const MatchesLocalDataSourceImpl({
    // required IsarWrapper isarWrapper,
    required DatabaseWrapper databaseWrapper,
  }) : _databaseWrapper = databaseWrapper;
  // }) : _isarWrapper = isarWrapper;

  // final IsarWrapper _isarWrapper;
  final DatabaseWrapper _databaseWrapper;

  @override
  Future<List<int>> saveMatches({
    required List<MatchLocalEntity> matches,
  }) async {
    throw UnimplementedError();
    // final result = await _isarWrapper.db.writeTxn(() async {
    //   final ids = await _isarWrapper.db.matchLocalEntitys.putAll(matches);
    //   return ids;
    // });

    // return result;
  }

  @override
  Future<List<MatchLocalEntity>> getPastMatchesForPlayer({
    required int playerId,
  }) async {
    throw UnimplementedError();

    // TODO old
    // final today = DateTime.now();
    // final firstMomentOfToday = DateTime(
    //   today.year,
    //   today.month,
    //   today.day,
    //   0,
    //   0,
    //   0,
    //   0,
    //   0,
    // ).millisecondsSinceEpoch;

    // final matches = await _isarWrapper.db.matchLocalEntitys
    //     .where()
    //     .dateLessThan(firstMomentOfToday)
    //     .filter()
    //     .arrivingPlayersElement(
    //   (q) {
    //     return q.playerIdEqualTo(playerId);
    //   },
    // ).findAll();

    // return matches;
  }

  @override
  Future<List<MatchLocalEntity>> getTodayMatchesForPlayer({
    required int playerId,
  }) async {
    throw UnimplementedError();

    // TODO old
    // // TODO abstrac this somehow
    // final yesterday = DateTime.now().subtract(const Duration(days: 1));
    // final lastMomentOfYesterday = DateTime(
    //   yesterday.year,
    //   yesterday.month,
    //   yesterday.day,
    //   23,
    //   59,
    //   59,
    //   999,
    //   999,
    // ).millisecondsSinceEpoch;
    // final tomorrow = DateTime.now().add(const Duration(days: 1));
    // final firstMomentOfTomorrow = DateTime(
    //   tomorrow.year,
    //   tomorrow.month,
    //   tomorrow.day,
    //   0,
    //   0,
    //   0,
    //   0,
    //   0,
    // ).millisecondsSinceEpoch;

    // final matches = await _isarWrapper.db.matchLocalEntitys
    //     .where()
    //     .dateBetween(lastMomentOfYesterday, firstMomentOfTomorrow)
    //     .filter()
    //     .arrivingPlayersElement(
    //   (q) {
    //     return q.playerIdEqualTo(playerId);
    //   },
    // ).findAll();

    // return matches;
  }

  @override
  Future<List<MatchLocalEntity>> getUpcomingMatchesForPlayer({
    required int playerId,
  }) async {
    throw UnimplementedError();

    // TODO old
    // final now = DateTime.now();
    // final lastMomentOfToday = DateTime(
    //   now.year,
    //   now.month,
    //   now.day,
    //   23,
    //   59,
    //   59,
    //   999,
    //   999,
    // ).millisecondsSinceEpoch;

    // // querying nested objects from https://isar.dev/queries.html#embedded-objects
    // final matches = await _isarWrapper.db.matchLocalEntitys
    //     .where()
    //     .dateGreaterThan(lastMomentOfToday)
    //     .filter()
    //     .arrivingPlayersElement(
    //   (q) {
    //     // return q.idEqualTo(playerId);
    //     return q.playerIdEqualTo(playerId);
    //   },
    // ).findAll();

    // return matches;
  }

  @override
  Future<int> storeMatch({
    // required MatchLocalEntity match,
    required MatchLocalEntityValue matchValue,
  }) async {
    // TODO this upserts the match
    final companion = MatchLocalEntityCompanion.insert(
      id: Value(matchValue.id),
      title: matchValue.title,
      dateAndTime: matchValue.dateAndTime,
      description: matchValue.description,
      location: matchValue.location,
    );

    final id = await _databaseWrapper.db.transaction(() {
      // final insertId = _databaseWrapper.matchLocalRepo.insertOne(companion);
      final storeId =
          _databaseWrapper.matchLocalRepo.insertOnConflictUpdate(companion);
      return storeId;
    });

    return id;

    // throw UnimplementedError();
    // final response = await _isarWrapper.db.writeTxn(() async {
    //   final id = await _isarWrapper.db.matchLocalEntitys.put(match);
    //   return id;
    // });

    // return response;
  }

  @override
  Future<MatchLocalEntityData> getMatch({
    required int matchId,
  }) async {
    final select = _databaseWrapper.matchLocalRepo.select();
    final findMatch = select..where((tbl) => tbl.id.equals(matchId));
    final matchData = await findMatch.getSingleOrNull();

    if (matchData == null) {
      throw MatchNotFoundException(
        message: "Match with id: $matchId not found",
      );
    }

    return matchData;
    // throw UnimplementedError();
    // final match = await _isarWrapper.db.matchLocalEntitys
    //     .where()
    //     .idEqualTo(matchId)
    //     .findFirst();

    // if (match == null) {
    //   throw MatchNotFoundException(
    //     message: "Match with id: $matchId not found",
    //   );
    // }

    // return match;
  }

  @override
  Future<void> storeMatches({
    required List<MatchLocalEntityValue> matchValues,
  }) async {
    // throw UnimplementedError();

    final matchCompanions = matchValues
        .map((e) => MatchLocalEntityCompanion.insert(
              id: Value(e.id),
              title: e.title,
              dateAndTime: e.dateAndTime,
              location: e.location,
              description: e.description,
            ))
        .toList();

    // TODO test batch upsert
    // await _databaseWrapper.db.batch((batch) {
    //   batch.insertAllOnConflictUpdate(
    //       _databaseWrapper.matchLocalRepo, matchCompanions);
    // });

    await _databaseWrapper.runInBatch((batch) {
      batch.insertAllOnConflictUpdate(
        _databaseWrapper.matchLocalRepo,
        matchCompanions,
      );
    });
  }
}
