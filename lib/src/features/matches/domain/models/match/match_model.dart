// TODO use freezed or equatable later
import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/models/player_match_participation/player_match_participation_model.dart';
import 'package:five_on_4_mobile/src/features/players/domain/models/player/player_model.dart';

class MatchModel extends Equatable {
  const MatchModel({
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.location,
    required this.description,
    required this.participations,
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
  // TODO this will eventually be removed, as we will be fetching participations separately from match
  final List<PlayerMatchParticipationModel> participations;

  @override
  List<Object?> get props => [
        id,
        title,
        dateAndTime,
        location,
        description,
        participations,
        // organizer,
        // arrivingPlayers,
      ];
}
