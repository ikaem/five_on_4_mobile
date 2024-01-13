import 'dart:ffi';
import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
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

  Future<void> initialize() async {
    final directory = await _dbDirectory;

    db = await Isar.open(
      [
        AuthDataEntitySchema,
      ],
      directory: directory.path,
      name: _databaseName.value,
    );
  }

  Future<T?> getEntity<T>({
    required int id,
  }) async {
    final entity = await db.txn<T?>(() async {
      final entity = await db.collection<T>().get(id);
      return entity;
    });

    return entity;
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

  @visibleForTesting
  Future<void> initializeForTests() async {
    final dartToolDir =
        path.join(Directory.current.path, '.dart_tool', "isar_test", "libs");

    // https://github.com/isar/isar/discussions/230
    // AS PER https://github.com/isar/isar#unit-tests and https://stackoverflow.com/questions/76769136/flutter-isar-db-initialization-error-could-not-download-isarcore-library
    // await Isar.initializeIsarCore(download: true);
    // TODO where to download libs
    await Isar.initializeIsarCore(
      libraries: {
        Abi.macosArm64: path.join(dartToolDir, 'libisar.dylib'),
        // Abi.windowsX64: path.join(dartToolDir, 'libisar_windows_x64.dll'),
        // Abi.macosX64: path.join(dartToolDir, 'libisar_macos_x64.dylib'),
        // Abi.linuxX64: path.join(dartToolDir, 'libisar_linux_x64.so'),
      },
    );
  }
}
