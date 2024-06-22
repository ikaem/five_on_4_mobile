import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/features/auth/data/entities/authenticated_player_local/authenticated_player_local_entity.dart';
import 'package:five_on_4_mobile/src/features/matches/data/entities/match_local/match_local_entity.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/migrations/migration_wrapper.dart';

part "app_database.g.dart";

@DriftDatabase(
  tables: [
    AuthenticatedPlayerLocalEntity,
    MatchLocalEntity,
  ],
  queries: {
    "current_timestamp": "SELECT CURRENT_TIMESTAMP;",
  },
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    super.e,
  );

  final MigrationWrapper _migrationWrapper = MigrationWrapper();

  // @override
  // SimpleSelectStatement<T, R> select<T extends HasResultSet, R>(ResultSetImplementation<T, R> table, {bool distinct = false}) {
  //   // TODO: implement select
  //   return super.select(table, distinct);
  // }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => _migrationWrapper.migration;
}
