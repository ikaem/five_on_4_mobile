import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/db/setup_db.dart';

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

      //         when(
      //           () => isarWrapper.putEntities<MatchLocalEntity>(
      //             entities: any(named: "entities"),
      //           ),
      //         ).thenAnswer(
      //           (invocation) async => ids,
      //         );

      //         final result = await matchesLocalDataSource.saveMatches(
      //             matches: testMatches);

      //         verify(
      //           () => isarWrapper.putEntities(
      //             entities: testMatches,
      //           ),
      //         ).called(1);
      //         expect(result, equals(ids));
      //       },
      //     );
      //   },
      // );

      group(
        ".getFollowingMatchesForPlayer()",
        () {
          test(
            "given current user joined 6 matches starting from tomorrow"
            "when .getFollowingMatchesForPlayer() is called"
            "should retrieve current users matches starting from tomorrow from the database",
            () async {
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
                  await matchesLocalDataSource.getFollowingMatchesForPlayer(
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
