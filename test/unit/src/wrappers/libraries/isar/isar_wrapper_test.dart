import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/path_provider/path_provider_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/data/entities.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // initialize db

  // dont forget to delete all from db after each test

  // close db at the end

  // final dbDirectory = await const PathProviderWrapper().getTempDirectory();
  // TODO extract this somewhere
  final dbDirectory = Directory.systemTemp;
  final isarWrapper = IsarWrapper(
    dbDirectory: Future.value(dbDirectory),
    databaseName: DatabaseNameConstants.DB_NAME_TEST,
  );

  setUpAll(() async {
    // TODO this exists - is good, no need to use _db
    // Isar.getInstance().collection();
    await isarWrapper.initializeForTests();
  });

  tearDown(() async {
    // TODO use the wrapper for this
    Isar.getInstance()?.writeTxn(() async {
      Isar.getInstance()?.clear();
    });
    // await isarWrapper.db.clear();
  });

  tearDownAll(() async {
    await isarWrapper.close(shouldDeleteDatabase: true);
  });
  group(
    "IsarWrapper",
    () {
      group(
        ".put()",
        () {
          test(
            "given an entity"
            "when .put() is called"
            "should put the entity in the database",
            () async {
              final AuthDataEntity entity = testAuthDataEntity;

              final storedEntityId =
                  await isarWrapper.putEntity<AuthDataEntity>(entity: entity);

              print("hello");

              // final storedEntityId =
              //     await Isar.getInstance()?.writeTxn(() async {
              //   return await Isar.getInstance()
              //       ?.collection<AuthDataEntity>()
              //       .put(entity);
              // });

              // final retrievedEntity = await Isar.getInstance()
              //     ?.collection<AuthDataEntity>()
              //     .get(storedEntityId!);

              final retrievedEntity = await isarWrapper.db
                  .collection<AuthDataEntity>()
                  .get(storedEntityId);

              expect(entity.id, equals(retrievedEntity?.id));
            },
          );
        },
      );
    },
  );
}
