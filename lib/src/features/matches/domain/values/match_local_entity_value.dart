import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/player_match_participation/domain/values/player_match_participation_local_entity_value.dart';

/// Class to serve as a proxy between Drift used in data source and the domain layer that uses model
///
/// This is so as not to depend on the Drift library in the domain layer in case we want to change the database library
class MatchLocalEntityValue extends Equatable {
  const MatchLocalEntityValue({
    required this.id,
    required this.dateAndTime,
    required this.title,
    required this.location,
    required this.description,
    required this.participations,
  });

  final int id;
  final int dateAndTime;
  final String title;
  final String location;
  final String description;
  final List<PlayerMatchParticipationLocalEntityValue> participations;

  @override
  List<Object?> get props => [
        id,
        dateAndTime,
        title,
        location,
        description,
        participations,
      ];
}
