import 'package:drift/native.dart';
import 'package:five_on_4_mobile/src/wrappers/local/database/database_wrapper.dart';

// TODO this wrapper might not even be needed
class TestDatabaseWrapper {
  TestDatabaseWrapper({required DatabaseWrapper databaseWrapper})
      : _databaseWrapper = databaseWrapper;

  final DatabaseWrapper _databaseWrapper;
}

// TODO there is no need for this to be async
Future<TestDatabaseWrapper> setupTestDatabase() async {
  final db = DatabaseWrapper(
    queryExecutor: NativeDatabase.memory(),
  );

// TODO THERE IS no async things happening here
  await db.initialize();

  final TestDatabaseWrapper testDatabaseWrapper = TestDatabaseWrapper(
    databaseWrapper: db,
  );

  return testDatabaseWrapper;
}
