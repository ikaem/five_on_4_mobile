// to make it easier to modify this instead of modify the Database file directly

import 'package:drift/drift.dart';

class MigrationWrapper {
  final MigrationStrategy migration = MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    // TODO no need until migration exists
    // onUpgrade: stepByStep(),
    beforeOpen: (details) async {
      // some populate things if needed
    },
  );
}
