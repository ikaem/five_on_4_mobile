import 'package:five_on_4_mobile/src/features/matches/data/data_sources/matches_local/matches_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/setup_db.dart';

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
        ".getMyFollowingMatches()",
        () {
          test(
            "given current user joined 6 matches starting from tomorrow"
            "when .getMyMatches() is called"
            "should retrieve current users matches starting from tomorrow from the database",
            () async {
              const playerId = 1;
              // generate todays matches
              final todayMatches = _generateCurrentPlayerTestMatches(
                playerId: playerId,
                matchesCount: 2,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now(),
              );
              // generate tomorrows matches
              final tomorrowMatches = _generateCurrentPlayerTestMatches(
                playerId: playerId,
                matchesCount: 3,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 1),
                ),
              );
              final afterTomorrowMatches = _generateCurrentPlayerTestMatches(
                playerId: playerId,
                matchesCount: 3,
                playersPerMatchCount: 5,
                initialMatchDate: DateTime.now().add(
                  const Duration(days: 2),
                ),
              );

              final followingMatches = tomorrowMatches + afterTomorrowMatches;
              final allMatches = todayMatches + followingMatches;

              // add matches to db manually
              await isarWrapper.db.writeTxn(() async {
                await isarWrapper.db
                    .collection<MatchLocalEntity>()
                    .putAll(allMatches);
              });

              final result = await matchesLocalDataSource.getMyFollowingMatches(
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

List<MatchLocalEntity> _generateCurrentPlayerTestMatches({
  required int playerId,
  required int matchesCount,
  required int playersPerMatchCount,
  required DateTime initialMatchDate,
}) {
  final testMatchesToday = List.generate(
    matchesCount,
    (index) {
      final todayMatchPlayers = List.generate(
        playersPerMatchCount,
        (index) {
          // current player can be only one of the players
          final isCurrentPlayer = index == 2;

          return getTestMatchLocalPlayerEntity(
            id: isCurrentPlayer ? playerId : index,
            stringFieldsPrefix: "today_",
          );
        },
      );

      final match = getTestMatchLocalEntity(
          firstMatchDate: initialMatchDate.add(
            Duration(hours: index),
          ),
          arrivingPlayers: todayMatchPlayers);

      return match;
    },
  );

  return testMatchesToday;
}

class _MockIsarWrapper extends Mock implements IsarWrapper {}
