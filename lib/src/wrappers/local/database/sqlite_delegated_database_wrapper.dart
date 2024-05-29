import 'dart:io';

import 'package:drift/backends.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import "package:sqlite3/sqlite3.dart";

class SqliteDelegatedDatabaseWrapper {
  QueryExecutor get queryExecutor {
    final LazyDatabase lazyDatabase = LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, "db.sqlite"));

      // fix limitations on old android devices
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // all from documentation
      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });

    return lazyDatabase;
  }
}
