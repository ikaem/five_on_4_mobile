import 'dart:developer';
import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_remote/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../../../utils/data/test_entities.dart';
import '../../../../../utils/helpers/db/setup_db.dart';

// TODO here we should test some other stuff - maybe not directly putting stuff to db, but possibly
// - can open correctly
// - can close correctly
// - can delete db correctly
// - that db is in specified folder
// - that db is named correctly
// - that all schemas are registered

// TODO remove all tests tht actually deal with entities

void main() async {
  final isarWrapper = setupTestDb();

  group(
    "IsarWrapper",
    () {
      // group(
      //   "MatchLocalEntity",
      //   () {
      //     test(
      //       "given an instance of [MatchLocalEntity] "
      //       "when .putEntity() is called "
      //       "should put the entity in the database",
      //       () async {
      //         final matchLocalEntity =
      //             getTestMatchLocalEntities(count: 1).first;

      //         final storedEntityId =
      //             await isarWrapper.putEntity<MatchLocalEntity>(
      //           entity: matchLocalEntity,
      //         );

      //         final retrievedEntity = await isarWrapper.db
      //             .collection<MatchLocalEntity>()
      //             .get(storedEntityId);

      //         expect(matchLocalEntity.id, equals(retrievedEntity?.id));
      //       },
      //     );

      //     // test(
      //     //   "given a list of [MatchLocalEntity] "
      //     //   "when .putEntities() is called "
      //     //   "should put the entitities in the database",
      //     //   () async {
      //     //     final matchLocalEntities = getTestMatchLocalEntities(count: 3);

      //     //     final retrievedEntities = await isarWrapper.db
      //     //         .collection<MatchLocalEntity>()
      //     //         .where()
      //     //         .findAll();

      //     //     expect(
      //     //         retrievedEntities.length, equals(matchLocalEntities.length));
      //     //   },
      //     // );
      //   },
      // );
      // // TODO get rid of these - have each entity have its own group
      // group(
      //   ".putEntity()",
      //   () {
      //     test(
      //       "given an entity"
      //       "when .putEntity() is called"
      //       "should put the entity in the database",
      //       () async {
      //         final AuthDataEntity entity = testAuthDataEntity;

      //         final storedEntityId =
      //             await isarWrapper.putEntity<AuthDataEntity>(entity: entity);

      //         final retrievedEntity = await isarWrapper.db
      //             .collection<AuthDataEntity>()
      //             .get(storedEntityId);

      //         expect(entity.id, equals(retrievedEntity?.id));
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".getEntity()",
      //   () {
      //     test(
      //       "given an id and entity type"
      //       "when .getEntity() is called"
      //       "should retrieve expected entity from the database",
      //       () async {
      //         final AuthDataEntity entity = testAuthDataEntity;

      //         // prepare db
      //         final id = await isarWrapper.db.writeTxn(
      //           () async {
      //             final id = await isarWrapper.db
      //                 .collection<AuthDataEntity>()
      //                 .put(entity);
      //             return id;
      //           },
      //         );

      //         final retrievedEntity =
      //             await isarWrapper.getEntity<AuthDataEntity>(
      //           id: id,
      //         );

      //         expect(entity.id, equals(retrievedEntity?.id));
      //       },
      //     );
      //   },
      // );

      // group(
      //   ".getEntities()",
      //   () {
      //     test(
      //       "given an entity type"
      //       "when .getEntities() is called"
      //       "should retrieve all existing entities from the database",
      //       () async {
      //         final AuthDataEntity entity = testAuthDataEntity;

      //         // prepare db
      //         await isarWrapper.db.writeTxn(
      //           () async {
      //             await isarWrapper.db.collection<AuthDataEntity>().put(entity);
      //           },
      //         );

      //         final retrievedEntities =
      //             await isarWrapper.findAllEntities<AuthDataEntity>();

      //         expect(retrievedEntities, isNotEmpty);
      //         expect(retrievedEntities.first!.id, equals(entity.id));
      //       },
      //     );
      //   },
      // );

      // // TODO put entities
      // // TODO is there need that this should be groups? - maybe we provide somea rguments there, os it is worth to be groups
      // group(
      //   ".putEntities",
      //   () {
      //     test(
      //       "given a list of entities"
      //       "when .putEntities() is called"
      //       "should put all entities in the database",
      //       () async {
      //         final entities = getTestAuthDataEntities();

      //         final _ = await isarWrapper.putEntities<AuthDataEntity>(
      //             entities: entities);

      //         final retrievedEntities =
      //             await isarWrapper.findAllEntities<AuthDataEntity>();

      //         expect(retrievedEntities, isNotEmpty);
      //         // TODO not sure this tests very thoroughly
      //         expect(retrievedEntities.length, equals(entities.length));
      //       },
      //     );
      //   },
      // );
    },
  );
}
