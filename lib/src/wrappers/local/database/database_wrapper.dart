import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_local/authenticated_player_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/app_database.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/sqlite_delegated_database_wrapper.dart';

// TODO this should probably be moved to drfit rapper library
class DatabaseWrapper {
  DatabaseWrapper({
    required QueryExecutor queryExecutor,
  }) : _queryExecutor = queryExecutor;

  final QueryExecutor _queryExecutor;

  factory DatabaseWrapper.createDefault() {
    return DatabaseWrapper(
      queryExecutor: SqliteDelegatedDatabaseWrapper().queryExecutor,
    );
  }

  AppDatabase? _db;

  AppDatabase get db {
    final initializedDb = _db;
    if (initializedDb == null) {
      throw Exception("Database not initialized");
    }

    return initializedDb;
  }

  // db repositories (tables) will be here
  $AuthenticatedPlayerLocalEntityTable get authenticatedPlayerRepo =>
      db.authenticatedPlayerLocalEntity;

  Future<void> initialize() async {
    try {
      final db = AppDatabase(_queryExecutor);

      final dbCurrentTime = await db.current_timestamp().get();
      // TODO log instead
      print("DB current time: $dbCurrentTime");

      _db = db;
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
