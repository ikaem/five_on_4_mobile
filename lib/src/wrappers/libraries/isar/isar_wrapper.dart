import 'dart:io';

import 'package:five_on_4_mobile/src/features/auth/data/entities/auth_data/auth_data_entity.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/database_name_constants.dart';
import 'package:five_on_4_mobile/src/players/data/entities/player/player_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarWrapper {
  IsarWrapper({
    required Future<Directory> dbDirectory,
    required DatabaseNameConstants databaseName,
  })  : _dbDirectory = dbDirectory,
        _databaseName = databaseName;

  final Future<Directory> _dbDirectory;
  final DatabaseNameConstants _databaseName;

  late final Isar _db;
  Isar get db => _db;

  @visibleForTesting
  Future<void> initializeForTests() async {
    // AS PER https://github.com/isar/isar#unit-tests and https://stackoverflow.com/questions/76769136/flutter-isar-db-initialization-error-could-not-download-isarcore-library
    await Isar.initializeIsarCore(download: true);
    await initialize();
  }

  Future<void> initialize() async {
    // TODO might be better to pass this as argument to this function
    // TODO we could also use it to make sure test db is used - or pass it different test param to create new db
    // final dir = await getApplicationDocumentsDirectory();

    final directory = await _dbDirectory;

    final db = await Isar.open(
      [
        AuthDataEntitySchema,
      ],
      directory: directory.path,
      name: _databaseName.value,
    );

    _db = db;
  }

  Future<bool> close({
    bool shouldDeleteDatabase = false,
  }) {
    return _db.close(deleteFromDisk: shouldDeleteDatabase);
  }

  // TODO test only -> remove this
  Future<void> createPlayer() async {
    // final PlayerEntity player = PlayerEntity()..id = 1..firstName = "John"..
    const PlayerEntity player = PlayerEntity(
      id: 1,
      firstName: "John",
      lastName: "Doe",
      nickname: "JD",
    );
  }
}
