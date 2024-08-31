import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match/match_participants_container.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_local/player_match_participation_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/data_sources/player_match_participation_local/player_match_participation_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/data/entities/player_match_participation_local/player_match_participation_local_entity.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/helpers/test_database/setup_test_database.dart';

void main() {
  late TestDatabaseWrapper testDatabaseWrapper;

  // tested class
  late PlayerMatchParticipationLocalDataSource dataSource;

  setUp(() async {
    testDatabaseWrapper = await setupTestDatabase();
    dataSource = PlayerMatchParticipationLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() async {
    await testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    "$PlayerMatchParticipationLocalDataSource",
    () {
      group(
        ".storeParticipation()",
        () {
          // shoud store participation
          test(
            "given [PlayerMatchParticipationLocalEntityValue] "
            "when [.storeParticipation()] is called "
            "then should store participation",
            () async {
              // setup

              // given
              const playerMatchParticipationValue =
                  PlayerMatchParticipationLocalEntityValue(
                matchId: 1,
                playerId: 1,
                id: 1,
                playerNickname: "playerNickname",
                status: PlayerMatchParticipationStatus.arriving,
              );

              // when
              await dataSource.storeParticipation(
                playerMatchParticipationValue: playerMatchParticipationValue,
              );

              // then
              final select = testDatabaseWrapper
                  .databaseWrapper.playerMatchParticipationRepo
                  .select();
              final participationSelect = select
                ..where((select) => select.id.equals(1));
              final participation = await participationSelect.getSingleOrNull();

              final expectedResult = PlayerMatchParticipationLocalEntityData(
                id: playerMatchParticipationValue.id,
                status: playerMatchParticipationValue.status,
                playerId: playerMatchParticipationValue.playerId,
                matchId: playerMatchParticipationValue.matchId,
                playerNickname: playerMatchParticipationValue.playerNickname,
              );

              expect(participation, equals(expectedResult));

              // cleanup
            },
          );

          // should update participation
          test(
            "given [PlayerMatchParticipationLocalEntityValue] exists in the database "
            "when [.storeParticipation()] is called with updated values of the same participation "
            "then should update the existing participation",
            () async {
              // setup
              const playerMatchParticipationValue =
                  PlayerMatchParticipationLocalEntityValue(
                matchId: 1,
                playerId: 1,
                id: 1,
                playerNickname: "playerNickname",
                status: PlayerMatchParticipationStatus.pendingDecision,
              );

              // given
              await dataSource.storeParticipation(
                playerMatchParticipationValue: playerMatchParticipationValue,
              );

              // when
              final updatedPlayerMatchParticipationValue =
                  PlayerMatchParticipationLocalEntityValue(
                matchId: playerMatchParticipationValue.matchId,
                playerId: playerMatchParticipationValue.playerId,
                id: playerMatchParticipationValue.id,
                playerNickname: "playerNickname",
                // updating status
                status: PlayerMatchParticipationStatus.arriving,
              );

              await dataSource.storeParticipation(
                playerMatchParticipationValue:
                    updatedPlayerMatchParticipationValue,
              );

              // then
              final select = testDatabaseWrapper
                  .databaseWrapper.playerMatchParticipationRepo
                  .select();
              final participationSelect = select
                ..where((select) => select.id.equals(1));
              final participation = await participationSelect.getSingleOrNull();

              final expectedResult = PlayerMatchParticipationLocalEntityData(
                id: updatedPlayerMatchParticipationValue.id,
                status: updatedPlayerMatchParticipationValue.status,
                playerId: updatedPlayerMatchParticipationValue.playerId,
                matchId: updatedPlayerMatchParticipationValue.matchId,
                playerNickname:
                    updatedPlayerMatchParticipationValue.playerNickname,
              );

              expect(participation, equals(expectedResult));

              // cleanup
            },
          );

          // should return id
          test(
            "given [PlayerMatchParticipationLocalEntityValue] "
            "when [.storeParticipation()] is called "
            "then should return expected participation id",
            () async {
              // setup

              // given
              const playerMatchParticipationValue =
                  PlayerMatchParticipationLocalEntityValue(
                matchId: 1,
                playerId: 1,
                id: 1,
                playerNickname: "playerNickname",
                status: PlayerMatchParticipationStatus.arriving,
              );

              // when
              final id = await dataSource.storeParticipation(
                playerMatchParticipationValue: playerMatchParticipationValue,
              );

              // then
              expect(id, equals(playerMatchParticipationValue.id));

              // cleanup
            },
          );
        },
      );
    },
  );
}
