import 'package:drift/drift.dart';

class AuthenticatedPlayerLocalEntity extends Table {
  // IntColumn get playerId => integer().autoIncrement()();
  // TODO not autoincrement because we want to store the playerId from the server
  IntColumn get playerId => integer()();
  TextColumn get playerName => text()();
  TextColumn get playerNickname => text()();

  @override
  Set<Column<Object>>? get primaryKey => {playerId};
}
