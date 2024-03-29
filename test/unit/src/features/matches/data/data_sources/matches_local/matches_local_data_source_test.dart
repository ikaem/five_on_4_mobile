import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/exceptions/match_exceptions.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/helpers/db/setup_db.dart';
import '../../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  // final isarWrapper = _MockIsarWrapper();
  final isarWrapper = setupTestDb();

  // TODO create helper for this

  final matchesLocalDataSource = MatchesLocalDataSourceImpl(
    isarWrapper: isarWrapper,
  );

  group(
    "MatchesLocalDataSource",
    () {
      group(
        ".getMatch()",
        () {
          test(
            "given a match id with no match in the database"
            "when '.getMatch() is called"
            "then should throw expected exception",
            () {
              // Given
              const id = 999;

              // When / Then
              expectLater(
                  () => matchesLocalDataSource.getMatch(matchId: id),
                  // throwsExceptionWithMessage,
                  throwsExceptionWithMessage<MatchNotFoundException>(
                    "Match with id: $id not found",
                  ));
            },
          );

          test(
            "given a valid match id"
            "when '.getMatch() is called"
            "then should retrieve the match from the database",
            () async {
              // setup - save match to db
              final testMatch = getTestMatchLocalEntities(count: 1).first;
              await isarWrapper.db.writeTxn(() async {
                await isarWrapper.db.matchLocalEntitys.put(testMatch);
              });

              // Given
              final id = testMatch.id;

              // When
              final result = await matchesLocalDataSource.getMatch(matchId: id);

              // Then
              expect(result, equals(testMatch));
            },
          );
        },
      );

      group(
        ".saveMatch()",
        () {
          test(
            "given a match"
            "when '.saveMatch() is called"
            "then should save the match to the database",
            () async {
              final testMatch = getTestMatchLocalEntities(count: 1).first;
              final id = testMatch.id;

              await matchesLocalDataSource.saveMatch(match: testMatch);

              final result = await isarWrapper.db.matchLocalEntitys
                  .where()
                  .idEqualTo(id)
                  .findFirst();

              expect(result, equals(testMatch));
            },
          );

          test(
            "given a match"
            "when '.saveMatch() is called"
            "then should return expected id",
            () async {
              final testMatch = getTestMatchLocalEntities(count: 1).first;
              final id = testMatch.id;

              final storedMatchId =
                  await matchesLocalDataSource.saveMatch(match: testMatch);

              expect(storedMatchId, equals(id));
            },
          );
        },
      );

      group(
        ".saveMatches()",
        () {
          test(
            "given a list of [MatchLocalEntity]s"
            "when '.saveMatches() is called"
            "should save the matches to the database",
            () async {
              final testMatches = getTestMatchLocalEntities(count: 3);
              final ids = testMatches.map((match) => match.id).toList();

              await matchesLocalDataSource.saveMatches(matches: testMatches);

              final result =
                  await isarWrapper.db.matchLocalEntitys.where().findAll();

              expect(result, equals(testMatches));
            },
          );
        },
      );

      group(".getPastMatchesForPlayer()", () {
        test(
          "given user joined 2 matches yesterday"
          "when .getPastMatchesForPlayer is called"
          "should retrieve current users matches from the database",
          () async {
            const playerId = 999;
            const someOtherPlayerId = 2;

            final testMatchesToday = _generatePlayerTestMatches(
              playerId: playerId,
              matchesCount: 2,
              playersPerMatchCount: 5,
              initialMatchDate: DateTime.now(),
              initialMatchId: 0,
            );

            final anotherPlayerMatchesToday = _generatePlayerTestMatches(
              playerId: someOtherPlayerId,
              matchesCount: 2,
              playersPerMatchCount: 5,
              initialMatchDate: DateTime.now(),
              initialMatchId: 2,
            );

            final testMatchesYesterday = _generatePlayerTestMatches(
              playerId: playerId,
              matchesCount: 2,
              playersPerMatchCount: 5,
              initialMatchDate: DateTime.now().subtract(
                const Duration(days: 1),
              ),
              initialMatchId: 4,
            );

            final allMatches = testMatchesToday +
                testMatchesYesterday +
                anotherPlayerMatchesToday;

            // add matches to db manually
            await isarWrapper.db.writeTxn(() async {
              await isarWrapper.db
                  .collection<MatchLocalEntity>()
                  .putAll(allMatches);
            });

            final result = await matchesLocalDataSource.getPastMatchesForPlayer(
              playerId: playerId,
            );

            expect(result, equals(testMatchesYesterday));
          },
        );
      });

      group(
        ".getTodayMatchesForPlayer()",
        () {
          test(
            "given user joined 2 matches today"
            "when .getTodayMatchesForPlayer is called "
            "should retrieve current users matches from the database",
            () async {
              const playerId = 999;
              const someOtherPlayerId = 2;

              // TODO abstract and shorten this for all by inserting all matches at once in a helper function
              // and then the function should return the matches that we will compare to tesult - base on argument we give it

              final testMatchesToday = _generatePlayerTestMatches(
                playerId: playerId,
                matchesCount: 2,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now(),
                initialMatchId: 0,
              );

              final anotherPlayerMatchesToday = _generatePlayerTestMatches(
                playerId: someOtherPlayerId,
                matchesCount: 2,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now(),
                initialMatchId: 2,
              );

              final testMatchesTomorrow = _generatePlayerTestMatches(
                playerId: playerId,
                matchesCount: 2,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 1),
                ),
                initialMatchId: 4,
              );

              final allMatches = testMatchesToday +
                  testMatchesTomorrow +
                  anotherPlayerMatchesToday;

              // add matches to db manually
              await isarWrapper.db.writeTxn(() async {
                await isarWrapper.db
                    .collection<MatchLocalEntity>()
                    .putAll(allMatches);
              });

              final result =
                  await matchesLocalDataSource.getTodayMatchesForPlayer(
                playerId: playerId,
              );

              expect(result, equals(testMatchesToday));
            },
          );
        },
      );

      group(
        ".getFollowingMatchesForPlayer()",
        () {
          test(
            "given current user joined 6 matches starting from tomorrow"
            "when .getFollowingMatchesForPlayer() is called"
            "should retrieve current users matches starting from tomorrow from the database",
            () async {
              // TODO simplify or shorten this somehow
              const playerId = 999;
              const nonPlayerId = 2;
              // generate todays matches
              final todayMatches = _generatePlayerTestMatches(
                playerId: playerId,
                matchesCount: 2,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now(),
                initialMatchId: 0,
              );
              // generate tomorrows matches
              final tomorrowMatches = _generatePlayerTestMatches(
                playerId: playerId,
                matchesCount: 3,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 1),
                ),
                initialMatchId: 2,
              );
              final afterTomorrowMatches = _generatePlayerTestMatches(
                playerId: playerId,
                matchesCount: 3,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 2),
                ),
                initialMatchId: 5,
              );

              // add matches for non player, just to test filtering
              final afterTomorrowMatchesNonPlayer = _generatePlayerTestMatches(
                playerId: nonPlayerId,
                matchesCount: 3,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 2),
                ),
                initialMatchId: 8,
              );

              final followingMatches = tomorrowMatches + afterTomorrowMatches;
              final allMatches = todayMatches +
                  followingMatches +
                  afterTomorrowMatchesNonPlayer;

              // add matches to db manually
              await isarWrapper.db.writeTxn(() async {
                await isarWrapper.db
                    .collection<MatchLocalEntity>()
                    .putAll(allMatches);
              });

              // result should be of lenght 6 - 3 matches from tomorrow and 3 matches from after tomorrow
              final result =
                  await matchesLocalDataSource.getUpcomingMatchesForPlayer(
                playerId: playerId,
              );

              expect(result, equals(followingMatches));
            },
          );
        },
      );
    },
  );
}

List<MatchLocalEntity> _generatePlayerTestMatches({
  required int playerId,
  required int matchesCount,
  required int playersPerMatchCount,
  required DateTime initialMatchDate,
  required int initialMatchId,
}) {
  final testMatchesToday = List.generate(
    matchesCount,
    (matchIndex) {
      final todayMatchPlayers = List.generate(
        playersPerMatchCount,
        (playerIndex) {
          // current player can be only one of the players
          final isCurrentPlayer = playerIndex == 2;

          return getTestMatchLocalPlayerEntity(
            id: isCurrentPlayer ? playerId : playerIndex,
            stringFieldsPrefix: "today_",
          );
        },
      );

      final matchId = initialMatchId + matchIndex;
      final match = getTestMatchLocalEntity(
          id: matchId,
          firstMatchDate: initialMatchDate.add(
            Duration(hours: matchIndex),
          ),
          arrivingPlayers: todayMatchPlayers);

      return match;
    },
  );

  return testMatchesToday;
}

class _MockIsarWrapper extends Mock implements IsarWrapper {}
