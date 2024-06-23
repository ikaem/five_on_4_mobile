import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/helpers/db/setup_db.dart';
import '../../../../../../../utils/helpers/test_database/setup_test_database.dart';
import '../../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  // final isarWrapper = _MockIsarWrapper();
  // final isarWrapper = setupTestDb();
  late TestDatabaseWrapper testDatabaseWrapper;

  // tested class
  late MatchesLocalDataSource dataSource;

  // TODO create helper for this

  // final matchesLocalDataSource = MatchesLocalDataSourceImpl(
  //     // isarWrapper: isarWrapper,
  //     databaseWrapper: testDatabaseWrapper.databaseWrapper,
  //     );

  setUp(() async {
    testDatabaseWrapper = await setupTestDatabase();

    dataSource = MatchesLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() {
    testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    "$MatchesLocalDataSource",
    () {
      group(".getMatch()", () {
        test(
          "given a match id with no match in the database"
          "when '.getMatch() is called"
          // TODO not sure for now if this should be excpetion
          // but lets leave it and come back to it when see app behavior
          // TODO maybe null would be better - to be consistent with other functions - maybe
          "then should throw expected exception",
          () async {
            // setup

            // given
            const id = 999;
            // no entry to db

            // when / then
            expect(
                () => dataSource.getMatch(matchId: id),
                throwsExceptionWithMessage<MatchNotFoundException>(
                  "Match with id: $id not found",
                ));

            // cleanup
          },
        );

        test(
          "given a valid match id"
          "when '.getMatch() is called"
          "then should return expected match",
          () async {
            // setup
            final testMatchLocalEntityCompanion =
                generateTestMatchLocalEntityCompanions(count: 1).first;
            await testDatabaseWrapper.databaseWrapper.matchLocalRepo
                .insertOne(testMatchLocalEntityCompanion);

            // given
            final id = testMatchLocalEntityCompanion.id.value;

            // when
            final result = await dataSource.getMatch(matchId: id);

            // then
            final expectedResult = MatchLocalEntityData(
              id: id,
              title: testMatchLocalEntityCompanion.title.value,
              dateAndTime: testMatchLocalEntityCompanion.dateAndTime.value,
              description: testMatchLocalEntityCompanion.description.value,
              location: testMatchLocalEntityCompanion.location.value,
            );

            expect(result, equals(expectedResult));

            // cleanup
          },
        );
      });

      group(
        ".storeMatch()",
        () {
          test(
            "given MatchLocalEntityValue"
            "when '.storeMatch() is called"
            "then should save the match to the database",
            () async {
              // setup
              final matchEntityCompanion =
                  generateTestMatchLocalEntityCompanions(count: 1).first;

              // given
              final matchEntityValue = MatchLocalEntityValue(
                id: matchEntityCompanion.id.value,
                title: matchEntityCompanion.title.value,
                dateAndTime: matchEntityCompanion.dateAndTime.value,
                description: matchEntityCompanion.description.value,
                location: matchEntityCompanion.location.value,
              );

              // when
              final storedMatchId =
                  await dataSource.storeMatch(matchValue: matchEntityValue);

              // then
              // TODO this needs to be abstracted somehow as a getter possibly in app datahbase wrapper
              final select =
                  testDatabaseWrapper.databaseWrapper.matchLocalRepo.select();
              final findMatch = select
                ..where((tbl) => tbl.id.equals(matchEntityValue.id));
              final matchData = await findMatch.getSingleOrNull();

              final expectedResult = MatchLocalEntityData(
                id: matchEntityValue.id,
                title: matchEntityValue.title,
                dateAndTime: matchEntityValue.dateAndTime,
                description: matchEntityValue.description,
                location: matchEntityValue.location,
              );

              expect(matchData, equals(expectedResult));

              // cleanup
            },
          );

          test(
            "given MatchLocalEntityValue existing in the database"
            "when '.storeMatch() is called with updated values of the same match"
            "then should update the existing match",
            () async {
              // setup
              final matchEntityCompanion =
                  generateTestMatchLocalEntityCompanions(count: 1).first;
              final matchEntityValue = MatchLocalEntityValue(
                id: matchEntityCompanion.id.value,
                title: matchEntityCompanion.title.value,
                dateAndTime: matchEntityCompanion.dateAndTime.value,
                description: matchEntityCompanion.description.value,
                location: matchEntityCompanion.location.value,
              );

              // given
              // store original match
              await dataSource.storeMatch(matchValue: matchEntityValue);

              // when
              final updatedMatchEntityValue = MatchLocalEntityValue(
                id: matchEntityCompanion.id.value,
                title: "${matchEntityCompanion.title.value} updated",
                dateAndTime: matchEntityCompanion.dateAndTime.value,
                description:
                    "${matchEntityCompanion.description.value} updated",
                location: "${matchEntityCompanion.location.value} updated",
              );

              await dataSource.storeMatch(matchValue: updatedMatchEntityValue);

              // then
              final select =
                  testDatabaseWrapper.databaseWrapper.matchLocalRepo.select();
              final findMatch = select
                ..where((tbl) => tbl.id.equals(matchEntityValue.id));
              final matchData = await findMatch.getSingleOrNull();

              final expectedResult = MatchLocalEntityData(
                id: updatedMatchEntityValue.id,
                title: updatedMatchEntityValue.title,
                dateAndTime: updatedMatchEntityValue.dateAndTime,
                description: updatedMatchEntityValue.description,
                location: updatedMatchEntityValue.location,
              );

              expect(matchData, equals(expectedResult));

              // cleanup
            },
          );

          test(
            "given MatchLocalEntityValue"
            "when '.storeMatch() is called"
            "then should return expected id",
            () async {
              // setup
              final matchEntityCompanion =
                  generateTestMatchLocalEntityCompanions(count: 1).first;

              // given
              final matchEntityValue = MatchLocalEntityValue(
                id: matchEntityCompanion.id.value,
                title: matchEntityCompanion.title.value,
                dateAndTime: matchEntityCompanion.dateAndTime.value,
                description: matchEntityCompanion.description.value,
                location: matchEntityCompanion.location.value,
              );

              // when
              final storedMatchId =
                  await dataSource.storeMatch(matchValue: matchEntityValue);

              // then

              expect(storedMatchId, equals(matchEntityValue.id));

              // cleanup
            },
          );

          // TODO test upsert actually
        },
      );

      group(".storeMatches()", () {
        test(
          "given multiple MatchLocalEntityValue"
          "when '.storeMatches() is called"
          "then should save matches to the database",
          () async {
            // setup
            final testMatchLocalEntityCompanions =
                generateTestMatchLocalEntityCompanions(count: 3);

            // given
            final testMatchLocalEntityValues = testMatchLocalEntityCompanions
                .map(
                  (companion) => MatchLocalEntityValue(
                    id: companion.id.value,
                    title: companion.title.value,
                    dateAndTime: companion.dateAndTime.value,
                    description: companion.description.value,
                    location: companion.location.value,
                  ),
                )
                .toList();

            // when
            await dataSource.storeMatches(
                matchValues: testMatchLocalEntityValues);

            // then
            final expectedEntitiesData = testMatchLocalEntityCompanions
                .map(
                  (companion) => MatchLocalEntityData(
                    id: companion.id.value,
                    title: companion.title.value,
                    dateAndTime: companion.dateAndTime.value,
                    description: companion.description.value,
                    location: companion.location.value,
                  ),
                )
                .toList();

            final select = await testDatabaseWrapper
                .databaseWrapper.matchLocalRepo
                .select()
                .get();

            expect(select, equals(expectedEntitiesData));

            // cleanup
          },
        );

        test(
          "given multiple MatchLocalEntityValue already existing in the database"
          "when .storeMatches() is called with updated values of same matches"
          "then should update existing matches",
          () async {
            // setup
            final testMatchLocalEntityCompanions =
                generateTestMatchLocalEntityCompanions(count: 3);
            final testMatchLocalEntityValues = testMatchLocalEntityCompanions
                .map(
                  (companion) => MatchLocalEntityValue(
                    id: companion.id.value,
                    title: companion.title.value,
                    dateAndTime: companion.dateAndTime.value,
                    description: companion.description.value,
                    location: companion.location.value,
                  ),
                )
                .toList();

            // given
            // insert original matches to db
            await dataSource.storeMatches(
                matchValues: testMatchLocalEntityValues);

            // when
            // create updated match values
            final updatedMatchLocalEntityValues = testMatchLocalEntityCompanions
                .map(
                  (companion) => MatchLocalEntityValue(
                    id: companion.id.value,
                    title: "${companion.title.value} updated",
                    dateAndTime: companion.dateAndTime.value,
                    description: "${companion.description.value} updated",
                    location: "${companion.location.value} updated",
                  ),
                )
                .toList();

            await dataSource.storeMatches(
                matchValues: updatedMatchLocalEntityValues);

            // then
            final expectedEntitiesData = updatedMatchLocalEntityValues
                .map(
                  (value) => MatchLocalEntityData(
                    id: value.id,
                    title: value.title,
                    dateAndTime: value.dateAndTime,
                    description: value.description,
                    location: value.location,
                  ),
                )
                .toList();

            final select = await testDatabaseWrapper
                .databaseWrapper.matchLocalRepo
                .select()
                .get();

            expect(select, equals(expectedEntitiesData));

            // cleanup
          },
        );

        //
      });

      // TODO save matches should actually upsert, not just save

      // and test that it is upserted

      // TODO -- old start ///////////////

      // group(
      //   ".saveMatches()",
      //   () {
      //     test(
      //       "given a list of [MatchLocalEntity]s"
      //       "when '.saveMatches() is called"
      //       "should save the matches to the database",
      //       () async {
      //         final testMatches = getTestMatchLocalEntities(count: 3);
      //         final ids = testMatches.map((match) => match.id).toList();

      //         await matchesLocalDataSource.saveMatches(matches: testMatches);

      //         final result =
      //             await isarWrapper.db.matchLocalEntitys.where().findAll();

      //         expect(result, equals(testMatches));
      //       },
      //     );
      //   },
      // );

      // group(".getPastMatchesForPlayer()", () {
      //   test(
      //     "given user joined 2 matches yesterday"
      //     "when .getPastMatchesForPlayer is called"
      //     "should retrieve current users matches from the database",
      //     () async {
      //       const playerId = 999;
      //       const someOtherPlayerId = 2;

      //       final testMatchesToday = _generatePlayerTestMatches(
      //         playerId: playerId,
      //         matchesCount: 2,
      //         playersPerMatchCount: 5,
      //         initialMatchDate: DateTime.now(),
      //         initialMatchId: 0,
      //       );

      //       final anotherPlayerMatchesToday = _generatePlayerTestMatches(
      //         playerId: someOtherPlayerId,
      //         matchesCount: 2,
      //         playersPerMatchCount: 5,
      //         initialMatchDate: DateTime.now(),
      //         initialMatchId: 2,
      //       );

      //       final testMatchesYesterday = _generatePlayerTestMatches(
      //         playerId: playerId,
      //         matchesCount: 2,
      //         playersPerMatchCount: 5,
      //         initialMatchDate: DateTime.now().subtract(
      //           const Duration(days: 1),
      //         ),
      //         initialMatchId: 4,
      //       );

      //       final allMatches = testMatchesToday +
      //           testMatchesYesterday +
      //           anotherPlayerMatchesToday;

      //       // add matches to db manually
      //       await isarWrapper.db.writeTxn(() async {
      //         await isarWrapper.db
      //             .collection<MatchLocalEntity>()
      //             .putAll(allMatches);
      //       });

      //       final result = await matchesLocalDataSource.getPastMatchesForPlayer(
      //         playerId: playerId,
      //       );

      //       expect(result, equals(testMatchesYesterday));
      //     },
      //   );
      // });

      // group(
      //   ".getTodayMatchesForPlayer()",
      //   () {
      //     test(
      //       "given user joined 2 matches today"
      //       "when .getTodayMatchesForPlayer is called "
      //       "should retrieve current users matches from the database",
      //       () async {
      //         const playerId = 999;
      //         const someOtherPlayerId = 2;

      //         // TODO abstract and shorten this for all by inserting all matches at once in a helper function
      //         // and then the function should return the matches that we will compare to tesult - base on argument we give it

      //         final testMatchesToday = _generatePlayerTestMatches(
      //           playerId: playerId,
      //           matchesCount: 2,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now(),
      //           initialMatchId: 0,
      //         );

      //         final anotherPlayerMatchesToday = _generatePlayerTestMatches(
      //           playerId: someOtherPlayerId,
      //           matchesCount: 2,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now(),
      //           initialMatchId: 2,
      //         );

      //         final testMatchesTomorrow = _generatePlayerTestMatches(
      //           playerId: playerId,
      //           matchesCount: 2,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now().add(
      //             const Duration(days: 1),
      //           ),
      //           initialMatchId: 4,
      //         );

      //         final allMatches = testMatchesToday +
      //             testMatchesTomorrow +
      //             anotherPlayerMatchesToday;

      //         // add matches to db manually
      //         await isarWrapper.db.writeTxn(() async {
      //           await isarWrapper.db
      //               .collection<MatchLocalEntity>()
      //               .putAll(allMatches);
      //         });

      //         final result =
      //             await matchesLocalDataSource.getTodayMatchesForPlayer(
      //           playerId: playerId,
      //         );

      //         expect(result, equals(testMatchesToday));
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".getFollowingMatchesForPlayer()",
      //   () {
      //     test(
      //       "given current user joined 6 matches starting from tomorrow"
      //       "when .getFollowingMatchesForPlayer() is called"
      //       "should retrieve current users matches starting from tomorrow from the database",
      //       () async {
      //         // TODO simplify or shorten this somehow
      //         const playerId = 999;
      //         const nonPlayerId = 2;
      //         // generate todays matches
      //         final todayMatches = _generatePlayerTestMatches(
      //           playerId: playerId,
      //           matchesCount: 2,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now(),
      //           initialMatchId: 0,
      //         );
      //         // generate tomorrows matches
      //         final tomorrowMatches = _generatePlayerTestMatches(
      //           playerId: playerId,
      //           matchesCount: 3,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now().add(
      //             const Duration(days: 1),
      //           ),
      //           initialMatchId: 2,
      //         );
      //         final afterTomorrowMatches = _generatePlayerTestMatches(
      //           playerId: playerId,
      //           matchesCount: 3,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now().add(
      //             const Duration(days: 2),
      //           ),
      //           initialMatchId: 5,
      //         );

      //         // add matches for non player, just to test filtering
      //         final afterTomorrowMatchesNonPlayer = _generatePlayerTestMatches(
      //           playerId: nonPlayerId,
      //           matchesCount: 3,
      //           playersPerMatchCount: 5,
      //           initialMatchDate: DateTime.now().add(
      //             const Duration(days: 2),
      //           ),
      //           initialMatchId: 8,
      //         );

      //         final followingMatches = tomorrowMatches + afterTomorrowMatches;
      //         final allMatches = todayMatches +
      //             followingMatches +
      //             afterTomorrowMatchesNonPlayer;

      //         // add matches to db manually
      //         await isarWrapper.db.writeTxn(() async {
      //           await isarWrapper.db
      //               .collection<MatchLocalEntity>()
      //               .putAll(allMatches);
      //         });

      //         // result should be of lenght 6 - 3 matches from tomorrow and 3 matches from after tomorrow
      //         final result =
      //             await matchesLocalDataSource.getUpcomingMatchesForPlayer(
      //           playerId: playerId,
      //         );

      //         expect(result, equals(followingMatches));
      //       },
      //     );
      //   },
      // );
      // TODO -- old end ///////////////
    },
  );
}

// List<MatchLocalEntity> _generatePlayerTestMatches({
//   required int playerId,
//   required int matchesCount,
//   required int playersPerMatchCount,
//   required DateTime initialMatchDate,
//   required int initialMatchId,
// }) {
//   final testMatchesToday = List.generate(
//     matchesCount,
//     (matchIndex) {
//       final todayMatchPlayers = List.generate(
//         playersPerMatchCount,
//         (playerIndex) {
//           // current player can be only one of the players
//           final isCurrentPlayer = playerIndex == 2;

//           return getTestMatchLocalPlayerEntity(
//             id: isCurrentPlayer ? playerId : playerIndex,
//             stringFieldsPrefix: "today_",
//           );
//         },
//       );

//       final matchId = initialMatchId + matchIndex;
//       final match = getTestMatchLocalEntity(
//           id: matchId,
//           firstMatchDate: initialMatchDate.add(
//             Duration(hours: matchIndex),
//           ),
//           arrivingPlayers: todayMatchPlayers);

//       return match;
//     },
//   );

//   return testMatchesToday;
// }

// class _MockIsarWrapper extends Mock implements IsarWrapper {}
