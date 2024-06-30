import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';

class PlayerMatchModelsOverviewValue extends Equatable {
  // TODO this class might be an overkill
// TODO this ensures that all period matches are retrieved in one go
  const PlayerMatchModelsOverviewValue({
    required this.upcomingMatches,
    required this.todayMatches,
    required this.pastMatches,
  });

  final List<MatchModel> upcomingMatches;
  final List<MatchModel> todayMatches;
  final List<MatchModel> pastMatches;

  @override
  List<Object?> get props => [upcomingMatches, todayMatches, pastMatches];
}
