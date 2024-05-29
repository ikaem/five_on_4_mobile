import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/migrations/migration_wrapper.dart';

part "app_database.g.dart";

@DriftDatabase(
  tables: [],
  queries: {
    "current_timestamp": "SELECT CURRENT_TIMESTAMP;",
  },
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    super.e,
  );

  final MigrationWrapper _migrationWrapper = MigrationWrapper();

  @override
  int get schemaVersion => 1;

  MigrationStrategy get migration => _migrationWrapper.migration;
}
