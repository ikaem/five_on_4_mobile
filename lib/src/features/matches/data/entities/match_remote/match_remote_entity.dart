// TODO not sure if should have one entity for each type of data source or just one for both
// TODO possibly later use Equatable for this
import 'package:five_on_4_mobile/src/features/players/data/entities/player_remote/player_remote_entity.dart';

class MatchRemoteEntity {
  MatchRemoteEntity({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.description,
    required this.arrivingPlayers,
  });

  final int id;
  final int date;
  final String name;
  final String location;
  final String organizer;
  final String description;
  final List<PlayerRemoteEntity> arrivingPlayers;
}
