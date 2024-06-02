import 'package:drift/drift.dart' hide isNull;
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source.dart';
import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_local/auth_local_entity.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:five_on_4_mobile/src/features/auth/domain/values/anthenticated_player_local_entity_value.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/flutter_secure_storage/flutter_secure_storage_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../../utils/data/test_entities.dart';
import '../../../../../../../utils/helpers/db/setup_db.dart';
import '../../../../../../../utils/helpers/secure_storage/setup_secure_storage.dart';
import '../../../../../../../utils/helpers/test_database/setup_test_database.dart';
import '../../../../../../../utils/matchers/throws_exception_with_message.dart';

void main() async {
  // final isarWrapper = setupTestDb();
  // final testDatabaseWrapper = await setupTestDatabase();
  // // final secureStorageWrapper = setupTestSecureStorage();
  // // final secureStorageWrapper = _MockFlutterSecureStorageWrapper();

  // final authLocalDataSource = AuthLocalDataSourceImpl(
  //   databaseWrapper: testDatabaseWrapper.databaseWrapper,
  //   // secureStorageWrapper: secureStorageWrapper,
  //   // secureStorageWrapper: secureStorageWrapper,
  //   // TODO this is outdated
  //   // isarWrapper: isarWrapper,
  // );

  // new -----------
  late TestDatabaseWrapper testDatabaseWrapper;

  // tested class
  late AuthLocalDataSource authLocalDataSource;

  setUp(() async {
    testDatabaseWrapper = await setupTestDatabase();

    authLocalDataSource = AuthLocalDataSourceImpl(
      databaseWrapper: testDatabaseWrapper.databaseWrapper,
    );
  });

  tearDown(() {
    // TODO is this going to delete all data?
    testDatabaseWrapper.databaseWrapper.close();
  });

  group("$AuthLocalDataSource", () {
    // get strea of authenticated player entity - from db
    group(".getAuthenticatedPlayerLocalEntityDataStream", () {
      test(
        "given a stream of AuthenticatedPlayerLocalEntityData"
        "when no elements in the db"
        "then should emit expected initial state",
        () async {
          // setup

          // given

          // then
          expectLater(
            authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream(),
            emitsInOrder([
              null,
              // equals([]),
            ]),
          );
        },
      );
      test(
        "given a stream of AuthenticatedPlayerLocalEntityData"
        "when add element to the db"
        "then should emit expected element",
        () async {
          // setup
          const entityData = AuthenticatedPlayerLocalEntityData(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );

          // given
          final stream =
              authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream();

          // then
          expectLater(
            stream,
            emitsInOrder([
              null,
              entityData,
            ]),
          );

          // when
          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .insertOne(entityData);

          // cleanup
        },
      );

      test(
        "given a stream of AuthenticatedPlayerLocalEntityData"
        "when remove elements from table with elements"
        "then should emit expected events",
        () async {
          // setup
          const entityData = AuthenticatedPlayerLocalEntityData(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );

          // given
          final stream =
              authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream();

          // then
          expectLater(
            stream,
            emitsInOrder([
              null,
              entityData,
              null,
            ]),
          );

          // then
          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .insertOne(entityData);

          await Future.delayed(Duration.zero);

          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .deleteAll();
        },
      );

      test(
        "given a stream of AuthenticatedPlayerLocalEntityData"
        "when remove elements from table without elements"
        "then should emit expected events",
        () async {
          // setup

          // given

          // then
          expectLater(
            authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream(),
            emitsInOrder([
              null,
            ]),
          );

          // when
          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .deleteAll();

          // cleanup
        },
      );

      test(
        "given a stream of AuthenticatedPlayerLocalEntityData"
        "when add multiple elements to the db table"
        "then should emit expected Exception",
        () async {
          // setup
          const entityData1 = AuthenticatedPlayerLocalEntityData(
            playerId: 1,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );
          const entityData2 = AuthenticatedPlayerLocalEntityData(
            playerId: 2,
            playerName: "playerName",
            playerNickname: "playerNickname",
          );

          // given
          final stream =
              authLocalDataSource.getAuthenticatedPlayerLocalEntityDataStream();

          // then
          expectLater(
            stream,
            emitsInOrder([
              null,
              entityData1,
              emitsError(
                  isA<AuthMultipleLocalAuthenticatedPlayersException>().having(
                (exception) {
                  return exception.message; // feature we want to check
                },
                "message", // description of the feature
                "Multiple local authenticated players found", // matcher - the actual error message
              ))
            ]),
          );

          // when
          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .insertOne(entityData1);
          await Future.delayed(Duration.zero);
          await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
              .insertOne(entityData2);

          // cleanup
        },
      );

      // TODO: not sure if this should happen -> should throw if there is more than one entity in db
    });

// store authenticated player entity
    group(
      ".storeAuthenticatedPlayerEntity",
      () {
        // should store it in db
        test(
          "given an AuthenticatedPlayerLocalEntityValue"
          "when '.storeAuthenticatedPlayerEntity()' is called"
          "then should store the entity in db",
          () async {
            // setup
            const playerId = 1;
            const playerName = "playerName";
            const playerNickname = "playerNickname";

            final authenticatedPlayerEntityValue =
                AuthenticatedPlayerLocalEntityValue(
              playerId: playerId,
              playerName: playerName,
              playerNickname: playerNickname,
            );

            // when
            await authLocalDataSource
                .storeAuthenticatedPlayerEntity(authenticatedPlayerEntityValue);

            // then
            const expectedAuthData = AuthenticatedPlayerLocalEntityData(
              playerId: playerId,
              playerName: playerName,
              playerNickname: playerNickname,
            );

            final select = testDatabaseWrapper
                .databaseWrapper.authenticatedPlayerRepo
                .select();
            final findAuth = select
              ..where((tbl) => tbl.playerId.equals(playerId));
            final authData = await findAuth.getSingle();

            expect(authData, equals(expectedAuthData));

            // cleanup
          },
        );
        // should return id of stored entity
        test(
          "given an AuthenticatedPlayerLocalEntityValue"
          "when '.storeAuthenticatedPlayerEntity()' is called"
          "then should return expected id",
          () async {
            // setup
            // TODO move these up - they are always same
            const playerId = 1;
            const playerName = "playerName";
            const playerNickname = "playerNickname";

            // given
            final authenticatedPlayerEntityValue =
                AuthenticatedPlayerLocalEntityValue(
              playerId: playerId,
              playerName: playerName,
              playerNickname: playerNickname,
            );

            // when
            final id = await authLocalDataSource
                .storeAuthenticatedPlayerEntity(authenticatedPlayerEntityValue);

            // then
            expect(id, equals(playerId));

            // cleanup
          },
        );

        // TODO just check how many entities are in the db
        test(
          "given other AuthenticatedPlayerLocalEntity objects in the database "
          "when '.storeAuthenticatedPlayerEntity()' is called"
          "then should remove any existing objects and only keep new one",
          () async {
            // setup
            // TODO create generatior for this
            const playerId = 1;
            const playerName = "playerName";
            const playerNickname = "playerNickname";

            final newAuthewnticatdPlayerEntityValue =
                AuthenticatedPlayerLocalEntityValue(
              playerId: playerId,
              playerName: playerName,
              playerNickname: playerNickname,
            );

            final existingObject =
                generateTestAuthenticatedPlayerLocalEntityCompanions(
              count: 1,
              namesPrefix: "existing_",
            ).first;

            // given
            await testDatabaseWrapper.databaseWrapper.authenticatedPlayerRepo
                .insertOne(existingObject);

            // when
            await authLocalDataSource.storeAuthenticatedPlayerEntity(
                newAuthewnticatdPlayerEntityValue);

            // then
            // get all elements
            final select = testDatabaseWrapper
                .databaseWrapper.authenticatedPlayerRepo
                .select();

            final allAuthData = await select.get();
            expect(allAuthData, hasLength(1));

            const expectedAuthData = AuthenticatedPlayerLocalEntityData(
              playerId: playerId,
              playerName: playerName,
              playerNickname: playerNickname,
            );
            expect(allAuthData.first, equals(expectedAuthData));

            // cleanup
          },
        );

        // should remove if any existing entity with same id
      },
    );

// get authenticated player entity

// get authenticated player entity stream

    // group(
    //   ".getAuthEntity()",
    //   () {
    //     // given there is no auth, retur null
    //     test(
    //       "given an auth entity with provided id does not exist in db"
    //       "when '.getAuthEntity()' is called"
    //       "then should return null",
    //       () async {
    //         // setup
    //         const id = 1;

    //         // given

    //         // when
    //         final result = await authLocalDataSource.getAuthEntity(id);

    //         // then
    //         expect(result, equals(null));

    //         // cleanup
    //       },
    //     );

    //     test(
    //       "given an auth entity with provided id exists in db"
    //       "when '.getAuthEntity()' is called"
    //       "then should return expected auth entity",
    //       () async {
    //         // setup
    //         final entity = getTestAuthLocalEntities(count: 1).first;

    //         // given
    //         final id = await isarWrapper.db.writeTxn(() async {
    //           return await isarWrapper.db.authLocalEntitys.put(entity);
    //         });

    //         // when
    //         final result = await authLocalDataSource.getAuthEntity(id);

    //         // then
    //         expect(result, equals(entity));

    //         // cleanup
    //       },
    //     );

    //     // given there is an auth, return the auth
    //   },
    // );

    // group(
    //   ".storeAuthEntity()",
    //   () {
    //     // should store it in db
    //     test(
    //       "given an auth entity"
    //       "when '.storeAuthEntity()' is called"
    //       "then should store the entity in db",
    //       () async {
    //         // setup

    //         // given
    //         final entity = getTestAuthLocalEntities(count: 1).first;

    //         // when
    //         await authLocalDataSource.storeAuthEntity(entity);

    //         // then
    //         final storedEntity = await isarWrapper.db.authLocalEntitys
    //             .where()
    //             .idEqualTo(entity.id)
    //             .findFirst();
    //         expect(storedEntity, equals(entity));

    //         // cleanup
    //       },
    //     );

    //     // should return the id of the stored entity
    //     test(
    //       "given an auth entity"
    //       "when '.storeAuthEntity()' is called"
    //       "then should return the id of the stored entity",
    //       () async {
    //         // setup

    //         // given
    //         final entity = getTestAuthLocalEntities(count: 1).first;

    //         // when
    //         final id = await authLocalDataSource.storeAuthEntity(entity);

    //         // then
    //         expect(id, equals(entity.id));

    //         // cleanup
    //       },
    //     );
    //   },
    // );

    // group(
    //   ".getLoggedInAuthLocalEntity()",
    //   () {
    //     // test(
    //     //   "given there is no authId in secure storage"
    //     //   "when '.getLoggedInAuthLocalEntity()' is called"
    //     //   "then should return null and clear authId from secure storage",
    //     //   () async {
    //     //     // setup

    //     //     // given

    //     //     // when
    //     //     final dbResult =
    //     //         await authLocalDataSource.getLoggedInAuthLocalEntity();
    //     //     final secureStorageResult = await secureStorageWrapper.getAuthId();

    //     //     // then
    //     //     expect(dbResult, equals(null));
    //     //     expect(secureStorageResult, equals(null));

    //     //     // cleanup
    //     //   },
    //     // );

    //     // test(
    //     //   "given an authId in secure storage and NO authDataEntity in db"
    //     //   "when '.getLoggedInAuthLocalEntity()' is called"
    //     //   "then should retur null and clear authId from secure storage",
    //     //   () async {
    //     //     // setup
    //     //     const authId = 1;

    //     //     // given
    //     //     await secureStorageWrapper.storeAuthId(authId);

    //     //     // when
    //     //     final dbResult =
    //     //         await authLocalDataSource.getLoggedInAuthLocalEntity();
    //     //     final secureStorageResult = await secureStorageWrapper.getAuthId();

    //     //     // then
    //     //     expect(dbResult, equals(null));
    //     //     expect(secureStorageResult, equals(null));

    //     //     // cleanup
    //     //   },
    //     // );

    //     // test(
    //     //   "given an authId in secure storage and NO matching authDataEntity in db"
    //     //   "when '.getLoggedInAuthLocalEntity()' is called"
    //     //   "then should retur null",
    //     //   () async {
    //     //     // setup
    //     //     const authId = 1;
    //     //     final nonMatchEntity = getTestAuthDataEntities(count: 1).first
    //     //       ..id = 2;
    //     //     // final nonMatchingEntity = AuthDataEntity(
    //     //     //   playerInfo: testAuthDataEntity.playerInfo,
    //     //     //   teamInfo: testAuthDataEntity.teamInfo,
    //     //     // )..id = 2;

    //     //     // given
    //     //     await secureStorageWrapper.storeAuthId(authId);
    //     //     await isarWrapper.db.writeTxn(() async {
    //     //       await isarWrapper.db.authDataEntitys.put(nonMatchEntity);
    //     //     });

    //     //     // when
    //     //     final result =
    //     //         await authLocalDataSource.getLoggedInAuthLocalEntity();

    //     //     // then
    //     //     expect(result, equals(null));

    //     //     // cleanup
    //     //   },
    //     // );

    //     test(
    //       "given an authId in secure storage and multiple "
    //       "when <behavior we are specifying>"
    //       "then should <state we expect to happen>",
    //       () {
    //         // setup

    //         // given

    //         // when

    //         // then

    //         // cleanup
    //       },
    //     );
    //   },
    // );

    // TODO this will probably go away
/*     // group(
    //   ".getAuthData()",
    //   () {
    //     // TODO these tests fail - fix them
    //     // TODO this will pass when authlocaldata source logic is uncommented
    //     test(
    //       "given authId and authToken stored in secure storage AND matching authDataEntity exists in isar"
    //       "when '.getAuthData() is called"
    //       "should return expected [AuthDataEntity]",
    //       () async {
    //         final entity = AuthDataEntity(
    //           playerInfo: testAuthDataEntity.playerInfo,
    //           teamInfo: testAuthDataEntity.teamInfo,
    //         )..id = 1;

    //         await secureStorageWrapper.storeAuthData(
    //           token: "authToken",
    //           authId: 1,
    //         );

    //         await isarWrapper.db.writeTxn(() async {
    //           await isarWrapper.db.authDataEntitys.put(entity);
    //         });

    //         final authDataEntity = await authLocalDataSource.getAuthData();

    //         expect(authDataEntity, equals(entity));
    //       },
    //     );

    //     // tests when not all data is present, or when data is not present
    //     // test then data is delete from secure stroage if something is off
    //   },
    // );

    // group(".setAuthData()", () {
    //   final draftEntity = testAuthDataEntity;

    //   test(
    //     "given draft of [AuthDataEntity] and authToken"
    //     "when '.setAuthData()' is called"
    //     "should store the draft in isar",
    //     () async {
    //       await authLocalDataSource.setAuthData(
    //         authDataEntityDraft: draftEntity,
    //         authToken: "authToken",
    //       );

    //       final storedEntities =
    //           await isarWrapper.db.authDataEntitys.where().findAll();

    //       expect(storedEntities.length, equals(1));
    //       expect(storedEntities.first, equals(draftEntity));
    //     },
    //   );

    //   test(
    //     "given draft of [AuthDataEntity] and authToken"
    //     "when '.setAuthData()' is called"
    //     "should store the authToken and authId in secure storage",
    //     () async {
    //       await authLocalDataSource.setAuthData(
    //         authDataEntityDraft: draftEntity,
    //         authToken: "authToken",
    //       );

    //       verify(
    //         () => secureStorageWrapper.storeAuthData(
    //           token: "authToken",
    //           authId: 1,
    //         ),
    //       ).called(1);
    //     },
    //   );
    // }); */
  });
}

class _MockFlutterSecureStorageWrapper extends Mock
    implements FlutterSecureStorageWrapper {}

class _MockIsarWrapper extends Mock implements IsarWrapper {}
