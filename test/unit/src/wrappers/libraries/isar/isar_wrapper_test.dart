import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../utils/data/entities.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // TODO extract this somewhere
  final dbDirectory = Directory.systemTemp;
  final isarWrapper = IsarWrapper(
    dbDirectory: Future.value(dbDirectory),
    databaseName: DatabaseNameConstants.DB_NAME_TEST,
  );

  setUpAll(() async {
    await isarWrapper.initializeForTests();
    await isarWrapper.initialize();
  });

  tearDown(() async {
    await isarWrapper.db.writeTxn(() async {
      await isarWrapper.db.clear();
    });
  });

  tearDownAll(() async {
    await isarWrapper.close(shouldDeleteDatabase: true);
  });
  group(
    "IsarWrapper",
    () {
      group(
        ".putEntity()",
        () {
          test(
            "given an entity"
            "when .putEntity() is called"
            "should put the entity in the database",
            () async {
              final AuthDataEntity entity = testAuthDataEntity;

              final storedEntityId =
                  await isarWrapper.putEntity<AuthDataEntity>(entity: entity);

              final retrievedEntity = await isarWrapper.db
                  .collection<AuthDataEntity>()
                  .get(storedEntityId);

              expect(entity.id, equals(retrievedEntity?.id));
            },
          );
        },
      );

      group(
        ".getEntity()",
        () {
          test(
            "given an id and entity type"
            "when .getEntity() is called"
            "should retrieve expected entity from the database",
            () async {
              final AuthDataEntity entity = testAuthDataEntity;

              // prepare db
              final id = await isarWrapper.db.writeTxn(
                () async {
                  final id = await isarWrapper.db
                      .collection<AuthDataEntity>()
                      .put(entity);
                  return id;
                },
              );

              final retrievedEntity =
                  await isarWrapper.getEntity<AuthDataEntity>(
                id: id,
              );

              expect(entity.id, equals(retrievedEntity?.id));
            },
          );
        },
      );

      group(
        ".getEntities()",
        () {
          test(
            "given an entity type"
            "when .getEntities() is called"
            "should retrieve all existing entities from the database",
            () async {
              final AuthDataEntity entity = testAuthDataEntity;

              // prepare db
              await isarWrapper.db.writeTxn(
                () async {
                  await isarWrapper.db.collection<AuthDataEntity>().put(entity);
                },
              );

              final retrievedEntities =
                  await isarWrapper.findAllEntities<AuthDataEntity>();

              expect(retrievedEntities, isNotEmpty);
              expect(retrievedEntities.first!.id, equals(entity.id));
            },
          );
        },
      );
    },
  );
}
