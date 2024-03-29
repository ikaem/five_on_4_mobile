import 'package:isar/isar.dart';

part "player_local_entity.g.dart";

// TODO this should be a local entity only
@collection
class PlayerLocalEntity {
  const PlayerLocalEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
  });

  final Id id;

  final String firstName;
  final String lastName;
  final String nickname;
}
