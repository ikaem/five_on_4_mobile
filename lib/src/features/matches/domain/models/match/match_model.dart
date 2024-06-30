// TODO use freezed or equatable later
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/players/models/player/player_model.dart';

class MatchModel extends Equatable {
  const MatchModel({
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.location,
    required this.description,
    // TODO come back to this
    // required this.organizer,
    // required this.arrivingPlayers,
  });

  final int id;
  final String title;
  final DateTime dateAndTime;
  final String location;
  final String description;
  // final String organizer;
  // final List<PlayerModel> arrivingPlayers;

  @override
  List<Object?> get props => [
        id,
        title,
        dateAndTime,
        location,
        // organizer,
        // arrivingPlayers,
      ];
}
