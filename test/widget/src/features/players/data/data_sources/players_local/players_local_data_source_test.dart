import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/players/data/data_sources/players_local/players_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/players/domain/values/player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../../utils/helpers/test_database/setup_test_database.dart';

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
      group(
        ".getPlayers",
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
        ".storeMatches/()",
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
