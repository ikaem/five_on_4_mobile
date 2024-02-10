import 'package:equatable/equatable.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';

class MatchesControllerStateValue extends Equatable {
  const MatchesControllerStateValue({
    required this.isRemoteFetchDone,
    // required this.matches,
    required this.todayMatches,
    required this.upcomingMatches,
    required this.pastMatches,
  });

  final bool isRemoteFetchDone;
  // final List<MatchModel> matches;
  final List<MatchModel> todayMatches;
  final List<MatchModel> upcomingMatches;
  final List<MatchModel> pastMatches;

  @override
  List<Object> get props => [
        isRemoteFetchDone,
        todayMatches,
        upcomingMatches,
        pastMatches,
      ];
}
