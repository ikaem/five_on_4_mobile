part of "get_my_matches_controller.dart";

class MatchesControllerState extends Equatable {
  const MatchesControllerState({
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
