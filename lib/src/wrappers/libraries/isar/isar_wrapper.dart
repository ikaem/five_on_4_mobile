import 'dart:ffi';
import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/data_sources/auth_local/auth_local_data_source_impl.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/players/data/entities/player/player_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import "package:path/path.dart" as path;

class IsarWrapper {
  IsarWrapper({
    required Future<Directory> dbDirectory,
    required DatabaseNameConstants databaseName,
  })  : _dbDirectory = dbDirectory,
        _databaseName = databaseName;

  final Future<Directory> _dbDirectory;
  final DatabaseNameConstants _databaseName;

  @visibleForTesting
  late final Isar db;
  // TODO only use for testing to be able to verify db state after manipulation
  // @visibleForTesting
  // Isar get db => _db;

  Future<void> initialize() async {
    // TODO might be better to pass this as argument to this function
    // TODO we could also use it to make sure test db is used - or pass it different test param to create new db
    // final dir = await getApplicationDocumentsDirectory();

    final directory = await _dbDirectory;

    db = await Isar.open(
      [
        AuthDataEntitySchema,
      ],
      directory: directory.path,
      name: _databaseName.value,
    );
  }

// TODO T has to be entity - maybe it would be good to have some abstract Entity class
  Future<int> putEntity<T>({
    required T entity,
  }) async {
    final putId = await db.writeTxn(() async {
      final id = await db.collection<T>().put(entity);
      return id;
    });

    return putId;
  }

  Future<bool> close({
    bool shouldDeleteDatabase = false,
  }) {
    return db.close(deleteFromDisk: shouldDeleteDatabase);
  }

  // TODO test only -> remove this
  // Future<void> createPlayer() async {
  //   // final PlayerEntity player = PlayerEntity()..id = 1..firstName = "John"..
  //   const PlayerEntity player = PlayerEntity(
  //     id: 1,
  //     firstName: "John",
  //     lastName: "Doe",
  //     nickname: "JD",
  //   );

  // TODO maybe move test initializer to extension
  // TODO docs for isar test
  // https://github.com/isar/isar/discussions/230

  @visibleForTesting // TODO we will see if this is needed
  Future<void> initializeForTests() async {
    // TODO this is dirtying this wrapper with another lib
    // final dartToolDir = path.join(Directory.current.path, '.dart_tool', "libs");

    const pathToLibs =
        "/Users/karlo/development/mine/five_on_4/five_on_4_mobile/.dart_tool/isar_test/libs";

    // AS PER https://github.com/isar/isar#unit-tests and https://stackoverflow.com/questions/76769136/flutter-isar-db-initialization-error-could-not-download-isarcore-library
    // await Isar.initializeIsarCore(download: true);
    // TODO where to download libs
    await Isar.initializeIsarCore(
      // download: true,
      libraries: {
        // Abi.windowsX64: path.join(dartToolDir, 'libisar_windows_x64.dll'),
        // Abi.macosX64: path.join(dartToolDir, 'libisar_macos_x64.dylib'),
        Abi.macosArm64: path.join(pathToLibs, 'libisar.dylib'),
        // Abi.linuxX64: path.join(dartToolDir, 'libisar_linux_x64.so'),
      },
    );
    await initialize();
  }
  // }
}
