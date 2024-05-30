import 'package:drift/drift.dart';

class AuthenticatedPlayerLocalEntity extends Table {
  IntColumn get playerId => integer().autoIncrement()();
  TextColumn get playerName => text()();
  TextColumn get playerNickname => text()();
}
