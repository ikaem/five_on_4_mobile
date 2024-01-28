// TODO use freezed or equatable later
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

class MatchModel {
  const MatchModel({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.arrivingPlayers,
  });

  final int id;
  final DateTime date;
  final String name;
  final String location;
  final String organizer;
  final List<PlayerModel> arrivingPlayers;
  // TODO add match description field here and into entitiry
}
