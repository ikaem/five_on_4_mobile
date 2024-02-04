import 'dart:ffi';
import 'dart:io';

import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/isar/isar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import "package:path/path.dart" as path;

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
    final libsDir = await _getIsarLibsDir();
    await isarWrapper.initializeForTests(testDbLibsFolder: libsDir);
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

Future<Directory> _getIsarLibsDir() async {
  final projectRootPath = (await Process.run(
    "git",
    ["rev-parse", "--show-toplevel"],
  ))
      .stdout
      .toString()
      .trim();

  final Directory libsDir =
      Directory(path.join(projectRootPath, "test", "utils", "db", "libs"));

  return libsDir;
}

extension on IsarWrapper {
  Future<void> initializeForTests({
    required Directory testDbLibsFolder,
  }) async {
    final macosArm64LibPath = path.join(testDbLibsFolder.path, 'libisar.dylib');

    // https://github.com/isar/isar/discussions/230
    // AS PER https://github.com/isar/isar#unit-tests and https://stackoverflow.com/questions/76769136/flutter-isar-db-initialization-error-could-not-download-isarcore-library
    // https://github.com/isar/isar/issues/1119 - where do download libs
    // download libs here too https://github.com/isar/isar/releases?page=2
    // await Isar.initializeIsarCore(download: true);
    // TODO where to download libs
    // TODO hide folder inside somewhere in tests folder and point to it there - so clean does not clean all
    await Isar.initializeIsarCore(
      libraries: {
        Abi.macosArm64: macosArm64LibPath
        // Abi.windowsX64: path.join(dartToolDir, 'libisar_windows_x64.dll'),
        // Abi.macosX64: path.join(dartToolDir, 'libisar_macos_x64.dylib'),
        // Abi.linuxX64: path.join(dartToolDir, 'libisar_linux_x64.so'),
      },
    );
  }
}
