import 'dart:io';

import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';

/// Sets up a test database using Isar.
///
/// This function
///
/// - initializes a test database in the current directory,
/// using the specified database name for testing.
///
/// - after each test it clears the database.
///
/// - after all tests it closes the database and deletes it.
///
/// - returns an instance of the IsarWrapper for the test database.
IsarWrapper setupTestDb() {
  // The directory where the database will be created.
  final dbDirectory = Directory.current;

  // Create an instance of IsarWrapper for the test database.
  final isarWrapper = IsarWrapper(
    dbDirectory: Future.value(dbDirectory),
    databaseName: DatabaseNameConstants.DB_NAME_TEST,
  );

  // Before all tests, initialize the IsarWrapper for testing and then initialize it.
  setUpAll(() async {
    await isarWrapper.initializeForTests();
    await isarWrapper.initialize();
  });

  // After each test, clear the database.
  tearDown(() async {
    await isarWrapper.db.writeTxn(() async {
      await isarWrapper.db.clear();
    });
  });

  // After all tests, close the database and delete it.
  tearDownAll(() async {
    await isarWrapper.close(shouldDeleteDatabase: true);
  });

  // Return the IsarWrapper instance.
  return isarWrapper;
}
