import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_remote/matches_remote_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/player_match_local_entities_overview_value.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';
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

// TODO these can stay - will be reused on load more i guess?
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
    final matchCompanion = MatchLocalEntityCompanion.insert(
      id: Value(matchValue.id),
      title: matchValue.title,
      dateAndTime: matchValue.dateAndTime,
      description: matchValue.description,
      location: matchValue.location,
    );

    final participationCompanions = matchValue.participations
        .map(
          (e) => PlayerMatchParticipationLocalEntityCompanion.insert(
            id: Value(e.id),
            matchId: matchValue.id,
            playerId: e.playerId,
            status: e.status,
            playerNickname: Value(e.playerNickname),
          ),
        )
        .toList();

    final id = await _databaseWrapper.db.transaction(() async {
      // final insertId = _databaseWrapper.matchLocalRepo.insertOne(companion);
      final storedId = await _databaseWrapper.matchRepo
          .insertOnConflictUpdate(matchCompanion);

      await _databaseWrapper.playerMatchParticipationRepo
          .insertAll(participationCompanions,
              onConflict: DoUpdate.withExcluded((old, excluded) {
                return PlayerMatchParticipationLocalEntityCompanion.custom(
                  // only status can be updated here for now, rest needs to stay the same
                  status: excluded.status,
                );
              }, target: [
                // NOTE these two are unique keys, so we need to specify them here
                _databaseWrapper.playerMatchParticipationRepo.playerId,
                _databaseWrapper.playerMatchParticipationRepo.matchId,
              ]));

      return storedId;
    });

    return id;
  }

  @override
  Future<List<int>> storeMatches({
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

    // TODO not sure if batch is needed, but lets leave it as is
    await _databaseWrapper.runInBatch((batch) {
      batch.insertAllOnConflictUpdate(
        _databaseWrapper.matchRepo,
        matchCompanions,
      );
    });

    final matchesIds = matchValues.map((e) => e.id).toList();
    // TODO come back to test that it actually does return list of ids
    return matchesIds;

//  ----------- TODO keep this here for now --------------
//     _databaseWrapper.matchLocalRepo.insertAll(matchCompanions);

//     // TODO using transaction over batch because we can get ids of upserted elements
//     // TODO there is no need for trasnaction if atomatically insert alrteady with insertall? or is ther
//     final ids = await _databaseWrapper.runInTransaction(() async {
//       // for (final companion in matchCompanions) {
//       // final id = await _databaseWrapper.matchLocalRepo.insertOnConflictUpdate(companion);
//       final ids = await _databaseWrapper.matchLocalRepo.insertAll(
//         matchCompanions,
//         mode: InsertMode.insertOrReplace,
//         // TODO not really sure how to use this
//         // onConflict: DoUpdate.withExcluded(
//         //   (old, excluded) {
//         //     tbl1.id;
//         //     tbl2.id;

//         //     return const MatchLocalEntityCompanion();
//         //   },
//         // ),
//         // TODO this works iwth mode
//         // TODO does not seem to be needed for now
//         // TODO this is how they do it in drift from their source code
//         /*
//         Future<int> insertOnConflictUpdate(Insertable<D> entity) {
//           return insert(entity, onConflict: DoUpdate((_) => entity));
//         }
//          */
//         // onConflict: DoUpdate(
//         //   (tbl) => MatchLocalEntityCompanion(
//         //     id: tbl.id,
//         //     title: tbl.title,
//         //     dateAndTime: tbl.dateAndTime,
//         //     location: tbl.location,
//         //     description: tbl.description,
//         //   ),
//         // ),
//       );

//       return ids;
//     });

// // TODO maybe this is not good - maybe we can use batch, or this is ok since we dont get all ids anyway
//     return ids;

    // TODO leave batch here for now --------------------- !!!!!!!!!
//  ----------- TODO keep this here for now --------------
  }

// TODO change this to return value, not match data
// TODO in future, we will need to return to fetching only match, as participatiosn will be retrieved from participations data soruce on demand - not with match
  @override
  Future<MatchLocalEntityValue> getMatch({
    required int matchId,
  }) async {
// TODO this will be removed later - when we separate match and participations requests, so each will need to be requested separatedly. this will allow to not be required to have same joins in mobile and backend

    final select = _databaseWrapper.matchRepo.select();
    final joinedSelect = select.join([
      leftOuterJoin(
        _databaseWrapper.playerMatchParticipationRepo,
        _databaseWrapper.playerMatchParticipationRepo.matchId.equalsExp(
          _databaseWrapper.matchRepo.id,
        ),
      ),
    ]);

    final findMatchSelect = joinedSelect
      ..where(_databaseWrapper.matchRepo.id.equals(matchId));

    final result = await findMatchSelect.get();

    if (result.isEmpty) {
      throw MatchesExceptionMatchNotFoundException(
        message: "Match with id: $matchId not found",
      );
    }

    final matchData = result.first.readTable(_databaseWrapper.matchRepo);
    final participationsData = result.map((row) {
      // return e.readTable(_databaseWrapper.playerMatchParticipationRepo);
      final participationData = row.readTableOrNull(
        _databaseWrapper.playerMatchParticipationRepo,
      );

      if (participationData == null) {
        return null;
      }

      return participationData;

      // final participationValue = PlayerMatchParticipationLocalEntityValue(
      //   id: participationData.id,
      //   matchId: participationData.matchId,
      //   playerId: participationData.playerId,
      //   status: participationData.status,
      //   playerNickname: participationData.playerNickname,
      // );

      // return participationValue;
    }).toList();

    final validatedParticipations = participationsData.whereNotNull().map((e) {
      final participationValue = PlayerMatchParticipationLocalEntityValue(
        id: e.id,
        matchId: e.matchId,
        playerId: e.playerId,
        status: e.status,
        playerNickname: e.playerNickname,
      );

      return participationValue;
    }).toList();

    final matchValue = MatchLocalEntityValue(
      id: matchData.id,
      title: matchData.title,
      dateAndTime: matchData.dateAndTime,
      location: matchData.location,
      description: matchData.description,
      participations: validatedParticipations,
    );

    return matchValue;

    // TODO temp only - lets test ///////////
    // final tempValue = MatchLocalEntityValue(
    //   id: 1,
    //   dateAndTime: DateTime.now().millisecondsSinceEpoch,
    //   title: "title",
    //   location: "location",
    //   description: "description",
    //   participations: validatedParticipations,
    // );

    // return tempValue;

    ///////////////////////////////////////////// KEEP THIS FOR NOW /////////////////////////////////////////////
    // NOTE old implementation - we will probably return to thos when separate requests for match and participations. for now, though, leave it
    // final select = _databaseWrapper.matchLocalRepo.select();
    // final findMatch = select..where((tbl) => tbl.id.equals(matchId));
    // final matchData = await findMatch.getSingleOrNull();

    // if (matchData == null) {
    //   // TODO not sure we should be throwing exception here
    //   throw MatchesExceptionMatchNotFoundException(
    //     message: "Match with id: $matchId not found",
    //   );
    // }

    // final MatchLocalEntityValue entityValue = MatchLocalEntityValue(
    //   id: matchData.id,
    //   title: matchData.title,
    //   dateAndTime: matchData.dateAndTime,
    //   location: matchData.location,
    //   description: matchData.description,
    //   // TODO this will need to be added later to actually have participations
    //   // TODO just replicate same joins that exist on backend
    //   participations: const [],
    // );

    // return entityValue;
  }

  @override
  Future<List<MatchLocalEntityValue>> getMatches({
    required List<int> matchIds,
  }) async {
    final select = _databaseWrapper.matchRepo.select();

    final findMatches = select..where((tbl) => tbl.id.isIn(matchIds));

    final matches = await findMatches.get();

    final matchValues = matches
        .map((e) => MatchLocalEntityValue(
              id: e.id,
              title: e.title,
              dateAndTime: e.dateAndTime,
              location: e.location,
              description: e.description,
              // TODO we will see if this is needed
              // TODO possibly we could have a factory constructor called brief that will immeditarly assing empty list of participations here
              participations: const [],
            ))
        .toList();

    return matchValues;
  }

  /* 
  
  
  
  
      final select = _databaseWrapper.matchLocalRepo.select();
    final findMatches = select
      // TODO WILL COME BACK TO THIS
      // TODO we can have another where, or we can do this check in upper where
      // ..where((tbl) => tbl.arrivingPlayers.contains(playerId));
      ..where((tbl) {
        // TODO we can check here if match is player's
        final isDateToday = tbl.dateAndTime.isBetweenValues(
          lastMomentOfYesterday.millisecondsSinceEpoch,
          firstMomentOfTomorrow.millisecondsSinceEpoch,
        );

        return isDateToday;
      });
    // TODO sorting should be enforced here on db - same thing on backend side
    // because right now it returns in order of insertion - but we want it to be sorted by date
    final matches = await (findMatches..limit(5)).get();
  
  
  
  
  
  
   */

// TODO this will not be used
  @override
  Future<List<MatchLocalEntityValue>> getSearchedMatches({
    required SearchMatchesFilterValue filter,
  }) {
    // final matchTitle = filter.title;

    final select = _databaseWrapper.matchRepo.select();

    // TODO throw exception for now realy quick
    throw UnimplementedError();
  }

  /* 
  
  
      final select = _databaseWrapper.matchLocalRepo.select();
    final findMatches = select
      // TODO WILL COME BACK TO THIS
      // TODO we can have another where, or we can do this check in upper where
      // ..where((tbl) => tbl.arrivingPlayers.contains(playerId));
      ..where((tbl) {
        // TODO we can check here if match is player's
        final isDateToday = tbl.dateAndTime.isSmallerThanValue(
          firstMomentOfToday.millisecondsSinceEpoch,
        );

        return isDateToday;
      });
    final matches = await (findMatches..limit(5)).get();
  
  
  
  
  
   */

  @override
  Future<PlayerMatchLocalEntitiesOverviewValue> getPlayerMatchesOverview({
    required int playerId,
  }) async {
    // TODO could there be a more effective query here - to havve one query only
    // TODO extract to separate method that will be reused in load more
    // TODO await all of this at the same time
    final todayMatches =
        await _getPlayerTodayMatchesOverview(playerId: playerId);
    final upcomingMatches =
        await _getPlayerUpcomingMatchesOverview(playerId: playerId);
    final pastMatches = await _getPlayerPastMatchesOverview(playerId: playerId);

    final value = PlayerMatchLocalEntitiesOverviewValue(
      upcomingMatches: upcomingMatches,
      todayMatches: todayMatches,
      pastMatches: pastMatches,
    );
    return value;
  }

  Future<List<MatchLocalEntityValue>> _getPlayerTodayMatchesOverview({
    required int playerId,
  }) async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    // TODO create extension on datetime for this
    final lastMomentOfYesterday = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
      23,
      59,
      59,
      999,
      999,
      // TODO this might need to be normalized to seconds or something - we will see
    );

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final firstMomentOfTomorrow = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      0,
      0,
      0,
      0,
      0,
    );

    final select = _databaseWrapper.matchRepo.select();
    final findMatches = select
      // TODO WILL COME BACK TO THIS
      // TODO we can have another where, or we can do this check in upper where
      // ..where((tbl) => tbl.arrivingPlayers.contains(playerId));
      ..where((tbl) {
        // TODO we can check here if match is player's
        final isDateToday = tbl.dateAndTime.isBetweenValues(
          lastMomentOfYesterday.millisecondsSinceEpoch,
          firstMomentOfTomorrow.millisecondsSinceEpoch,
        );

        return isDateToday;
      });
    // TODO sorting should be enforced here on db - same thing on backend side
    // because right now it returns in order of insertion - but we want it to be sorted by date
    final matches = await (findMatches..limit(5)).get();

    // TODO create to value constructor or extension or something
    final matchValues = matches
        .map((e) => MatchLocalEntityValue(
              id: e.id,
              title: e.title,
              dateAndTime: e.dateAndTime,
              location: e.location,
              description: e.description,
              // TODO we will see if this is needed
              // TODO possibly we could have a factory constructor called brief that will immeditarly assing empty list of participations here
              participations: const [],
            ))
        .toList();
    return matchValues;
  }

  Future<List<MatchLocalEntityValue>> _getPlayerUpcomingMatchesOverview({
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
    );

    final select = _databaseWrapper.matchRepo.select();
    final findMatches = select
      // TODO WILL COME BACK TO THIS
      // TODO we can have another where, or we can do this check in upper where
      // ..where((tbl) => tbl.arrivingPlayers.contains(playerId));
      ..where((tbl) {
        // TODO we can check here if match is player's
        final isDateToday = tbl.dateAndTime.isBiggerThanValue(
          lastMomentOfToday.millisecondsSinceEpoch,
        );

        return isDateToday;
      });
    final matches = await (findMatches..limit(5)).get();

    // TODO create to value constructor or extension or something
    final matchValues = matches
        .map((e) => MatchLocalEntityValue(
              id: e.id,
              title: e.title,
              dateAndTime: e.dateAndTime,
              location: e.location,
              description: e.description,
              // TODO we will see if this is needed
              // TODO possibly we could have a factory constructor called brief that will immeditarly assing empty list of participations here
              participations: const [],
            ))
        .toList();
    return matchValues;
  }

  Future<List<MatchLocalEntityValue>> _getPlayerPastMatchesOverview({
    required int playerId,
  }) async {
    final today = DateTime.now();
    final firstMomentOfToday = DateTime(
      today.year,
      today.month,
      today.day,
      0,
      0,
      0,
      0,
      0,
    );

    final select = _databaseWrapper.matchRepo.select();
    final findMatches = select
      // TODO WILL COME BACK TO THIS
      // TODO we can have another where, or we can do this check in upper where
      // ..where((tbl) => tbl.arrivingPlayers.contains(playerId));
      ..where((tbl) {
        // TODO we can check here if match is player's
        final isDateToday = tbl.dateAndTime.isSmallerThanValue(
          firstMomentOfToday.millisecondsSinceEpoch,
        );

        return isDateToday;
      });
    final matches = await (findMatches..limit(5)).get();

    // TODO create to value constructor or extension or something
    final matchValues = matches
        .map((e) => MatchLocalEntityValue(
              id: e.id,
              title: e.title,
              dateAndTime: e.dateAndTime,
              location: e.location,
              description: e.description,
              // TODO we will see if this is needed
              // TODO possibly we could have a factory constructor called brief that will immeditarly assing empty list of participations here
              participations: const [],
            ))
        .toList();
    return matchValues;
  }
}
