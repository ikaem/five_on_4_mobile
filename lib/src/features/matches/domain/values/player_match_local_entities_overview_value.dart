import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_local_entity_value.dart';

class PlayerMatchLocalEntitiesOverviewValue extends Equatable {
// TODO this class might be an overkill
// TODO this ensures that all period matches are retrieved in one go

  const PlayerMatchLocalEntitiesOverviewValue({
    required this.upcomingMatches,
    required this.todayMatches,
    required this.pastMatches,
  });

  final List<MatchLocalEntityValue> upcomingMatches;
  final List<MatchLocalEntityValue> todayMatches;
  final List<MatchLocalEntityValue> pastMatches;

  @override
  List<Object?> get props => [upcomingMatches, todayMatches, pastMatches];
}
