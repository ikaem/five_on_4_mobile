import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/players/domain/exceptions/players_exceptions.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../../utils/helpers/test_database/setup_test_database.dart';
import '../../../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() {
  late TestDatabaseWrapper testDatabaseWrapper;

  // tested clas
  late PlayersLocalDataSource playersLocalDataSource;

  setUp(() async {
    testDatabaseWrapper = await setupTestDatabase();
    playersLocalDataSource = PlayersLocalDataSourceImpl(
        databaseWrapper: testDatabaseWrapper.databaseWrapper);
  });

  tearDown(() async {
    await testDatabaseWrapper.databaseWrapper.close();
  });

  group(
    "$PlayersLocalDataSource",
    () {
      group(".storePlayer()", () {
        test(
          "given [PlayerLocalEntityValue]"
          "when [.storePlayer()] is called"
          "then should save the player to the database",
          () async {
            // setup

            // given
            const playerValue = PlayerLocalEntityValue(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              nickname: "JD",
              avatarUrl:
                  "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
            );

            // when
            await playersLocalDataSource.storePlayer(playerValue: playerValue);

            // then
            // TODO abstract this somehow in tests - maybe for test db have this funxtion
            // TODO when all is done, then create additojnal wrapper around general db, to have functions there that we need - so that we now have full interface ovder db wrapper, and can just repalce db when needed
            final SimpleSelectStatement<$PlayerLocalEntityTable,
                    PlayerLocalEntityData> select =
                testDatabaseWrapper.databaseWrapper.playerLocalRepo.select();
            final SimpleSelectStatement<$PlayerLocalEntityTable,
                PlayerLocalEntityData> findMatchSelect = select
              ..where((tbl) => tbl.id.equals(playerValue.id));

            final PlayerLocalEntityData? playerData =
                await findMatchSelect.getSingleOrNull();

            final PlayerLocalEntityData expectedPlayerData =
                PlayerLocalEntityData(
              id: playerValue.id,
              firstName: playerValue.firstName,
              lastName: playerValue.lastName,
              nickname: playerValue.nickname,
              avatarUrl: playerValue.avatarUrl,
            );

            expect(playerData, equals(expectedPlayerData));

            // cleanup
          },
        );

        test(
          "given [PlayerLocalEntityValue] already stored in db"
          "when [.storePlayer()] is called with updated values of the same [PlayerLocalEntityValue]"
          "then should updated the existing player",
          () async {
            // setup
            const playerValue = PlayerLocalEntityValue(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              nickname: "JD",
              avatarUrl:
                  "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
            );

            // given
            await playersLocalDataSource.storePlayer(playerValue: playerValue);

            // when
            final PlayerLocalEntityValue updatedPlayerValue =
                PlayerLocalEntityValue(
              id: playerValue.id,
              firstName: "${playerValue.firstName} updated",
              lastName: "${playerValue.lastName} updated",
              nickname: "${playerValue.nickname} updated",
              avatarUrl: "${playerValue.avatarUrl} updated",
            );

            await playersLocalDataSource.storePlayer(
              playerValue: updatedPlayerValue,
            );

            // then
            final SimpleSelectStatement<$PlayerLocalEntityTable,
                    PlayerLocalEntityData> select =
                testDatabaseWrapper.databaseWrapper.playerLocalRepo.select();
            final SimpleSelectStatement<$PlayerLocalEntityTable,
                PlayerLocalEntityData> findMatchSelect = select
              ..where((tbl) => tbl.id.equals(playerValue.id));

            final PlayerLocalEntityData? playerData =
                await findMatchSelect.getSingleOrNull();

            final PlayerLocalEntityData expectedPlayerData =
                PlayerLocalEntityData(
              id: updatedPlayerValue.id,
              firstName: updatedPlayerValue.firstName,
              lastName: updatedPlayerValue.lastName,
              nickname: updatedPlayerValue.nickname,
              avatarUrl: updatedPlayerValue.avatarUrl,
            );

            expect(playerData, equals(expectedPlayerData));

            // cleanup
          },
        );

        test(
          "given [PlayerLocalEntityValue]"
          "when [.storePlayer()] is called"
          "then should return expected id",
          () async {
            // setup

            // given
            const playerValue = PlayerLocalEntityValue(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              nickname: "JD",
              avatarUrl:
                  "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
            );

            // when
            final id = await playersLocalDataSource.storePlayer(
                playerValue: playerValue);

            // then
            expect(id, equals(playerValue.id));

            // cleanup
          },
        );
      });

      group(".getPlayer()", () {
        test(
          "given a player id with no matching player stored in db"
          "when [.getPlayer()] is called"
          "then should throw expected exception",
          () async {
            // setup

            // given
            const playerId = 999;

            // when & then
            expect(
              () async {
                await playersLocalDataSource.getPlayer(playerId: playerId);
              },
              throwsExceptionWithMessage<PlayersExceptionPlayerNotFound>(
                "Player with id $playerId not found",
              ),
            );

            // cleanup
          },
        );

        test(
          "given a player id with matching player stored in db"
          "when [.getPlayer()] is called"
          "then should return expected player",
          () async {
            // setup
            const PlayerLocalEntityData playerData = PlayerLocalEntityData(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              nickname: "JD",
              avatarUrl:
                  "https://images.unsplash.com/photo-1471864167314-e5f7e37e404c",
            );

            // given

            await testDatabaseWrapper.databaseWrapper.playerLocalRepo
                .insertOne(playerData);

            final playerId = playerData.id;

            // when
            final player = await playersLocalDataSource.getPlayer(
              playerId: playerId,
            );

            // then
            final expectedPlayer = PlayerLocalEntityValue(
              id: playerData.id,
              firstName: playerData.firstName,
              lastName: playerData.lastName,
              nickname: playerData.nickname,
              avatarUrl: playerData.avatarUrl,
            );

            expect(player, equals(expectedPlayer));

            // cleanup
          },
        );
      });

      group(
        ".getPlayers()",
        () {
          test(
            "given [PlayerLocalEntity]s stored in db"
            "when [.getPlayers()] is called with ids of stored [PlayerLocalEntity]s"
            "then should return expected players",
            () async {
              // setup
              final playerEntities = List.generate(3, (i) {
                return PlayerLocalEntityData(
                  id: i + 1,
                  firstName: "name $i",
                  lastName: "last name $i",
                  nickname: "nickname $i",
                  avatarUrl: "https://example.com/$i",
                );
              });
              final playerIds = playerEntities.map((e) {
                return e.id;
              }).toList();

              // given
              await testDatabaseWrapper.databaseWrapper.playerLocalRepo
                  .insertAll(playerEntities);

              // when
              final players = await playersLocalDataSource.getPlayers(
                playerIds: playerIds,
              );

              // then
              final expectedPlayers = playerEntities.map((e) {
                return PlayerLocalEntityValue(
                  id: e.id,
                  firstName: e.firstName,
                  lastName: e.lastName,
                  nickname: e.nickname,
                  avatarUrl: e.avatarUrl,
                );
              }).toList();

              expect(players, equals(expectedPlayers));

              // cleanup
            },
          );

          test(
            "given [PlayerLocalEntity]s NOT stored in db"
            "when [.getPlayers()] is called with those matches ids"
            "then should return an empty list",
            () async {
              // setup
              final playerIds = List.generate(3, (i) {
                return i + 1;
              });

              // given

              // when
              final players = await playersLocalDataSource.getPlayers(
                playerIds: playerIds,
              );

              // then
              expect(players, isEmpty);

              // cleanup
            },
          );

          test(
            "given [PlayerLocalEntity]s stored in db"
            "when [.getPlayers()] is called with ids of some stored [PlayerLocalEntity]s"
            "then should return expected results",
            () async {
              // setup
              final playerEntities = List.generate(3, (i) {
                return PlayerLocalEntityData(
                  id: i + 1,
                  firstName: "name $i",
                  lastName: "last name $i",
                  nickname: "nickname $i",
                  avatarUrl: "https://example.com/$i",
                );
              });
              final playerIds = playerEntities.map((e) {
                return e.id;
              }).toList()
                ..add(playerEntities.length + 1);

              // given
              await testDatabaseWrapper.databaseWrapper.playerLocalRepo
                  .insertAll(playerEntities);

              // when
              final players = await playersLocalDataSource.getPlayers(
                playerIds: playerIds,
              );

              // then
              final expectedPlayers = playerEntities.map((e) {
                return PlayerLocalEntityValue(
                  id: e.id,
                  firstName: e.firstName,
                  lastName: e.lastName,
                  nickname: e.nickname,
                  avatarUrl: e.avatarUrl,
                );
              }).toList();
              expect(players.length, equals(playerEntities.length));
              expect(players, equals(expectedPlayers));

              // cleanup
            },
          );
        },
      );

      group(
        ".storePlayers()",
        () {
          test(
            "given multiple [PlayerLocalEntityValue]s"
            "when [.storePlayers()] is called"
            "then should store matches to the db",
            () async {
              // setup

              // given
              final entityValues = List.generate(3, (i) {
                return PlayerLocalEntityValue(
                  id: i + 1,
                  firstName: "name $i",
                  lastName: "last name $i",
                  nickname: "nickname $i",
                  avatarUrl: "https://example.com/$i",
                );
              });

              // when
              await playersLocalDataSource.storePlayers(
                matchValues: entityValues,
              );

              // then
              final expectedEntitiesData = entityValues.map((e) {
                return PlayerLocalEntityData(
                  id: e.id,
                  firstName: e.firstName,
                  lastName: e.lastName,
                  nickname: e.nickname,
                  avatarUrl: e.avatarUrl,
                );
              }).toList();

              final actualData = await testDatabaseWrapper
                  .databaseWrapper.playerLocalRepo
                  .select()
                  .get();

              expect(actualData, equals(expectedEntitiesData));

              // cleanup
            },
          );
          test(
            "given multiple [PlayerLocalEntityValue]s"
            "when [.storePlayers()] is called"
            "then should return a list of ids",
            () async {
              // setup

              // given
              final entityValues = List.generate(3, (i) {
                return PlayerLocalEntityValue(
                  id: i + 1,
                  firstName: "name $i",
                  lastName: "last name $i",
                  nickname: "nickname $i",
                  avatarUrl: "https://example.com/$i",
                );
              });

              // when
              final ids = await playersLocalDataSource.storePlayers(
                matchValues: entityValues,
              );

              // then
              final expectedIds = entityValues.map((e) {
                return e.id;
              }).toList();

              expect(ids, equals(expectedIds));

              // cleanup
            },
          );

          test(
            "given multiple [PlayerLocalEntity]s already stored"
            "when [.storePlayers()] is called with updated values on same [PlayerLocalEntity]s"
            "then should updated existing players",
            () async {
              // setup
              final entityValues = List.generate(3, (i) {
                return PlayerLocalEntityValue(
                  id: i + 1,
                  firstName: "name $i",
                  lastName: "last name $i",
                  nickname: "nickname $i",
                  avatarUrl: "https://example.com/$i",
                );
              });

              // given
              await playersLocalDataSource.storePlayers(
                matchValues: entityValues,
              );

              // when
              final updatedValues = entityValues.map((e) {
                return PlayerLocalEntityValue(
                  id: e.id,
                  firstName: "${e.firstName} updated",
                  lastName: "${e.lastName} updated",
                  nickname: "${e.nickname} updated",
                  avatarUrl: "${e.avatarUrl} updated",
                );
              }).toList();

              await playersLocalDataSource.storePlayers(
                matchValues: updatedValues,
              );

              // then
              final expectedEntitiesData = updatedValues.map((e) {
                return PlayerLocalEntityData(
                  id: e.id,
                  firstName: e.firstName,
                  lastName: e.lastName,
                  nickname: e.nickname,
                  avatarUrl: e.avatarUrl,
                );
              }).toList();

              // get all data from db
              final actualData = await testDatabaseWrapper
                  .databaseWrapper.playerLocalRepo
                  .select()
                  .get();

              expect(actualData, equals(expectedEntitiesData));

              // cleanup
            },
          );
        },
      );
    },
  );
}
