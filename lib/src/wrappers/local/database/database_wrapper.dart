import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';

class DatabaseWrapper {
  DatabaseWrapper({required QueryExecutor queryExecutor})
      : _queryExecutor = queryExecutor;

  final QueryExecutor _queryExecutor;

  AppDatabase? _db;

  AppDatabase get db {
    final initializedDb = _db;
    if (initializedDb == null) {
      throw Exception("Database not initialized");
    }

    return initializedDb;
  }

  // db repositories (tables) will be here

  Future<void> initialize() async {
    try {
      final db = AppDatabase(_queryExecutor);

      final dbCurrentTime = db.current_timestamp();
      // TODO log instead
      print("DB current time: $dbCurrentTime");
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }

  // TODO dont forget that drfit is supported by dev tools
  // https://drift.simonbinder.eu/docs/community_tools/#drift_db_viewer

  Future<T> transaction<T>(
    Future<T> Function() action, {
    bool requireNew = false,
  }) async {
    return db.transaction(action, requireNew: requireNew);
  }

  Future<void> close() async {
    await db.close();
  }
}
