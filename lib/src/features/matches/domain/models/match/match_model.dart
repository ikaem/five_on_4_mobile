// TODO use freezed or equatable later
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

class MatchModel extends Equatable {
  const MatchModel({
    required this.id,
    required this.date,
    required this.name,
    required this.location,
    required this.organizer,
    required this.arrivingPlayers,
    required this.description,
  });

  final int id;
  final DateTime date;
  final String name;
  final String location;
  final String organizer;
  final List<PlayerModel> arrivingPlayers;
  final String description;

  @override
  List<Object?> get props => [
        id,
        date,
        name,
        location,
        organizer,
        arrivingPlayers,
      ];
}
