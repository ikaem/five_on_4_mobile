import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/core/data/entities/isar_local/isar_local_entity.dart';
import 'package:isar/isar.dart';

part "match_local_entity.g.dart";

@Collection(inheritance: false)
class MatchLocalEntity extends Equatable implements IsarLocalEntity {
  const MatchLocalEntity({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.description,
    required this.arrivingPlayers,
  });

  // Actual match id from remote server db
  final Id id;

  @Index(name: "date_index")
  final int date;
  final String name;
  final String location;
  final String organizer;
  final String description;
  // @Index(name: "arriving_players_index")
  final List<MatchLocalPlayerEntity> arrivingPlayers;

  @ignore
  @override
  List<Object?> get props => [
        id,
        date,
        name,
        location,
        organizer,
        description,
        arrivingPlayers,
      ];
}

@Embedded(inheritance: false)
class MatchLocalPlayerEntity extends Equatable {
  const MatchLocalPlayerEntity({
    this.playerId,
    this.name,
    this.nickname,
    this.avatarUrl,
  });

  /// Actual player id from remote server db
  final int? playerId;
  final String? name;
  final String? nickname;
  final String? avatarUrl;

  @ignore
  @override
  List<Object?> get props => [
        playerId,
        name,
        nickname,
        avatarUrl,
      ];
}
