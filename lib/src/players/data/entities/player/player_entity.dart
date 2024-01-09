import 'package:isar/isar.dart';

part "player_entity.g.dart";

@collection
class PlayerEntity {
  const PlayerEntity({
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
