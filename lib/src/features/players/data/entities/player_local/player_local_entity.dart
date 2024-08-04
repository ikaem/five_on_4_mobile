// // TODO we are adding a new entity
// import 'package:drift/drift.dart';

import 'package:drift/drift.dart';

class PlayerLocalEntity extends Table {
  IntColumn get id => integer()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get nickname => text()();
  TextColumn get avatarUrl => text()();

  @override
  Set<Column> get primaryKey => {id};
}









// -------- OLD ------------
// import 'package:isar/isar.dart';

// part "player_local_entity.g.dart";

// // TODO this should be a local entity only
// @collection
// class PlayerLocalEntity {
//   const PlayerLocalEntity({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.nickname,
//     // TODO for now, we dont want to store auth id
//   });

//   final Id id;

//   final String firstName;
//   final String lastName;
//   final String nickname;
// }
