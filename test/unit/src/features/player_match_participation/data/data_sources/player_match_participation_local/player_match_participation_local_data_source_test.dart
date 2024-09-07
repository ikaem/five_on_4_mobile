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
        ".storeParticipations()",
        () {
          test(
            "given list of [PlayerMatchParticipationLocalEntityValue] "
            "when [.storeParticipations()] is called "
            "then should store participations",
            () async {
              // setup

              // given
              // TODO check why in test (maybe in production too) we actually CAN insert participation with match and player id that does not exist? is this a bug, or maybe memory and sqlite work like that? check it later
              final playerMatchParticipationValues = List.generate(3, (index) {
                return PlayerMatchParticipationLocalEntityValue(
                  matchId: 1,
                  playerId: index,
                  id: index,
                  playerNickname: "playerNickname$index",
                  status: PlayerMatchParticipationStatus.values[index],
                );
              });

              // when
              await dataSource.storeParticipations(
                playerMatchParticipationValues: playerMatchParticipationValues,
              );

              // then
              final expectedResults = playerMatchParticipationValues
                  .map(
                    (playerMatchParticipationValue) =>
                        PlayerMatchParticipationLocalEntityData(
                      id: playerMatchParticipationValue.id,
                      status: playerMatchParticipationValue.status,
                      playerId: playerMatchParticipationValue.playerId,
                      matchId: playerMatchParticipationValue.matchId,
                      playerNickname:
                          playerMatchParticipationValue.playerNickname,
                    ),
                  )
                  .toList();

              final select = testDatabaseWrapper
                  .databaseWrapper.playerMatchParticipationRepo
                  .select();
              final participations = await select.get();

              expect(participations, equals(expectedResults));

              // cleanup
            },
          );

          test(
            "given list of [PlayerMatchParticipationLocalEntityValue] exists in the database "
            "when [.storeParticipations()] is called with updated values of the same participations "
            "then should update the existing participations",
            () async {
              // setup
              final playerMatchParticipationValues = List.generate(3, (index) {
                return PlayerMatchParticipationLocalEntityValue(
                  matchId: 1,
                  playerId: index,
                  id: index,
                  playerNickname: "playerNickname$index",
                  status: PlayerMatchParticipationStatus.pendingDecision,
                );
              });

              // given
              await dataSource.storeParticipations(
                playerMatchParticipationValues: playerMatchParticipationValues,
              );

              // when
              final updatedPlayerMatchParticipationValues =
                  playerMatchParticipationValues
                      .map(
                        (playerMatchParticipationValue) =>
                            PlayerMatchParticipationLocalEntityValue(
                          matchId: playerMatchParticipationValue.matchId,
                          playerId: playerMatchParticipationValue.playerId,
                          id: playerMatchParticipationValue.id,
                          playerNickname:
                              playerMatchParticipationValue.playerNickname,
                          // updating status
                          status: PlayerMatchParticipationStatus.arriving,
                        ),
                      )
                      .toList();

              await dataSource.storeParticipations(
                playerMatchParticipationValues:
                    updatedPlayerMatchParticipationValues,
              );

              // then
              final expectedResults = playerMatchParticipationValues
                  .map(
                    (playerMatchParticipationValue) =>
                        PlayerMatchParticipationLocalEntityData(
                      id: playerMatchParticipationValue.id,
                      status: PlayerMatchParticipationStatus.arriving,
                      playerId: playerMatchParticipationValue.playerId,
                      matchId: playerMatchParticipationValue.matchId,
                      playerNickname:
                          playerMatchParticipationValue.playerNickname,
                    ),
                  )
                  .toList();

              final select = testDatabaseWrapper
                  .databaseWrapper.playerMatchParticipationRepo
                  .select();
              final participations = await select.get();

              expect(participations, equals(expectedResults));

              // cleanup
            },
          );

          test(
            "given list of [PlayerMatchParticipationLocalEntityValue] "
            "when [.storeParticipations()] is called "
            "then should return expected ids",
            () async {
              // setup

              // given
              // TODO check why in test (maybe in production too) we actually CAN insert participation with match and player id that does not exist? is this a bug, or maybe memory and sqlite work like that? check it later
              final playerMatchParticipationValues = List.generate(3, (index) {
                return PlayerMatchParticipationLocalEntityValue(
                  matchId: 1,
                  playerId: index,
                  id: index,
                  playerNickname: "playerNickname$index",
                  status: PlayerMatchParticipationStatus.values[index],
                );
              });

              // when
              final ids = await dataSource.storeParticipations(
                playerMatchParticipationValues: playerMatchParticipationValues,
              );

              // then
              expect(ids, equals([0, 1, 2]));

              // cleanup
            },
          );
        },
      );

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
