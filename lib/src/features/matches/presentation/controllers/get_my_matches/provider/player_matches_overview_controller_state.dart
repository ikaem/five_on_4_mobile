part of 'get_my_matches_overview_controller.dart';

// TODO THIS SHOULD live elsewhare as well - it will be reused for other players - move elesehwere when needed
class PlayerMatchesOverviewControllerState extends Equatable {
  const PlayerMatchesOverviewControllerState({
    required this.isRemoteFetchDone,
    required this.todayMatches,
    required this.upcomingMatches,
    required this.pastMatches,
  });

  final bool isRemoteFetchDone;
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
