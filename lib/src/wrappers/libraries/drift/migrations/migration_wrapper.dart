// to make it easier to modify this instead of modify the Database file directly

import 'package:drift/drift.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/drift/migrations/schema_versions/schema_versions.dart';

class MigrationWrapper {
  final MigrationStrategy migration = MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    // TODO no need until migration exists
    // onUpgrade: stepByStep(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.matchLocalEntity);
      },
    ),
    beforeOpen: (details) async {
      // some populate things if needed
    },
  );
}
