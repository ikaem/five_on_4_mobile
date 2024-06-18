import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/sqlite_delegated_database_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "database_wrapper_provider.g.dart";

@riverpod
DatabaseWrapper databaseWrapper(
  DatabaseWrapperRef ref,
) {
  final sqliteDelegatedDatabaseWrapper = SqliteDelegatedDatabaseWrapper();

  final databaseWrapper = DatabaseWrapper(
    queryExecutor: sqliteDelegatedDatabaseWrapper.queryExecutor,
  );

  return databaseWrapper;
}
